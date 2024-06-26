#!/bin/bash

# Function to display usage information
function display_usage {
    echo "Usage: $0 [options] <pattern> <filepath>"
    echo "  <pattern>   Pattern to search for in the file"
    echo "  <filepath>  Path to the file containing bash history"
    echo "Options:"
    echo "  --output-csv <csv_file>  Output extracted data to a CSV file"
    echo "  --one-line                Output each command with timestamps on a single line"
    echo "  --help or -h              Display usage information"
    echo ""
    echo "Example: $0 '^grep' ~/.bash_history"
}

# Function to convert Unix timestamp to ISO 8601 format
function format_timestamp {
    timestamp="$1"
    # Convert Unix timestamp to ISO 8601 format
    iso_date=$(date -u -Iseconds --date=@"$timestamp")
    echo "$iso_date"
}

# Default values
output_csv=false
csv_file="output.csv"
one_line=false

# Parse command line options
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --output-csv)
        output_csv=true
        csv_file="$2"
        shift # past argument
        ;;
        --one-line)
        one_line=true
        ;;
        --help|-h)
        display_usage
        exit 0
        ;;
        *)
        break
        ;;
    esac
    shift # past argument or value
done

# Check if two positional arguments are provided
if [ $# -ne 2 ]; then
    echo "Error: Invalid number of arguments."
    display_usage
    exit 1
fi

pattern="$1"
filepath="$2"

# Check if the filepath exists
if [ ! -f "$filepath" ]; then
    echo "Error: File $filepath not found."
    exit 1
fi

# Function to write output to CSV file
function write_to_csv {
    local command="$1"
    local timestamp_unix="$2"
    local timestamp_iso="$3"
    echo "\"$command\",\"$timestamp_unix\",\"$timestamp_iso\"" >> "$csv_file"
}

# Use grep to find matching lines and the line before (-B1)
egrep "$pattern" "$filepath" -B1 | while IFS= read -r line; do
    if [[ $line =~ ^--$ ]]; then
        continue  # Skip lines containing only '--'
    elif [[ $line =~ ^# ]]; then
        # If the line starts with '#', it's a timestamp
        timestamp=$(echo "$line" | sed 's/^#//')
        # Format the timestamp to ISO 8601 format
        iso_date=$(format_timestamp "$timestamp")
    else
        # Otherwise, it's a command
        command="$line"
        if [ "$one_line" = true ]; then
            echo "Command: $command, Timestamp (Unix): $timestamp, Timestamp (ISO): $iso_date"
        else
            echo "Command: $command"
            echo "Timestamp (Unix): $timestamp"
            echo "Timestamp (ISO): $iso_date"
            echo "--------------------------"
        fi
        
        # Write to CSV file if output_csv flag is set
        if [ "$output_csv" = true ]; then
            write_to_csv "$command" "$timestamp" "$iso_date"
        fi
    fi
done

if [ "$output_csv" = true ]; then
    echo "Output written to $csv_file"
fi

exit 0
