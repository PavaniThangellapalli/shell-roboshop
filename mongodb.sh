source ./common.sh

echo Copying mongodb repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>log_file
Status_Print $?

echo Installing MongoDB
dnf install mongodb-org -y &>>log_file
Status_Print $?

echo Updating listen address
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>log_file
Status_Print $?

echo allow port 27017
firewall-cmd --permanent --add-port=27017/tcp &>>log_file
firewall-cmd --reload &>>log_file
Status_Print $?

echo Starting Mongod service
systemctl enable mongod &>>log_file
systemctl start mongod &>>log_file
Status_Print $?



