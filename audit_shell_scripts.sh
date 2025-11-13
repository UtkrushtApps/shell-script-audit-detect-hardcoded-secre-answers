#!/bin/bash

# Directory to scan
SCRIPT_DIR="scripts"
# Report file
REPORT_FILE="audit_report.txt"

# Sensitive patterns to search for
declare -a SENSITIVE_PATTERNS=(
    'PASSWORD='
    'API_KEY='
    'SECRET='
)
# Dangerous commands to search for
declare -a DANGEROUS_COMMANDS=(
    'rm -rf'
    'chmod 777'
)

# Function to check if directory exists and is not empty
if [[ ! -d "$SCRIPT_DIR" ]]; then
    echo "Directory '$SCRIPT_DIR' does not exist. Exiting."
    exit 1
fi

sh_files=("$SCRIPT_DIR"/*.sh)
if [[ ! -e ${sh_files[0]} ]]; then
    echo "No .sh files found in '$SCRIPT_DIR'. No audit performed."
    exit 0
fi

# Empty or create the report file
: > "$REPORT_FILE"

# Scan each .sh file (non-recursive)
for file in "$SCRIPT_DIR"/*.sh; do
    # Skip if not a regular file
    if [[ ! -f "$file" ]]; then
        continue
    fi
    # For each sensitive pattern
    for pattern in "${SENSITIVE_PATTERNS[@]}"; do
        grep -n -- "$pattern" "$file" | while IFS=: read -r lineno line; do
            echo "$file:$lineno:Sensitive pattern '$pattern' found: $line" >> "$REPORT_FILE"
        done
    done
    # For each dangerous command
    for pattern in "${DANGEROUS_COMMANDS[@]}"; do
        grep -n -- "$pattern" "$file" | while IFS=: read -r lineno line; do
            echo "$file:$lineno:Dangerous command '$pattern' found: $line" >> "$REPORT_FILE"
        done
    done

done
# Provide feedback to the user
echo "Audit complete. See '$REPORT_FILE' for the results."