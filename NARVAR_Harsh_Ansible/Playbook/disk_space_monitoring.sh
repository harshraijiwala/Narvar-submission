#/bin/bash

#***************************Script to monitor the disk space & sending alert mail to the user*****************


#----------------------------------------------------------------------------------------------------------------------------------------
#*************Getting the disk space utilizaion for the required partitions and saving the o/p in a file**********************************
df -h | grep -vE '^Filesystem|tmpfs|none' | awk '{print $5 "\t" $1}' | sed 's/%//' > disk_utilization_report.txt
#----------------------------------------------------------------------------------------------------------------------------------------


#********************* Reading the output from a file & sending alert mail as well as report file to a user*******************************
file="disk_utilization_report.txt"
while IFS= read line
do 
	percent_utilization=$(echo $line | awk '{print $1}')
	partition_name=$(echo $line | awk '{print $2}')
	if [ $percent_utilization -ge 5 ];
	then
		echo " Partition Name - ${partition_name} Disk Utilization - ${percent_utilization}" | mutt -s "Alert: Disk Space Critical" -a disk_utilization_report.txt -- hraijiwala@gmail.com
		echo "Test Mail Sent"
	fi
done <"$file"

#********************************End of the script ********************************************************************************************
