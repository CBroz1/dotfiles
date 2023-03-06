full=$(saltthepass -h hash-alg -p master-pass -d $1)
part=${full:0:20} # to truncate, change 20
echo $part | xclip -selection c -rmlastnl