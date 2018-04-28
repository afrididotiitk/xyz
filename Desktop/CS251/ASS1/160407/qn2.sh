#!/bin/bash
int_count(){
	local x=$1
	IFS=' '
	read -ra y <<< "$x"
local	count=0
	for elem in "${y[@]}"
	do
		if [[ $elem =~ ^-?[0-9]*$  ]];then
			((count++))
		else if [[ $elem =~ ^-?[0-9]*[.]$  ]]; then
			((count++))
		fi
	fi
	done
	echo $count
}
sentence_count(){
	local  a=$1
        local count1=`echo $a|grep -o '\. '|wc -l`
	local count2=`echo $a|grep -o '\? '|wc -l`
        local count3=`echo $a|grep -o '\! '|wc -l`
	local count=$(($count1+$count2+$count3))
	local len=${#a}
	if [[ ${a:$((len-1)):1} =~ [\.,\?,\!] ]];
	then 
		((count++))
	fi
	echo "$count"
}
spacing="       "
depth(){
	unit=$1
	a=""
	for ((i=0;i<unit;i++))
	do
		a+=$spacing
	done
	echo -e "${a}"
}
sentences()
{
	local count=0
	local directory=$1
	for files in "$directory"/*
	do
		if [ -f $files ];then
			local file5=`cat "$files"`
			local file6=`sentence_count "$file5"`
			count=$(($count+$file6))
		else 
			if [ -d $files ];then
				local file6=`sentences "$files"`
				count=$((count+$file6))
			fi
		fi
	done
	echo "$count"
}
integers(){
	local count=0
	local directory=$1
	for files in "$directory"/*
	do
		if [ -f $files ];then 
			local file6=`cat "$files"`
			local file5=`int_count "$file6"`
			count=$(($count+$file5))
		else 
		if [ -d $files ];then
		local file5=`integers "$files"`
	        count=$(($count+$file5))
	fi
fi
done
echo "$count"
			 
}
main(){
	local a="$1"
	local b="$2"
	local count1=0
	local count2=0
	local space=`depth $b`
	for file in "$a"/*
	do
		if [ -f $file ];then
			local fileinsight=`cat $file`
			local file1=`sentence_count "$fileinsight"`
			local file2=`int_count "$fileinsight"`
			count1=$(($count1+$file1))
			count2=$(($count2+$file2))
			echo -e "${space}(F)${file##*/}-""$file1"-"$file2"
		else if [ -d $file ];then
			local file3=`main "$file" "$(($b+1))"`
			echo "$file3"
			local file4=`integers "$file"`
			local file5=`sentences "$file"`
			count1=$(($count1+$file5))
			count2=$(($count2+$file4))
		fi 
	fi
	done
	space=`depth $((b-1))`
	echo -e "${space}(D)${a##*/}-""$count1"-"$count2"
}
path=$1
if [ $# -ne 1 ];
then 
echo "invalid input"
exit 1
fi
if [ -d $path ];then
	out=`main "$path" 1`
	echo "$out"
	exit 0
else 
	echo "invalid input"
	exit 1
fi
