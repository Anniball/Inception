#Installing and updating Debian Buster
FROM debian:buster
RUN	apt-get update -y 
RUN apt-get upgrade -y

#Installing all correct dependencies for php
RUN	apt-get install -y php7.3 php7.3-fpm php7.3-mysql curl

#If /tmp/wordpress/ doesn't exist we create it and work inside
WORKDIR /tmp/wordpress/

# Use of a www.conf seems a little bit too complicated for me as we can just put some more info in the basic one using shell
# COPY tools/www.conf /etc/php/7.3/fpm/pool.d

COPY tools/config.sh /tmp/wordpress/
#Not sure if needed
RUN mkdir -p /run/php

#Installing WordPress CLI (Don't know if I'll use it since I'm writing a wp-config.php)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html/wordpress

#Download and extract WordPress core files to default folder (wp cli command)
RUN wp core download --allow-root
RUN chown -R www-data:www-data /var/www/html

#COPY tools/wp-config.php ./wp-config.php

ENTRYPOINT ["sh", "/tmp/wordpress/config.sh"]
