#!/bin/bash

source ./common.sh
app_name=redis
check_root

dnf module disable redis -y &>>$LOG_FILE
VALIDATE $? "Disabling Redis"

dnf module enable redis:7 -y &>>$LOG_FILE
VALIDATE $? "Enabling Redis: 7"

dnf install redis -y &>>$LOG_FILE
VALIDATE $? "Install Redis"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e ' /protected-mode/ c protected-mode no' /etc/redis/redis.conf
VALIDATE $? "Allowing remote connetion to redis"

systemctl enable redis &>>$LOG_FILE
VALIDATE $? "Enable Redis"

systemctl start redis &>>$LOG_FILE
VALIDATE $? "Start Redis"

print_total_time