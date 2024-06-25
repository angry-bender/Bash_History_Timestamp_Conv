# Bash History Command and Timestamp Extractor

This Bash script (`bhtc.sh`) extracts commands and their associated timestamps from a bash history file that has had timestamps enabled based on a specified pattern to hunt for commands.

### Sample input (From `~\.bash_history`)
```
#1579207598
whoami
#1579207584
whoami
```

### Sample output
```
Command: whoami
Timestamp (Unix): 1579207598
Timestamp (Readable): Thu Jan 16 08:46:38 PM UTC 2020
--------------------------
Command: whoami
Timestamp (Unix): 1579207584
Timestamp (Readable): Thu Jan 16 08:46:24 PM UTC 2020 
```

## Optional output formats
You can also output to csv with the `--output-csv <filename>` flag or to one line with `--one-line`

## Usage

### Usage Syntax

`./bhtc.sh <optionals> <pattern> <filepath>`

### Optional CmdLines

  --output-csv <csv_file>    Output extracted data to a CSV file
  --one-line                 Output each command with timestamps on a single line
  --help or -h               Display usage information



