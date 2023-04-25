#!/bin/bash

sudo -i 
yum install -y httpd
systemctl enable -now httpd
echo "<h1>This is Test Web-Page</h1>" >> /var/www/html/index.html
systemctl restart httpd

