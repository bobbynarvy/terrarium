# install apache and php
apt update
apt install -y apache2 php

# confirm php
php -v

# create php file that shows ip address of server
echo "<?php echo \$_SERVER[\"SERVER_ADDR\"]; ?>" > /var/www/html/index.php

# make apache work with index.php by default
sed -i "13i DirectoryIndex index.php" /etc/apache2/sites-available/000-default.conf

# restart apache
service apache2 restart