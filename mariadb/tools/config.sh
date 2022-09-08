# Give owner and group for the the DB which is normally automatically created in this folder 
chown mysql:mysql /var/lib/mysql
# Create a folder for the daemon (mysql server’s socket file)
mkdir -p /var/run/mysqld
#Give owner and group to that too
chown -R mysql:mysql /var/run/mysqld

#Just checking if the DB has been correctly created in the right path
if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	service mysql start
	# Execute the .sql to setup the database
	eval "echo \"$(cat /tmp/create_db.sql)\"" | mariadb
	service mysql stop
fi

#Start the database deaemon
mysqld_safe
