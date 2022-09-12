# The www.conf file is needed for communication with the server
grep -E "listen = 127.0.0.1" "/etc/php7/php-fpm.d/www.conf" > /dev/null 2>&1

# If not found it's useless to modify it (errors will be written in /dev/null)
if [ $? -eq 0 ]; then
	echo "--Modifying configuration file"
	# Replacing the listen part
	sed -i "s|.*listen = 127.0.0.1.*|listen = 9000|g" "/etc/php7/php-fpm.d/www.conf"

	# Adding the needed env variables to connext to DB
	echo "env[MARIADB_HOST] = \$MARIADB_HOST" >> "/etc/php7/php-fpm.d/www.conf"
	echo "env[MARIADB_USER] = \$MARIADB_USER" >> "/etc/php7/php-fpm.d/www.conf"
	echo "env[MARIADB_PWD] = \$MARIADB_PASSWORD" >> "/etc/php7/php-fpm.d/www.conf"
	echo "env[MARIADB_DB] = \$MARIADB_DATABASE" >> "/etc/php7/php-fpm.d/www.conf"
fi

# We have to wait a bit or else the next steps will be skipped
# In the meantime, connection to database is happening
# COMMENTED SINCE I'M NOT SURE IF NEEDED
# sleep 5 

# Wordpress installing
if ! wp core is-installed --allow-root; then
	echo "--Installing Wordpress"
	wp core install --url="$WORDPRESS_URL" \
					--title="$WORDPRESS_TITLE" \
					--admin_user="$WORDPRESS_ADMIN_USER" \
					--admin_password="$WORDPRESS_ADMIN_PWD" \
					--admin_email="$WORDPRESS_ADMIN_EMAIL" \
					--skip-email
fi

# Simple update for wordpress 
echo "--Updating wordpress"
wp plugin update --all

# Create user (check how simon does it)
echo "--Creating example user"
wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=editor \
													--user_pass=$WORDPRESS_USER_PWD
# Create article example 
echo "--Creating example article"
wp post generate --count=1 --post_title="example-post"

# We need this FastCGI Process Manager to run wordpress but also so that the container keeps running
# --nodaemonize == keep foreground
echo "--Starting "
php-fpm7 --nodaemonize