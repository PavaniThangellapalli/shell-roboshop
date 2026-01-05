app_name=frontend

dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y

cp nginx.conf /etc/nginx/nginx.conf

systemctl enable nginx
systemctl start nginx

rm -rf /usr/share/nginx/html/*

curl -o /tmp/$app_name https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip

cd /usr/share/nginx/html
unzip /tmp/$app_name.zip

systemctl restart nginx


