--Remove all just in case--
DELETE FROM	mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Set MySQL root password (if you don't set it no password at all)
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MARIADB_ROOT_PASSWORD');

--Create user--
CREATE DATABASE $MARIADB_DB;
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PASSWORD';
--Really not sure about that one--
GRANT ALL PRIVILEGES ON $MARIADB_DB.* TO $MARIADB_USER@'%';


FLUSH PRIVILEGES;