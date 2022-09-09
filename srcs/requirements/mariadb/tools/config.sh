# Give owner and group for the the DB which is normally automatically created in this folder 
chown -R mysql:mysql /var/lib/mysql
# Create a folder for the daemon (mysql server’s socket file)
mkdir -p /var/run/mysqld
#Give owner and group to that too
chown -R mysql:mysql /var/run/mysqld
touch /var/run/mysqld/mysqlf.pid
mkfifo /var/run/mysqld/mysqlf.sock

#Just checking if the DB has been correctly created in the right path
if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	echo "--Starting service"
	service mysql start
	#mysqld_safe &

	# Wait until MariaDB has fully started
	while ! mysqladmin ping -h "$MARIADB_HOST" --silent; do
		sleep 1
	done
	# Execute the .sql to setup the database
	eval "echo \"$(cat /tmp/config.sql)\"" | mariadb -u root
	#mysql -u root -e "CREATE DATABASE $MARIADB_DATABASE";
	#mysql -u root -e "CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD'";
	#mysql -u root -e "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%'";
	#mysql -u root -e "FLUSH PRIVILEGES";

	echo "--Setting password"
	# Set MySQL root password (if you don't set it no password at all)
	mysqladmin -u root password $MARIADB_ROOT_PASSWORD;


	echo "--Stoping service"
	#mysqladmin shutdow
	service mysql stop
fi

#Start the database daemon
mysqld_safe
