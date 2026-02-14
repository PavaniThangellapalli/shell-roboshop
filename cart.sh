source ./common.sh

app_name=cart

echo Allowing port
firewall-cmd --permanent --add-port=8080/tcp &>>log_file
firewall-cmd --reload &>>log_file
Status_Print $?

NODEJS


