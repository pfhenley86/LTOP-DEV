<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wp_portfolio');

/** MySQL database username */
define('DB_USER', 'root');

/** MySQL database password */
define('DB_PASSWORD', 'root');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'i_N]XH*!]^;yiVxI=)<[%2 p?qk/=s.0%VI:ySCdcby+{BI9$(S|E|Kj0-YyDBB-');
define('SECURE_AUTH_KEY',  '{;=,F-|&1/>},cz=Id(m+v-`H(,3u3+#B,1R~7WW/Iz3+t&[aFEP+5p1dCh!FG#T');
define('LOGGED_IN_KEY',    '%LpvJd!]&.k^l:*J+>.-g?:Cm|=IMGZx)ITsh_Xe|+ uL&my  5gP_tq9W5xd!(B');
define('NONCE_KEY',        'A?M#&mvv[/Pk )X<z?tir>c)q*H2|$=o2#uuK#PG8>`B-G.Bvm6^+FG;f ]A8Y-.');
define('AUTH_SALT',        'ROrNtba-Y)SC _oFa&Ecbj/b@0aKV~e3qSIq)OfM|S]WvC%-S,`)!@NU_sBNw@~d');
define('SECURE_AUTH_SALT', 'yQ-8Mx5SSx!Zy7>90mm}__V/}FVV1eD1%B^WZ[%{y8+D5pi2VZUFuV_/n4is5,M9');
define('LOGGED_IN_SALT',   '|P9Ir!c%+|d,)k5*qZ,6?v{{LQE(n`IJVG0Dd,c cCP-].bn|+2!SF]-;juYD,Z8');
define('NONCE_SALT',       '>ll7[#^/3{!k>Z5q$FDl^(!MWUV,E2/vy=#W98Ib{FCY 5%F_8(@c}XnlX^C--m8');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wpWPP_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
