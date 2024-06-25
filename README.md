# Bash History Command and Timestamp Extractor

This Bash script (`BashHist_Timestamp_Extractor.sh`) extracts commands and their associated timestamps from a bash history file that has had timestamps enabled based on a specified pattern to hunt for commands.

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

## Other output formats
You can also output to csv with the `--output-csv <filename>` flag

## Usage

### Usage Syntax

`./BashHist_Timestamp_Extractor.sh <optionals> <pattern> <filepath>`

### Optional CmdLines

--help | -h   		 shows usage
--output-csv <filename>  Outputs to csv file



