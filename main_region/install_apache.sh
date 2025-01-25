#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
yum update -y
yum install -y mod_ssl
sudo /etc/pki/tls/certs/make-dummy-cert localhost.crt
sed 's/SSLCertificateKeyFile/# SSLCertificateKeyFile/g' /etc/httpd/conf.d/ssl.conf
systemctl restart httpd
cd /var/www/html && wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1Jz8s7Tj-cJ561__7KbSrFjD7hn6uSEyY' -O pic.jpg
echo "<html><body><h1>AWS re:Invent Attendance Page from $(hostname -f)</h1><img src="pic.jpg" height="480" width="320"></body></html>" > /var/www/html/index.html
sudo amazon-linux-extras install epel -y