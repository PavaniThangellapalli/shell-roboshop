source ./common.sh

firewall_disable

echo Disabling default Redis Version
dnf module disable redis -y &>>$log_file
Status_Print $?

echo Enabling Redis 7 Version
dnf module enable redis:7 -y &>>$log_file
Status_Print $?

echo Installing Redis Version
dnf install redis -y &>>$log_file
Status_Print $?

echo "Updating Listen Address & protected mode"
sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode yes/ c protected-mode no' /etc/redis/redis.conf &>>$log_file
Status_Print $?

echo Starting Redis service
systemctl enable redis &>>$log_file
systemctl start redis &>>$log_file
Status_Print $?