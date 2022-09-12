# The www.conf file is needed for communication with the server
grep -E "listen = 127.0.0.1" "/etc/php7/php-fpm.d/www.conf" > /dev/null 2>&1

# If not found it's useless to modify it (errors will be written in /dev/null)
if [ $? -eq 0 ]; then
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
	wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email
fi

# Simple update for wordpress 
wp plugin update --all

# Create user (check how simon does it)
wp user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PWD
# Create article example 
wp post generate --count=1 --post_title="example-post"

# We need this to run wordpress but also so that the container keeps running
# --nodaemonize == keep foreground
php-fpm7 --nodaemonize