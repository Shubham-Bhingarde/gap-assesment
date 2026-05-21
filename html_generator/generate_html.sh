#!/usr/bin/env bash
# html_generator/generate_html.sh

set -euo pipefail

TEMPLATE_FILE="templates/report.html"
RESULTS_FILE="$DATA_DIR/state/results.json"
REPORT_OUTPUT="$DATA_DIR/reports/cis_report_$(date +%Y%m%d_%H%M%S).html"

if [ ! -f "$RESULTS_FILE" ]; then
    echo "Results file not found. Nothing to generate."
    exit 1
fi

if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "HTML Template not found."
    exit 1
fi

ROWS_HTML=""

# Iterate over JSON array
COUNT=$(jq '. | length' "$RESULTS_FILE")

for ((i=0; i<$COUNT; i++)); do
    ID=$(jq -r ".[$i].control_id" "$RESULTS_FILE")
    TITLE=$(jq -r ".[$i].title" "$RESULTS_FILE")
    EXPECTED=$(jq -r ".[$i].expected_status" "$RESULTS_FILE" | sed 's/</\&lt;/g; s/>/\&gt;/g')
    CURRENT=$(jq -r ".[$i].current_status" "$RESULTS_FILE" | sed 's/</\&lt;/g; s/>/\&gt;/g')
    RESULT=$(jq -r ".[$i].compliance_result" "$RESULTS_FILE")
    RISK=$(jq -r ".[$i].risk_level" "$RESULTS_FILE")
    REMEDIATION=$(jq -r ".[$i].remediation" "$RESULTS_FILE" | sed 's/</\&lt;/g; s/>/\&gt;/g')
    DESC=$(jq -r ".[$i].description" "$RESULTS_FILE" | sed 's/</\&lt;/g; s/>/\&gt;/g')
    ATTACK=$(jq -r ".[$i].attack_scenarios" "$RESULTS_FILE" | sed 's/</\&lt;/g; s/>/\&gt;/g')
    TIMESTAMP=$(jq -r ".[$i].timestamp" "$RESULTS_FILE")

    STATUS_CLASS="status-partial"
    if [ "$RESULT" == "PASS" ]; then STATUS_CLASS="status-pass"; fi
    if [ "$RESULT" == "FAIL" ]; then STATUS_CLASS="status-fail"; fi

    ROW="<tr class=\"row-control\" onclick=\"toggleDetails('$ID')\">
        <td><strong>$ID</strong><br>$TITLE</td>
        <td>$EXPECTED</td>
        <td>$CURRENT</td>
        <td class=\"$STATUS_CLASS\">$RESULT</td>
        <td class=\"risk-$RISK\">$RISK</td>
        </tr>
    <tr class=\"details-row\" id=\"details-$ID\">
        <td colspan=\"6\">
            <div class=\"details-content\">
                <h4>Description & Rationale</h4>
                <p>$DESC</p>
                <h4>Security Impact / Attack Scenario</h4>
                <p>$ATTACK</p>
                <h4>Remediation Steps</h4>
                <pre>$REMEDIATION</pre>
            </div>
        </td>
    </tr>"

    ROWS_HTML="$ROWS_HTML\n$ROW"
done

CURRENT_TIME=$(date +'%Y-%m-%d %H:%M:%S %Z')

# We'll use a bash native string replacement trick to avoid awk/sed escaping issues
# First replace the timestamp
TEMPLATE_CONTENT=$(<"$TEMPLATE_FILE")
TEMPLATE_CONTENT="${TEMPLATE_CONTENT//\{\{TIMESTAMP\}\}/$CURRENT_TIME}"

# Then split the content to insert ROWS
PREFIX="${TEMPLATE_CONTENT%%\{\{ROWS\}\}*}"
SUFFIX="${TEMPLATE_CONTENT#*\{\{ROWS\}\}}"

echo -e "${PREFIX}${ROWS_HTML}${SUFFIX}" > "$REPORT_OUTPUT"

echo -e "\033[0;32m[INFO] Report generated successfully at: $REPORT_OUTPUT\033[0m"
