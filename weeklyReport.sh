#!/bin/bash

# Created by Ramanes ramalingam
# Date: 20181009
# Send weekly report from mongo

tdate=`date +"%Y%m%d"`
bdate=`date -d "1 week ago" +"%Y%m%d"`
out_path=/app/Custom_cron/HybridWeekly/report
zip=/app/Custom_cron/HybridWeekly/report/zip
file_name="HybridWeekly_report_"$bdate"_"$tdate


echo "mongo execution started"

#mongo execution
mongo --host 10.90.0.52 --port 27017 -u "superAdmin" -p "admin123" --authenticationDatabase "admin" OCSServer HybridWeekly.js >${out_path}/test.csv

less  ${out_path}/test.csv | sed '1,4d' > ${out_path}/${file_name}.csv
rm  ${out_path}/test.csv

echo "zip file started"

cd ${out_path}

zip ${zip}/${file_name}.zip ${file_name}.csv

#mv ${file_name}.zip ${zip}

echo "done" $tdate

#EMAIL
EMAIL_LIST=adrien.lee@DIGI.COM.MY,Accenture.Ecommerce@digi.com.my,WCKOH@DIGI.COM.MY,apriljoy.enriquez@DIGI.COM.MY,inshirahnameen.mzakaria@DIGI.COM.MY
#EMAIL_LIST=ramanes.ramalingam@accenture.com

output_file=/home/mdgadmin/output.txt

echo "Hi Team," >> $output_file
echo " " >> $output_file
echo "This is auto generate report." >> $output_file
echo " " >> $output_file
echo " " >> $output_file
echo "Thanks." >> $output_file
echo "Ecomm Team." >> $output_file

cat $output_file | /bin/mail -s "Weekly Hybrid Report"$bdate"_"$tdate -a /app/Custom_cron/HybridWeekly/report/zip/${file_name}.zip -r MYDIGI_REPORT"<mydigi_report@digi.com.my>" $EMAIL_LIST
rm -f $output_file