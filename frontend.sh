app_name=frontend

echo Disabling Nginx default version
dnf module disable nginx -y &>>log_file
Status_Print $?

echo Enabling Nginx 1.24 Version
dnf module enable nginx:1.24 -y &>>log_file
Status_Print $?

echo Installing Nginx
dnf install nginx -y &>>log_file
Status_Print $?

Copying Nginx Configuration file
cp nginx.conf /etc/nginx/nginx.conf &>>log_file
Status_Print $?

echo Starting Nginx service
systemctl enable nginx &>>log_file
systemctl start nginx &>>log_file
Status_Print $?

echo Removing Default Nginx code
rm -rf /usr/share/nginx/html/* &>>log_file
Status_Print $?

echo Downloading Application code
curl -o /tmp/$app_name https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>log_file
Status_Print $?

echo Changing Application directory
cd /usr/share/nginx/html &>>log_file
Status_Print $?

echo Extracting Application code
unzip /tmp/$app_name.zip &>>log_file
Status_Print $?

echo Restarting Nginx service
systemctl restart nginx &>>log_file
Status_Print $?

