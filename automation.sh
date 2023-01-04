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

#Task2&3
size=`du -h /tmp/$file_name | cut -c 1-4`
date_created=`date +%d%m%Y-%H%M%S`
header="LOG_TYPE DATE_CREATED TYPE SIZE"
file_location='/var/www/html/inventory.html'

grep -q -F -s $header $file_location || echo $header >> $file_location

echo &>> $file_location
echo httpd-logs $date_created tar $size &>> $file_location

rm -r /tmp/$file_name

touch /etc/cron.d/automation
echo "0 0 * * * root /root/Automation_Project/automation.sh" > /etc/cron.d/automation
chmod 600 /etc/cron.d/automation
