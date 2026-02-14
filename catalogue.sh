source ./common.sh

app_name=catalogue

NODEJS

echo Allowing port
firewall-cmd --permanent --add-port=8080/tcp &>>log_file
firewall-cmd --reload &>>log_file
Status_Print $?

echo Copying MongoDB repo file
cp $dir_path/mongo.repo /etc/yum.repos.d/mongo.repo &>>log_file
Status_Print $?

echo Installing MongoDB
dnf install mongodb-mongosh -y &>>log_file
Status_Print $?

echo Loading the schema
mongosh --host mongodb-dev.pdevops.online </app/db/master-data.js &>>log_file
Status_Print $?

