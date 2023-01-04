# Automation_Project
This script consists of bash script to compress the apache2 log files and updload them to an existing S3 bucket. It also creates a html document in /var/www/html directory with the data consisting of the .tar files uploaded to the AWS s3 bucket. 
To make this script more user friendly a cron job is added to run the script everyday at 12 AM when the traffic to the apache2 http server is low.
