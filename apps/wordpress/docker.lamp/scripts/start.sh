#!/bin/bash
if [ ! -f /var/www/wp-config.php ]; then
	#mysql has to be started this way as it doesn't work to call from /etc/init.d
	/usr/bin/mysqld_safe & 
	sleep 10s
	WORDPRESS_DB="wordpress"
	MYSQL_PASSWORD=`pwgen -c -n -1 12`
	WORDPRESS_PASSWORD=`pwgen -c -n -1 12`
	#This is so the passwords show up in logs. 
	echo mysql root password: $MYSQL_PASSWORD
	echo wordpress password: $WORDPRESS_PASSWORD
	echo $MYSQL_PASSWORD > /mysql-root-pw.txt
	echo $WORDPRESS_PASSWORD > /wordpress-db-pw.txt
 
	if [ -f /var/www/installer.php ]; then
		# if there is a site dupliator package and installer
		# create a install.php with prepopulated db info
		sed -e "s/database_name_here/$WORDPRESS_DB/
		s/username_here/$WORDPRESS_DB/
		s/password_here/$WORDPRESS_PASSWORD/" /var/www/installer.php > /var/www/install.php
	
	else
		sed -e "s/database_name_here/$WORDPRESS_DB/
		s/username_here/$WORDPRESS_DB/
		s/password_here/$WORDPRESS_PASSWORD/
		/'AUTH_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
		/'SECURE_AUTH_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
		/'LOGGED_IN_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
		/'NONCE_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
		/'AUTH_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
		/'SECURE_AUTH_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
		/'LOGGED_IN_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
		/'NONCE_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/" /var/www/wp-config-sample.php > /var/www/wp-config.php
	fi

	mv /etc/php5/apache2/php.ini /etc/php5/apache2/php.ini.orig
	sed "s/upload_max_filesize = 2M/upload_max_filesize = 20M/" /etc/php5/apache2/php.ini.orig > /etc/php5/apache2/php.ini

	chown -R www-data:www-data /var/www
	mysqladmin -u root password $MYSQL_PASSWORD 
	mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY '$WORDPRESS_PASSWORD'; FLUSH PRIVILEGES;"
	killall mysqld
	sleep 10s
fi
supervisord -n
