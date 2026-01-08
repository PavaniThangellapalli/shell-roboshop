source ./common.sh

app_name=shipping

JAVA

echo Installing MySQL
dnf install mysql -y &>>$log_file
Status_Print $?

for file in schema app-user master-data ; do
  echo Loading $file
  mysql -h mysql-dev.pdevops.online -uroot -pRoboShop@1 < /app/db/$file.sql &>>$log_file
  Status_Print $?

done

