source ./common.sh

firewall_disable

echo Installing MySQL
dnf install mysql-server -y &>>$log_file
Status_Print $?

echo Starting MySQL service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
Status_Print $?

echo Changing the default root password
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file
Status_Print $?