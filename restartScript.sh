#!/usr/bin/env bash
export JAVA_HOME="/opt/jdk1.7.0"

processname=`ps aux | grep -F '/home/trainuat/trainuat/bin/bootstrap.jar' | grep -v -F 'grep' | awk '{print$1}'`
processid=`ps aux | grep -F '/home/trainuat/trainuat/bin/bootstrap.jar' | grep -v -F 'grep' | awk '{print$2}'`

#change this path according to server
bin_path='/home/trainuat/trainuat/bin'
folder_path='/home/trainuat/trainuat'

echo $processname

if [ $processname ]; then
#echo 'found process name: ' $processname
sh $bin_path/shutdown.sh
sleep 10
echo 'start killing :' $processname $processid 
kill $processid
cd $folder_path/work
ls -lthr
rm -rf *
ls -lthr
cd $folder_path/temp
ls -lthr
rm -rf *
ls -lthr
sh $bin_path/startup.sh   
else
   echo 'not found'
   cd $folder_path/work
   ls -lthr
   rm -rf *
   ls -lthr
   cd $folder_path/temp
   ls -lthr
   rm -rf *
   ls -lthr
sh $bin_path/startup.sh
sleep 3
fi