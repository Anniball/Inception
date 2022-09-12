# Give owner and group for the the DB which is normally automatically created in this folder 
chown -R mysql:mysql /var/lib/mysql
# Create a folder for the daemon (mysql server’s socket file)
mkdir -p /var/run/mysqld
#Give owner and group to that too
chown -R mysql:mysql /var/run/mysqld
#touch /var/run/mysqld/mysqlf.pid
mkfifo /var/run/mysqld/mysqld.sock

#Just checking if the DB has been correctly created in the right path
if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	echo "--Starting service"
	service mysql start

	# Execute the .sql to setup the database
	eval "echo \"$(cat /tmp/config.sql)\"" | mariadb -u root

	echo "--Setting password"
	# Set MySQL root password (if you don't set it no password at all)
	mysqladmin -u root password $MARIADB_ROOT_PASSWORD;
	echo "--Service stopped"
fi

#Start the database daemon
echo "--start DB daemon"
mysqld_safe
