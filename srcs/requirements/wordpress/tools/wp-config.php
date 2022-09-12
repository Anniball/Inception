<?php
# Wordpress configuration file

# We want to set a cache for our wordpress
define('WP_CACHE', true);

# Variables we got from environment configuration done in config.sh and defined in the .env
define( 'DB_NAME', getenv('MARIADB_DATABASE') );
define( 'DB_USER', getenv('MARIADB_USER') );
define( 'DB_PASSWORD', getenv('MARIADB_PASSWORD') );
define( 'DB_HOST', getenv('MARIADB_HOST'));

# Database charset to use in creating database tables.
define( 'DB_CHARSET', 'utf8' );
# The database collate type (sorting rules, case and accent sensitivies). 
# Don't change this if in doubt.
define( 'DB_COLLATE', '' );

# Authentication Unique Keys and Salts.
define('AUTH_KEY',         'put your unique phrase here');
define('SECURE_AUTH_KEY',  'put your unique phrase here');
define('LOGGED_IN_KEY',    'put your unique phrase here');
define('NONCE_KEY',        'put your unique phrase here');
define('AUTH_SALT',        'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT',   'put your unique phrase here');
define('NONCE_SALT',       'put your unique phrase here');

# Prefix for the database tables -> useful for the requests
$table_prefix = 'wp_';

# Allows debug functions, here by default
define( 'WP_DEBUG', false);

# Define absolute path to the WordPress directory.
if (!defined('ABSPATH'))
{
	define('ABSPATH', __DIR__ .'/');
}

# Sets up WordPress vars and included files.
require_once ABSPATH . 'wp-settings.php';