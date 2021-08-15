#!/bin/sh

#*************************Script to Monitor CPU Utilization & Sending an Alert Mail******************
#CPU Utilization is calculated asedo the load average for the fifth minute

#----------------------------------------------------------------------------------------------------
#****Using uptime and greping the required value to obtain fifth minute load average*****************
fifth_min_load_avg="$(uptime | cut -d',' -f5)"
#-----------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------
#Getting the number of cpu cores from /proc/cpuinfo file
#Diving the load average for 5th minute from the number of cpu cores to obtain the CPU utilizion percent
cpu_cores="$(cat /proc/cpuinfo | grep -e 'cpu cores' | awk -F':' '{print $2}')"

cpu_utilization="$(echo "${fifth_min_load_avg} * 100" | bc)"

percent_cpu_utilization="$(echo "$cpu_utilization / $cpu_cores" | bc)"
#--------------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------------
#***Sending an alert mail when the CPU Utilization is more than a certain value**************************
if [ "$percent_cpu_utilization" -ge 1 ]
then
        echo "Current CPU Utilization in % - $percent_cpu_utilization" | mutt -s "Alert:CPU Utilization Critical" -- hraijiwala@gmail.com

fi
#---------------------------------------------------------------------------------------------------------


#*************************************END OF SCRIPT********************************************************


