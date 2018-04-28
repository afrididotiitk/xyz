#!/bin/bash
unit_place=("" one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
tenth_place=("" "" twenty thirty forty fifty sixty seventy eighty ninty)
if [ $# -lt 1 ];then
echo -n "invalid input"
exit 0
fi
a=$1
if ! [[ "$a" =~ ^[0-9]+$ ]]
    then
        echo -n "invalid input"
exit 1
fi
#echo -n ${#a}
p=${#a}
#echo -n $p
le=0
for((i=0;i<p;i++))
do
     if [[ ${a:i:1} != 0 ]] ;
     then break

     else ((le++))
    fi
done
m=$(($p-$le))
#echo -n ${a:le:m}
if [ $le == $p ];then
num=0
else
num=${a:le:m}
fi
if [ "$num" -gt "99999999999" ]; then 
echo -n "invalid input"
exit 1
fi
#assumed that num is well formatted
len=${#num}
cr=10000000
lk=100000
th=1000
hnd=100
next=9999999
if [[ $len == 1 ]];then 
	if [[ $num != 0 ]];then 
		echo -n ${unit_place[$num]}
	else
		echo -n zero
	fi 
	exit 0	
fi
if [ "$num" -gt "9999999" ];then

	n1=$(($num/($cr)))
	if [[ "$n1" -gt "99" ]];then
		if [[ "$n1" -gt  "999" ]];then
			echo -n ${unit_place[$(($n1/$th))]} thousand" "
			n1=$(($n1%$th))
		fi
		echo -n ${unit_place[$(($n1/$hnd))]} hundred" "
		n1=$(($n1%$hnd))
	fi
	# n1 <=99 and n1 >0
	if [[ "$n1" -lt "20" ]];then
		echo -n ${unit_place[$n1]} crore" "
	else
		#n1 >21 and n1 <=99
		echo -n ${tenth_place[$(($n1/10))]} ${unit_place[$(($n1%10))]} crore" "
	fi
	num=$(($num%$cr))
fi
if [[ "$num" -gt "$(($lk-1))" ]];then
	n1=$(($num/$lk))
	# n1 <=99 and n1 >0
	if [[ "$n1" -lt "20" ]];then
		echo -n ${unit_place[$n1]} lakh" "
	else
		#n1 >21 and n1 <=99
		echo -n ${tenth_place[$(($n1/10))]} ${unit_place[$(($n1%10))]} lakh" "
	fi
	num=$(($num%$lk))
fi
if [[ "$num" -gt "999" ]];then
	n1=$(($num/$th))
	# n1 <=99 and n1 >0
	if [[ "$n1" -lt 20 ]];then
		echo -n ${unit_place[$n1]} thousand" "
	else
		#n1 >21 and n1 <=99
		echo -n ${tenth_place[$(($n1/10))]} ${unit_place[$(($n1%10))]} thousand" "
	fi
	num=$(($num%$th))
fi
n1=$num
if [ "$n1" -gt "99" ];then
		#echo -n "p4"
	if [[ "$n1" -lt 1000 ]];then 
	#	echo -n $(($n1/100))
          echo -n ${unit_place[$(($n1/100))]} hundred" "
	  n1=$(($n1%100))
	fi
fi
if [[ "$n1" -lt "20" ]];then
		echo -n ${unit_place[$n1]}
else
		#n1 >21 and n1 <=99
	#echo -n $((n1%10))
	echo -n ${tenth_place[$(($n1/10))]} ${unit_place[$(($n1%10))]}
fi

