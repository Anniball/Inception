#Installing and updating Debian Buster
FROM debian:buster
RUN	apt-get update -y 
RUN apt-get upgrade -y

#Nginx will be our server. openSSL will allow us to communicate securely using TLS protocol (kind of SSL improved).
RUN apt-get install nginx -y openssl

COPY tool/nginx.conf /etc/nginx/sites-enabled/default.conf

# Generate certificate and key
#	req = Creates and processes certificate requests
#		-x509 = makes the certificate self-signed
#		-nodes = makes the private key not encrypted
#		-out $FILENAME = where to write the certificate	
#		-keyout $FILENAME = where to write the private key
#		-subj = set subject (me) infos 
RUN 	openssl req -x509 -nodes \
		-out /etc/nginx/ssl/ldelmas.42.fr.crt \	
		-keyout /etc/nginx/ssl/ldelmas.42.fr.key \
		-subj "/C=BE/ST=Belgium/L=Brussels/O=42/OU=19/CN=ldelmas.42.fr/UID=ldelmas"

#daemon off -> make nginx run in the foreground
CMD nginx -g "daemon off;"