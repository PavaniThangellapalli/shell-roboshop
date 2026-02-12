source ./common.sh

firewall_allow

echo Copying RabbitMQ repo file
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$log_file
Status_Print $?

echo Installing RabbitMQ
dnf install rabbitmq-server -y &>>$log_file
Status_Print $?

echo Starting RabbitMQ service
systemctl enable rabbitmq-server &>>$log_file
systemctl start rabbitmq-server &>>$log_file
Status_Print $?


echo Creating App user
rabbitmqctl add_user roboshop roboshop123 &>>$log_file
Status_Print $?

echo Setting Permissions for App user
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
Status_Print $?
