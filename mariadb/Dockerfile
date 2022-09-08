#Installing and updating Debian Buster
FROM debian:buster
RUN apt-get update
RUN apt-get upgrade -y

#MariaDB will be our database
RUN apt-get install mariadb-server -y 

#Copy database creation and configutation
COPY ./tools/config.sql /tmp/config.sql

#WE WILL PROBABLY NEED A .CNF FILE TO COPY LATER

#Copy .sh script to execute everything
COPY ./srcs/config.sh ./

# This execution of the  script is now the starting point
ENTRYPOINT [ "sh", "config.sh" ]