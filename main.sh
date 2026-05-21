#!/usr/bin/env bash
# main.sh
# Entrypoint for the CIS Gap Assessment Automation Tool

# Defensive scripting
set -euo pipefail

# Ensure we're in the right directory
SCRIPT_DIR=$(dirname "$(realpath "$0")")
cd "$SCRIPT_DIR"

# Source the core library
if [ -f "lib/core.sh" ]; then
    source "lib/core.sh"
else
    echo -e "\033[0;31m[ERROR] Cannot find lib/core.sh\033[0m"
    exit 1
fi

echo "==================================================================="
echo "        CIS Ubuntu Linux 22.04 LTS Benchmark Gap Assessment        "
echo "==================================================================="

# 1. Check permissions and OS
check_environment

# 2. Prompt for Data Directory Location
prompt_data_dir

# 3. Initialize State (Resumable check)
init_state

# 4. Run Controls
log_info "Starting control execution..."
run_controls

# 5. Generate HTML Report
log_info "All controls executed successfully."
log_info "Generating HTML Report..."

if [ -f "html_generator/generate_html.sh" ]; then
    bash "html_generator/generate_html.sh"
else
    log_error "HTML Generator script not found."
fi

log_info "Process completed."
