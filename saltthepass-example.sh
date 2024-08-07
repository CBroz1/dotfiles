#!/bin/bash

# Initialize variables
ret_out=false
# Parse options
while getopts ":o" opt; do
  case ${opt} in
    o )
      ret_out=true
      ;;
    \? )
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

DOM="${1:-SpecialCase}"
full=$(saltthepass -p master_pass -d $DOM)
part=${full:0:20} # Truncate to 20 characters
if [ $DOM == "SpecialCase" ]; then
  part=${part}${part}
fi

if [ $ret_out == true ]; then
  echo $part
else
  echo $part | xclip -selection c -rmlastnl
fi

