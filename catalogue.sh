source ./common.sh

Git

firewall_allow

app_name=catalogue

NODEJS

echo Copying MongoDB repo file
cp $dir_path/mongo.repo /etc/yum.repos.d/mongo.repo &>>log_file
Status_Print $?

echo Installing MongoDB
dnf install mongodb-mongosh -y &>>log_file
Status_Print $?

echo Loading the schema
mongosh --host mongodb-dev.pdevops.online </app/db/master-data.js &>>log_file
Status_Print $?

