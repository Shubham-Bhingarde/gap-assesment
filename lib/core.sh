#!/usr/bin/env bash
# lib/core.sh
# Core framework functions for CIS Assessment Tool

set -euo pipefail

# ANSI Color Codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Global Variables (to be set during initialization)
DATA_DIR=""
LOG_FILE=""
STATE_FILE=""
RESULTS_FILE=""

# Logging Functions
log_info() {
    local msg="[INFO] $(date +'%Y-%m-%d %H:%M:%S') - $1"
    echo -e "${GREEN}${msg}${NC}"
    if [ -n "$LOG_FILE" ]; then
        echo "$msg" >> "$LOG_FILE"
    fi
}

log_warn() {
    local msg="[WARN] $(date +'%Y-%m-%d %H:%M:%S') - $1"
    echo -e "${YELLOW}${msg}${NC}"
    if [ -n "$LOG_FILE" ]; then
        echo "$msg" >> "$LOG_FILE"
    fi
}

log_error() {
    local msg="[ERROR] $(date +'%Y-%m-%d %H:%M:%S') - $1"
    echo -e "${RED}${msg}${NC}"
    if [ -n "$LOG_FILE" ]; then
        echo "$msg" >> "$LOG_FILE"
    fi
}

# Trap handler for unexpected exits
cleanup() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log_error "Script exited unexpectedly with code $exit_code."
    else
        log_info "Execution completed successfully."
    fi
}
trap cleanup EXIT

# Ask User for Data Location
prompt_data_dir() {
    echo -e "${YELLOW}Where would you like to store the output data (logs, state, reports)?${NC}"
    read -p "Enter path [Default: $PWD/output]: " DATA_DIR

    if [ -z "$DATA_DIR" ]; then
        DATA_DIR="$PWD/output"
    fi

    # Ensure path is absolute
    if [[ "$DATA_DIR" != /* ]]; then
        DATA_DIR="$PWD/$DATA_DIR"
    fi

    # Create directories
    mkdir -p "$DATA_DIR/logs"
    mkdir -p "$DATA_DIR/state"
    mkdir -p "$DATA_DIR/reports"

    # Set file paths
    LOG_FILE="$DATA_DIR/logs/audit_$(date +%Y%m%d_%H%M%S).log"
    STATE_FILE="$DATA_DIR/state/status.json"
    RESULTS_FILE="$DATA_DIR/state/results.json"

    # Export for other scripts (like html_generator)
    export DATA_DIR

    log_info "Data directory initialized at: $DATA_DIR"
}

# Check OS and Sudo
check_environment() {
    if [[ $EUID -ne 0 ]]; then
        log_error "This script must be run as root or with sudo."
        exit 1
    fi

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID" != "ubuntu" ]] || [[ "$VERSION_ID" != "22.04" ]]; then
            log_warn "This framework is optimized for Ubuntu 22.04 LTS. Detected: $PRETTY_NAME"
            read -p "Do you want to continue anyway? (y/N): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                log_info "Aborting execution."
                exit 1
            fi
        else
            log_info "Detected OS: $PRETTY_NAME"
        fi
    else
        log_error "Unsupported OS. Could not find /etc/os-release."
        exit 1
    fi
}

# State Management
init_state() {
    if [ -f "$STATE_FILE" ]; then
        log_warn "Found existing execution state from a previous run at $STATE_FILE"
        read -p "Do you want to resume from the last checkpoint? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            log_info "Resuming from checkpoint..."
            return
        else
            log_info "Starting fresh. Archiving previous state."
            mv "$STATE_FILE" "$DATA_DIR/state/status_$(date +%s).json.bak" 2>/dev/null || true
            mv "$RESULTS_FILE" "$DATA_DIR/state/results_$(date +%s).json.bak" 2>/dev/null || true
        fi
    fi
    echo '{"completed_controls":[]}' > "$STATE_FILE"
    echo '[]' > "$RESULTS_FILE"
}

is_completed() {
    local control_id="$1"
    jq -e ".completed_controls | index(\"$control_id\")" "$STATE_FILE" > /dev/null
}

mark_completed() {
    local control_id="$1"
    local temp_file=$(mktemp)
    jq ".completed_controls += [\"$control_id\"]" "$STATE_FILE" > "$temp_file"
    mv "$temp_file" "$STATE_FILE"
}

# Save Result to JSON
save_result() {
    local control_id="$1"
    local title="$2"
    local expected="$3"
    local current="$4"
    local status="$5"
    local risk="$6"
    local remediation="$7"
    local description="$8"
    local attack="$9"

    local timestamp=$(date +'%Y-%m-%dT%H:%M:%SZ')

    local temp_file=$(mktemp)
    jq --arg cid "$control_id" \
       --arg tit "$title" \
       --arg exp "$expected" \
       --arg cur "$current" \
       --arg sta "$status" \
       --arg rsk "$risk" \
       --arg rem "$remediation" \
       --arg desc "$description" \
       --arg att "$attack" \
       --arg ts "$timestamp" \
       '. += [{
           "control_id": $cid,
           "title": $tit,
           "expected_status": $exp,
           "current_status": $cur,
           "compliance_result": $sta,
           "risk_level": $rsk,
           "remediation": $rem,
           "description": $desc,
           "attack_scenarios": $att,
           "timestamp": $ts
       }]' "$RESULTS_FILE" > "$temp_file"

    mv "$temp_file" "$RESULTS_FILE"
}

# Execution Engine
run_controls() {
    local control_dir="controls"
    if [ ! -d "$control_dir" ]; then
        log_error "Controls directory not found!"
        exit 1
    fi

    # Sorting ensures they run in order (1.1.1.1, 1.1.1.2, etc.)
    for control_script in $(ls -1 "$control_dir"/*.sh | sort -V); do
        if [ ! -f "$control_script" ]; then continue; fi

        # Extract ID from filename, e.g., "1.1.1.1_cramfs.sh" -> "1.1.1.1"
        local control_id=$(basename "$control_script" | awk -F'_' '{print $1}')

        if is_completed "$control_id"; then
            log_info "Skipping $control_id (Already completed)"
            continue
        fi

        log_info "Executing control: $control_id"

        # Source the control script to execute its logic
        # It must define a function execute_control
        (
            source "$control_script"
            execute_control
        )

        local rc=$?
        if [ $rc -eq 0 ]; then
            mark_completed "$control_id"
        else
            log_error "Control $control_id failed with exit code $rc. Execution halted to allow resume later."
            exit $rc
        fi
    done
}
