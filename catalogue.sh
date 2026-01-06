source ./common.sh

app_name=catalogue

NODEJS

cp mongo.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-mongosh -y

mongosh --host mongodb-dev.pdevops.online </app/db/master-data.js


