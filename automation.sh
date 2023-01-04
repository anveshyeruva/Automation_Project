#!/bin/bash

#Task2
apt update -y
apt install apache2
ufw allow 'Apache'
systemctl start apache2
systemctl reload apache2
systemctl enable apache2
myname='Anvesh'
file_name=$myname-httpd-logs-`date +'%d%m%Y-%H%M%S'.tar`
tar -cvf $file_name /var/log/apache2/*.log
mv *.tar /tmp/
rm /var/log/apache2/*.log

apt install awscli -y
s3_bucket="upgrad-anvesh"
aws s3 \
        cp /tmp/$file_name \
        s3://$s3_bucket/$file_name

