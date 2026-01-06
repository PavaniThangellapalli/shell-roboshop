dir_path=$(pwd)
log_file=/tmp/roboshop.log
rm -f $log_file

APP_PREREQ()
{
   echo Creating application user
   useradd roboshop &>>$log_file

   echo Removing app directory
   rm -rf /app &>>$log_file

   echo Creating app new directory
   mkdir /app &>>$log_file

   echo Downloading App code
   curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file

   echo Moving to app directory
   cd /app &>>$log_file

   echo Extracting the app code to app directory
   unzip /tmp/$app_name.zip &>>$log_file
}

SYSTEMD_SETUP()
{
   echo Copy application service file
   cp $dir_path/$app_name.service /etc/systemd/system/$app_name.service &>>$log_file

   echo Start application service file
   systemctl daemon-reload &>>$log_file
   systemctl enable $app_name &>>$log_file
   systemctl restart $app_name &>>$log_file
}

NODEJS()
{
 echo Disabling default NODEJS Version
 dnf module disable nodejs -y &>>$log_file

 echo Enabling NODEJS Version 20
 dnf module enable nodejs:20 -y &>>$log_file

 echo Installing NODEJS
 dnf install nodejs -y &>>$log_file

 APP_PREREQ

 echo Installing NODEJS Dependencies
 npm install &>>$log_file

 SYSTEMD_SETUP

}

JAVA()
{
  echo Installing Maven
  dnf install maven -y &>>$log_file

  APP_PREREQ

  echo Installing Maven Dependencies
  mvn clean package &>>$log_file

  echo Moving Jar file to app directory
  mv target/$app_name-1.0.jar $app_name.jar &>>$log_file

  SYSTEMD_SETUP

}

PYTHON()
{
  echo Installing Python
  dnf install python3 gcc python3-devel -y &>>$log_file

  APP_PREREQ

  echo Installing Python Dependencies
  pip3 install -r requirements.txt &>>$log_file

  SYSTEMD_SETUP

}

GOLANG()
{
  echo Installing GOLANG
  dnf install golang -y &>>$log_file

  APP_PREREQ

  echo Installing GOLANG Dependencies
  go mod init dispatch &>>$log_file
  go get &>>$log_file
  go build &>>$log_file

  SYSTEMD_SETUP

}


