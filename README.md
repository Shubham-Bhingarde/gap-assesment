# CIS Ubuntu Linux 22.04 LTS Gap Assessment Automation

This repository provides an enterprise-grade, resumable, and modular bash framework for automating the CIS Benchmark (v3.0.0) gap assessment for Ubuntu 22.04 LTS.

## Features

- **Modular Architecture**: Each CIS control is an independent shell script located in the `controls/` directory.
- **Resumable Execution**: The framework natively saves its execution state into JSON using `jq`. If a script fails or the system reboots, the framework asks if you want to resume execution exactly where it left off.
- **Offline HTML Reporting**: Generates a professional, interactive, color-coded HTML report using embedded CSS and JavaScript. No external CDNs are required, making it safe for air-gapped environments.
- **Defensive Scripting**: Implements `set -euo pipefail` and extensive trap handling to ensure minimal operational impact.

## Controls Covered

This framework currently includes **321 controls**.
- 3 controls (`1.1.1.1`, `1.1.1.2`, and `1.1.1.7`) are fully implemented with the exact system audit checks required by the CIS PDF.
- The remaining 318 controls have been auto-generated as **stub scripts** covering the entire CIS appendix. This allows developers to immediately add specific audit commands without writing boilerplate for every new control.

## Requirements

- Root or `sudo` privileges.
- Operating System: Ubuntu 22.04 LTS (the framework actively checks `/etc/os-release`).
- Dependencies: `jq` (will prompt or should be installed via `apt-get install -y jq`).

## Usage

**How to run this script:**

1. Make sure all scripts have execute permissions:
```bash
chmod +x main.sh lib/core.sh html_generator/generate_html.sh controls/*.sh
```

2. Run the main orchestrator script with sudo:
```bash
sudo ./main.sh
```

3. **Prompt for Data Directory**: The script will ask where to store the outputs (logs, state JSON, and reports). By default, it will create an `output/` directory in the current working path.
4. **Execution**: The framework will sequentially run through all `controls/*.sh` files in alphabetical order.
5. **HTML Generation**: Once all controls complete, it aggregates the `results.json` into a timestamped HTML report located in your chosen data directory under `reports/`.

## Framework Structure

- `main.sh`: The execution entry point. Orchestrates the process.
- `lib/core.sh`: Core libraries for state management, colored logging, JSON writing, and the execution engine.
- `controls/`: Directory containing standalone Bash scripts for each CIS control ID (e.g., `1.1.1.1_cramfs.sh`).
- `html_generator/generate_html.sh`: Parses the final JSON state and merges it into the HTML template.
- `templates/report.html`: The interactive HTML blueprint for the report.
