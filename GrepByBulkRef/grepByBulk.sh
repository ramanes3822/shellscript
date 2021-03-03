#!/bin/bash

# configuration
filename=$1
if [ ! -f "$filename" ]; then
    echo "Reference number file not found!"
    exit 1
fi

refNumber=`cat $filename`
pwd_dir=$(pwd)
result_dir="/restore_a0110peceapp01/Nov/app_logs/result2"
log_dir="/restore_a0110peceapp01/Nov/app_logs/backuplog"
echo $refNumber
if [ ! -f "$pwd_dir/$filename" ]; then
    echo "File not found!"
    exit 1
fi

# if more than 1 folder to be search
startDate=181101
loopCount=30
iIncrment=1

for (( i=1; i <= $loopCount; i++ ))
#while [ $iIncrement <  $loopCount ]
do
    # determine folder to be search
    echo "going to process for date : 20$startDate"
    nextDate=$((startDate+1))
    
    target_folder="$log_dir/archived_20$startDate/*.gz"
    check="M$startDate\|M$nextDate";
    echo "Check" $check 
    if [ `echo $refNumber | grep -c $check ` -gt 0 ]
    then
	  fileToRedirect="$result_dir/20$startDate.txt"
          echo " zgrep $refNumber $target_folder >> $fileToRedirect"
          LC_ALL=C zgrep $refNumber $target_folder >> $fileToRedirect
    else	  
	echo "No mathcing ref number for date $line"
    fi
    iIncrment=$((iIncrment+1))
    startDate=$((startDate+1))
    echo "View details $iIncrment $startDate"
done 

echo "$(date) done"