# create html directory and move hello world file there
mkdir /home/html
mv /home/assets/index.html  /home/html/index.html

# install nginx
apt update
apt install -y nginx

# overwrite default nginx configuration
mv /home/assets/nginx-default.conf /etc/nginx/sites-available/default

# restart nginx
systemctl restart nginx