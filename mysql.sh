source ./common.sh

firewall_allow

if [ -z "$MYSQL_ROOT_PASSWORD" ] ; then
  echo MYSQL_ROOT_PASSWORD input is needed
  exit 1
fi

echo Installing MySQL
dnf install mysql-server -y &>>$log_file
Status_Print $?

echo Starting MySQL service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
Status_Print $?

echo Changing the default root password
mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD &>>$log_file
Status_Print $?