#!/bin/bash
set -e # Exit immediately if a command fails

echo "Starting Jenkins deployment..."
wget https://raw.githubusercontent.com/akshu20791/Deployment-script/refs/heads/main/jenkins.sh
chmod +x jenkins.sh
sudo ./jenkins.sh

echo "Starting Tomcat deployment..."
# Update package list and install unzip non-interactively
sudo apt update
sudo apt install unzip -y

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.115/bin/apache-tomcat-9.0.115.zip
unzip apache-tomcat-9.0.115.zip

# Clean up the zip file to save space
rm apache-tomcat-9.0.115.zip

# Navigate to Tomcat config
cd apache-tomcat-9.0.115/conf/

# Automate changing the Tomcat port from 8080 to 8085 (to avoid conflict with Jenkins)
sed -i 's/port="8080"/port="8085"/g' server.xml

# Make scripts executable and start Tomcat
cd ../bin
sudo chmod +x *.sh
./startup.sh

echo "Jenkins and Tomcat deployed successfully!"
