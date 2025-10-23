#!/bin/bash

source ./common.sh

check_root

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "Install MySQL Server"

systemctl enable mysqld &>>$LOG_FILE
VALIDATE $? "Enable MySQL Server"

systemctl start mysqld &>>$LOG_FILE
VALIDATE $? "Start MySQL"

mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOG_FILE
VALIDATE $? "Setting up Root Password"

print_total_time