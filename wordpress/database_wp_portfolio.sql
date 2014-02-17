# WordPress : http://localhost/allisongrayce.com MySQL database backup
#
# Generated: Thursday 18. April 2013 19:56 UTC
# Hostname: localhost
# Database: `wp_portfolio`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_commentmeta`
# --------------------------------------------------------


#
# Delete any existing table `wpWPP_commentmeta`
#

DROP TABLE IF EXISTS `wpWPP_commentmeta`;


#
# Table structure of table `wpWPP_commentmeta`
#

CREATE TABLE `wpWPP_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

#
# Data contents of table wpWPP_commentmeta (0 records)
#

#
# End of data contents of table wpWPP_commentmeta
# --------------------------------------------------------

# WordPress : http://localhost/allisongrayce.com MySQL database backup
#
# Generated: Thursday 18. April 2013 19:56 UTC
# Hostname: localhost
# Database: `wp_portfolio`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_commentmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_comments`
# --------------------------------------------------------


#
# Delete any existing table `wpWPP_comments`
#

DROP TABLE IF EXISTS `wpWPP_comments`;


#
# Table structure of table `wpWPP_comments`
#

CREATE TABLE `wpWPP_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext NOT NULL,
  `comment_author_email` varchar(100) NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) NOT NULL DEFAULT '',
  `comment_type` varchar(20) NOT NULL DEFAULT '',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ;

#
# Data contents of table wpWPP_comments (1 records)
#
 
INSERT INTO `wpWPP_comments` VALUES (1, 1, 'Mr WordPress', '', 'http://wordpress.org/', '', '2013-02-06 21:19:22', '2013-02-06 21:19:22', 'Hi, this is a comment.
To delete a comment, just log in and view the post&#039;s comments. There you will have the option to edit or delete them.', 0, '1', '', '', 0, 0) ;
#
# End of data contents of table wpWPP_comments
# --------------------------------------------------------

# WordPress : http://localhost/allisongrayce.com MySQL database backup
#
# Generated: Thursday 18. April 2013 19:56 UTC
# Hostname: localhost
# Database: `wp_portfolio`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_commentmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_comments`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_links`
# --------------------------------------------------------


#
# Delete any existing table `wpWPP_links`
#

DROP TABLE IF EXISTS `wpWPP_links`;


#
# Table structure of table `wpWPP_links`
#

CREATE TABLE `wpWPP_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL DEFAULT '',
  `link_name` varchar(255) NOT NULL DEFAULT '',
  `link_image` varchar(255) NOT NULL DEFAULT '',
  `link_target` varchar(25) NOT NULL DEFAULT '',
  `link_description` varchar(255) NOT NULL DEFAULT '',
  `link_visible` varchar(20) NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) NOT NULL DEFAULT '',
  `link_notes` mediumtext NOT NULL,
  `link_rss` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

#
# Data contents of table wpWPP_links (0 records)
#

#
# End of data contents of table wpWPP_links
# --------------------------------------------------------

# WordPress : http://localhost/allisongrayce.com MySQL database backup
#
# Generated: Thursday 18. April 2013 19:56 UTC
# Hostname: localhost
# Database: `wp_portfolio`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_commentmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_comments`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_links`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_options`
# --------------------------------------------------------


#
# Delete any existing table `wpWPP_options`
#

DROP TABLE IF EXISTS `wpWPP_options`;


#
# Table structure of table `wpWPP_options`
#

CREATE TABLE `wpWPP_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL DEFAULT '',
  `option_value` longtext NOT NULL,
  `autoload` varchar(20) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=263 DEFAULT CHARSET=utf8 ;

#
# Data contents of table wpWPP_options (172 records)
#
 
INSERT INTO `wpWPP_options` VALUES (1, 'siteurl', 'http://localhost/allisongrayce.com', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (2, 'blogname', 'WordPress Portfolio', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (3, 'blogdescription', 'Just another WordPress site', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (4, 'users_can_register', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (5, 'admin_email', 'zac@teamtreehouse.com', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (6, 'start_of_week', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (7, 'use_balanceTags', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (8, 'use_smilies', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (9, 'require_name_email', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (10, 'comments_notify', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (11, 'posts_per_rss', '10', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (12, 'rss_use_excerpt', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (13, 'mailserver_url', 'mail.example.com', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (14, 'mailserver_login', 'login@example.com', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (15, 'mailserver_pass', 'password', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (16, 'mailserver_port', '110', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (17, 'default_category', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (18, 'default_comment_status', 'open', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (19, 'default_ping_status', 'open', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (20, 'default_pingback_flag', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (21, 'posts_per_page', '10', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (22, 'date_format', 'F j, Y', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (23, 'time_format', 'g:i a', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (24, 'links_updated_date_format', 'F j, Y g:i a', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (25, 'links_recently_updated_prepend', '<em>', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (26, 'links_recently_updated_append', '</em>', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (27, 'links_recently_updated_time', '120', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (28, 'comment_moderation', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (29, 'moderation_notify', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (30, 'permalink_structure', '/%postname%/', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (31, 'gzipcompression', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (32, 'hack_file', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (33, 'blog_charset', 'UTF-8', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (34, 'moderation_keys', '', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (35, 'active_plugins', 'a:3:{i:0;s:30:"advanced-custom-fields/acf.php";i:1;s:26:"backupwordpress/plugin.php";i:2;s:43:"custom-post-type-ui/custom-post-type-ui.php";}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (36, 'home', 'http://localhost/allisongrayce.com', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (37, 'category_base', '', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (38, 'ping_sites', 'http://rpc.pingomatic.com/', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (39, 'advanced_edit', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (40, 'comment_max_links', '2', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (41, 'gmt_offset', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (42, 'default_email_category', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (43, 'recently_edited', '', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (44, 'template', 'wpportfolio', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (45, 'stylesheet', 'wpportfolio', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (46, 'comment_whitelist', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (47, 'blacklist_keys', '', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (48, 'comment_registration', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (49, 'html_type', 'text/html', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (50, 'use_trackback', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (51, 'default_role', 'subscriber', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (52, 'db_version', '22441', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (53, 'uploads_use_yearmonth_folders', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (54, 'upload_path', '', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (55, 'blog_public', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (56, 'default_link_category', '2', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (57, 'show_on_front', 'page', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (58, 'tag_base', '', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (59, 'show_avatars', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (60, 'avatar_rating', 'G', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (61, 'upload_url_path', '', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (62, 'thumbnail_size_w', '150', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (63, 'thumbnail_size_h', '150', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (64, 'thumbnail_crop', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (65, 'medium_size_w', '300', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (66, 'medium_size_h', '300', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (67, 'avatar_default', 'mystery', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (68, 'large_size_w', '1024', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (69, 'large_size_h', '1024', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (70, 'image_default_link_type', 'file', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (71, 'image_default_size', '', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (72, 'image_default_align', '', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (73, 'close_comments_for_old_posts', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (74, 'close_comments_days_old', '14', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (75, 'thread_comments', '1', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (76, 'thread_comments_depth', '5', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (77, 'page_comments', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (78, 'comments_per_page', '50', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (79, 'default_comments_page', 'newest', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (80, 'comment_order', 'asc', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (81, 'sticky_posts', 'a:0:{}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (82, 'widget_categories', 'a:2:{i:2;a:4:{s:5:"title";s:0:"";s:5:"count";i:0;s:12:"hierarchical";i:0;s:8:"dropdown";i:0;}s:12:"_multiwidget";i:1;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (83, 'widget_text', 'a:0:{}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (84, 'widget_rss', 'a:0:{}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (85, 'uninstall_plugins', 'a:0:{}', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (86, 'timezone_string', '', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (87, 'page_for_posts', '9', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (88, 'page_on_front', '6', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (89, 'default_post_format', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (90, 'link_manager_enabled', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (91, 'initial_db_version', '22441', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (92, 'wpWPP_user_roles', 'a:5:{s:13:"administrator";a:2:{s:4:"name";s:13:"Administrator";s:12:"capabilities";a:62:{s:13:"switch_themes";b:1;s:11:"edit_themes";b:1;s:16:"activate_plugins";b:1;s:12:"edit_plugins";b:1;s:10:"edit_users";b:1;s:10:"edit_files";b:1;s:14:"manage_options";b:1;s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:6:"import";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:8:"level_10";b:1;s:7:"level_9";b:1;s:7:"level_8";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;s:12:"delete_users";b:1;s:12:"create_users";b:1;s:17:"unfiltered_upload";b:1;s:14:"edit_dashboard";b:1;s:14:"update_plugins";b:1;s:14:"delete_plugins";b:1;s:15:"install_plugins";b:1;s:13:"update_themes";b:1;s:14:"install_themes";b:1;s:11:"update_core";b:1;s:10:"list_users";b:1;s:12:"remove_users";b:1;s:9:"add_users";b:1;s:13:"promote_users";b:1;s:18:"edit_theme_options";b:1;s:13:"delete_themes";b:1;s:6:"export";b:1;}}s:6:"editor";a:2:{s:4:"name";s:6:"Editor";s:12:"capabilities";a:34:{s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;}}s:6:"author";a:2:{s:4:"name";s:6:"Author";s:12:"capabilities";a:10:{s:12:"upload_files";b:1;s:10:"edit_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:4:"read";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;s:22:"delete_published_posts";b:1;}}s:11:"contributor";a:2:{s:4:"name";s:11:"Contributor";s:12:"capabilities";a:5:{s:10:"edit_posts";b:1;s:4:"read";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;}}s:10:"subscriber";a:2:{s:4:"name";s:10:"Subscriber";s:12:"capabilities";a:2:{s:4:"read";b:1;s:7:"level_0";b:1;}}}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (93, 'widget_search', 'a:2:{i:2;a:1:{s:5:"title";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (94, 'widget_recent-posts', 'a:2:{i:2;a:2:{s:5:"title";s:0:"";s:6:"number";i:5;}s:12:"_multiwidget";i:1;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (95, 'widget_recent-comments', 'a:2:{i:2;a:2:{s:5:"title";s:0:"";s:6:"number";i:5;}s:12:"_multiwidget";i:1;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (96, 'widget_archives', 'a:2:{i:2;a:3:{s:5:"title";s:0:"";s:5:"count";i:0;s:8:"dropdown";i:0;}s:12:"_multiwidget";i:1;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (97, 'widget_meta', 'a:2:{i:2;a:1:{s:5:"title";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (98, 'sidebars_widgets', 'a:3:{s:19:"wp_inactive_widgets";a:0:{}s:18:"orphaned_widgets_1";a:6:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";i:3;s:10:"archives-2";i:4;s:12:"categories-2";i:5;s:6:"meta-2";}s:13:"array_version";i:3;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (99, 'cron', 'a:5:{i:1366319963;a:3:{s:16:"wp_version_check";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:17:"wp_update_plugins";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:16:"wp_update_themes";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}}i:1366319965;a:1:{s:19:"wp_scheduled_delete";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1366320073;a:1:{s:30:"wp_scheduled_auto_draft_delete";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1366326000;a:1:{s:19:"hmbkp_schedule_hook";a:1:{s:32:"61a45f8e0e711228d9f0aa04271d0a05";a:3:{s:8:"schedule";s:6:"weekly";s:4:"args";a:1:{s:2:"id";s:9:"default-2";}s:8:"interval";i:604800;}}}s:7:"version";i:2;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (101, '_site_transient_update_core', 'O:8:"stdClass":3:{s:7:"updates";a:1:{i:0;O:8:"stdClass":9:{s:8:"response";s:6:"latest";s:8:"download";s:40:"http://wordpress.org/wordpress-3.5.1.zip";s:6:"locale";s:5:"en_US";s:8:"packages";O:8:"stdClass":4:{s:4:"full";s:40:"http://wordpress.org/wordpress-3.5.1.zip";s:10:"no_content";s:51:"http://wordpress.org/wordpress-3.5.1-no-content.zip";s:11:"new_bundled";s:52:"http://wordpress.org/wordpress-3.5.1-new-bundled.zip";s:7:"partial";b:0;}s:7:"current";s:5:"3.5.1";s:11:"php_version";s:5:"5.2.4";s:13:"mysql_version";s:3:"5.0";s:11:"new_bundled";s:3:"3.5";s:15:"partial_version";s:0:"";}}s:12:"last_checked";i:1366313590;s:15:"version_checked";s:5:"3.5.1";}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (105, '_site_transient_update_themes', 'O:8:"stdClass":3:{s:12:"last_checked";i:1366313590;s:7:"checked";a:3:{s:12:"twentyeleven";s:3:"1.5";s:12:"twentytwelve";s:3:"1.1";s:11:"wpportfolio";s:3:"1.0";}s:8:"response";a:0:{}}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (106, '_site_transient_timeout_browser_6719f4949e55743fc919da1eb865de39', '1360790365', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (107, '_site_transient_browser_6719f4949e55743fc919da1eb865de39', 'a:9:{s:8:"platform";s:9:"Macintosh";s:4:"name";s:6:"Chrome";s:7:"version";s:12:"24.0.1312.57";s:10:"update_url";s:28:"http://www.google.com/chrome";s:7:"img_src";s:49:"http://s.wordpress.org/images/browsers/chrome.png";s:11:"img_src_ssl";s:48:"https://wordpress.org/images/browsers/chrome.png";s:15:"current_version";s:2:"18";s:7:"upgrade";b:0;s:8:"insecure";b:0;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (108, 'dashboard_widget_options', 'a:4:{s:25:"dashboard_recent_comments";a:1:{s:5:"items";i:5;}s:24:"dashboard_incoming_links";a:5:{s:4:"home";s:34:"http://localhost/allisongrayce.com";s:4:"link";s:110:"http://blogsearch.google.com/blogsearch?scoring=d&partner=wordpress&q=link:http://localhost/allisongrayce.com/";s:3:"url";s:143:"http://blogsearch.google.com/blogsearch_feeds?scoring=d&ie=utf-8&num=10&output=rss&partner=wordpress&q=link:http://localhost/allisongrayce.com/";s:5:"items";i:10;s:9:"show_date";b:0;}s:17:"dashboard_primary";a:7:{s:4:"link";s:26:"http://wordpress.org/news/";s:3:"url";s:31:"http://wordpress.org/news/feed/";s:5:"title";s:14:"WordPress Blog";s:5:"items";i:2;s:12:"show_summary";i:1;s:11:"show_author";i:0;s:9:"show_date";i:1;}s:19:"dashboard_secondary";a:7:{s:4:"link";s:28:"http://planet.wordpress.org/";s:3:"url";s:33:"http://planet.wordpress.org/feed/";s:5:"title";s:20:"Other WordPress News";s:5:"items";i:5;s:12:"show_summary";i:0;s:11:"show_author";i:0;s:9:"show_date";i:0;}}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (110, 'can_compress_scripts', '0', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (148, 'category_children', 'a:0:{}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (152, 'recently_activated', 'a:0:{}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (153, 'cpt_custom_post_types', 'a:2:{i:0;a:19:{s:4:"name";s:4:"work";s:5:"label";s:4:"Work";s:14:"singular_label";s:7:"Project";s:11:"description";s:0:"";s:6:"public";s:1:"1";s:7:"show_ui";s:1:"1";s:11:"has_archive";s:1:"0";s:19:"exclude_from_search";s:1:"0";s:15:"capability_type";s:4:"post";s:12:"hierarchical";s:1:"0";s:7:"rewrite";s:1:"1";s:12:"rewrite_slug";s:0:"";s:9:"query_var";s:1:"1";s:13:"menu_position";s:0:"";s:12:"show_in_menu";s:1:"1";s:19:"show_in_menu_string";s:0:"";i:0;a:10:{i:0;s:5:"title";i:1;s:6:"editor";i:2;s:7:"excerpt";i:3;s:10:"trackbacks";i:4;s:13:"custom-fields";i:5;s:8:"comments";i:6;s:9:"revisions";i:7;s:9:"thumbnail";i:8;s:6:"author";i:9;s:15:"page-attributes";}i:1;N;i:2;a:12:{s:9:"menu_name";s:0:"";s:7:"add_new";s:0:"";s:12:"add_new_item";s:0:"";s:4:"edit";s:0:"";s:9:"edit_item";s:0:"";s:8:"new_item";s:0:"";s:4:"view";s:0:"";s:9:"view_item";s:0:"";s:12:"search_items";s:0:"";s:9:"not_found";s:0:"";s:18:"not_found_in_trash";s:0:"";s:6:"parent";s:0:"";}}i:1;a:19:{s:4:"name";s:12:"testimonials";s:5:"label";s:12:"Testimonials";s:14:"singular_label";s:11:"Testimonial";s:11:"description";s:0:"";s:6:"public";s:1:"1";s:7:"show_ui";s:1:"1";s:11:"has_archive";s:1:"0";s:19:"exclude_from_search";s:1:"0";s:15:"capability_type";s:4:"post";s:12:"hierarchical";s:1:"0";s:7:"rewrite";s:1:"1";s:12:"rewrite_slug";s:0:"";s:9:"query_var";s:1:"1";s:13:"menu_position";s:0:"";s:12:"show_in_menu";s:1:"1";s:19:"show_in_menu_string";s:0:"";i:0;a:10:{i:0;s:5:"title";i:1;s:6:"editor";i:2;s:7:"excerpt";i:3;s:10:"trackbacks";i:4;s:13:"custom-fields";i:5;s:8:"comments";i:6;s:9:"revisions";i:7;s:9:"thumbnail";i:8;s:6:"author";i:9;s:15:"page-attributes";}i:1;N;i:2;a:12:{s:9:"menu_name";s:0:"";s:7:"add_new";s:0:"";s:12:"add_new_item";s:0:"";s:4:"edit";s:0:"";s:9:"edit_item";s:0:"";s:8:"new_item";s:0:"";s:4:"view";s:0:"";s:9:"view_item";s:0:"";s:12:"search_items";s:0:"";s:9:"not_found";s:0:"";s:18:"not_found_in_trash";s:0:"";s:6:"parent";s:0:"";}}}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (154, '_transient_timeout_feed_c809918297b2c893fd8504c06adcaf00', '1360229811', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (155, '_transient_feed_c809918297b2c893fd8504c06adcaf00', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"


";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:50:"
	
	
	
	
	
	
	
	
	
		
		
		
		
		
		
		
		
		
		
	";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:4:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:17:"WebDevStudios.com";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:24:"http://webdevstudios.com";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:40:"WordPress Website Development and Design";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:13:"lastBuildDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 05 Feb 2013 17:36:20 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:5:"en-US";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"generator";a:1:{i:0;a:5:{s:4:"data";s:29:"http://wordpress.org/?v=3.5.1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:10:{i:0;a:6:{s:4:"data";s:51:"
		
		
		
		
		
				
		
		
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:34:"Join WDS for our Giveaway Tuesday!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:70:"http://webdevstudios.com/2013/02/05/join-wds-for-our-giveaway-tuesday/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:79:"http://webdevstudios.com/2013/02/05/join-wds-for-our-giveaway-tuesday/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 05 Feb 2013 15:57:34 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:4:{i:0;a:5:{s:4:"data";s:8:"Facebook";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:8:"Giveaway";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:8:"WordCamp";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:3;a:5:{s:4:"data";s:9:"WordPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"http://webdevstudios.com/?p=7160";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:405:"Today at WebDevStudios, we are doing our second Giveaway Tuesday! Join us on our Facebook page, to let us know what your favorite WordCamp was and why.  Tell us about which WordCamp helped you learn the most, the funniest moment of that &#8230; <a class="more-link" href="http://webdevstudios.com/2013/02/05/join-wds-for-our-giveaway-tuesday/">Continue reading <span class="meta-nav">&#8594;</span></a>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Melissa Hoppe";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:2121:"<p>Today at WebDevStudios, we are doing our second Giveaway Tuesday! Join us on our <a href="http://facebook.com/webdevstudios">Facebook</a> page, to let us know what your favorite WordCamp was and why.  Tell us about which WordCamp helped you learn the most, the funniest moment of that WordCamp, or whatever else made that WordCamp stand out to you.  We will read each and every one of your posts on our wall &#8211; and then pick our favorite.  Oh how we LOVE WordPress stories!</p>
<p><a href="http://webdevstudios.com/wp-content/uploads/2013/02/wpfd5e.jpg" rel="shadowbox[sbpost-7160];player=img;"><img class="alignleft  wp-image-7161" alt="wpfd5e" src="http://webdevstudios.com/wp-content/uploads/2013/02/wpfd5e-300x300.jpg" width="197" height="197" /></a></p>
<p><strong>What&#8217;s the prize today?</strong> <a href="http://lisas.co/wpfordummies5">WordPress For Dummies 5th Edition</a> of course! Written by one of our resident WordPress experts,  <a title="Lisa Sabin-Wilson" href="http://webdevstudios.com/team/lisa-sabin-wilson/">Lisa Sabin-Wilson</a>, this guide helps bloggers take advantage quickly and easily of everything this popular blogging tool has to offer. This guide covers all the features and improvements in the most up-to-date version of WordPress.</p>
<p>Lisa is happy to giveaway a free copy of her book to the person with the BEST WordCamp story!</p>
<p><strong>Easy rules for entry:</strong></p>
<ol>
<li><span style="line-height: 16px;">The story must be posted on our <a href="http://www.facebook.com/webdevstudios/posts/414792441938655">Facebook wall in the comments of this post</a>.</span></li>
<li>Employees and family members of WebDevStudios can enter their favorite WordCamp story &#8211; but will be exempt from winning the prize!</li>
<li>Only one entry per person &#8211; multiple entries from the same person will be disregarded.</li>
<li>You must submit your favorite WordCamp story by 4pm EST.</li>
<li>Our winner will be chosen, and announced on Facebook and Twitter by 5pm EST.</li>
</ol>
<p>Have fun and thanks for playing this weeks WDS Giveaway Tuesday!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:75:"http://webdevstudios.com/2013/02/05/join-wds-for-our-giveaway-tuesday/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:48:"
		
		
		
		
		
				
		
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:56:"WooCommerce Product Support Extension from WebDevStudios";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:93:"http://webdevstudios.com/2013/01/31/woocommerce-product-support-extension-from-webdevstudios/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:102:"http://webdevstudios.com/2013/01/31/woocommerce-product-support-extension-from-webdevstudios/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 31 Jan 2013 15:00:01 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:3:{i:0;a:5:{s:4:"data";s:7:"bbPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:10:"BuddyPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:11:"WooCommerce";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"http://webdevstudios.com/?p=7146";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:459:"Tired of the hassle involved with managing product support? Looking for a simple solution? Then look no further! The WooCommerce Product Support extension was developed to work together with BuddyPress or bbPress. This extension helps you automatically create forums for &#8230; <a class="more-link" href="http://webdevstudios.com/2013/01/31/woocommerce-product-support-extension-from-webdevstudios/">Continue reading <span class="meta-nav">&#8594;</span></a>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Melissa Hoppe";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:2848:"<p>Tired of the hassle involved with managing <a title="Group and Forum Product Support" href="http://www.woothemes.com/products/product-support/">product support</a>? Looking for a simple solution? Then look no further!</p>
<p>The WooCommerce Product Support extension was developed to work together with <a title="BuddyPress Design and Development" href="http://webdevstudios.com/buddypress/">BuddyPress</a> or bbPress. This extension helps you automatically create forums for new products, link products to existing forums, and automatically grant users access. When using BuddyPress, users only gain access to the Groups that correspond to the purchased products.</p>
<p><a href="http://webdevstudios.com/wp-content/uploads/2013/01/product_support_product_page.png" rel="shadowbox[sbpost-7146];player=img;"><img class="alignleft size-full wp-image-7147" alt="product_support_product_page" src="http://webdevstudios.com/wp-content/uploads/2013/01/product_support_product_page.png" width="299" height="163" /></a></p>
<p><b>Key Features</b></p>
<ul>
<li>Automatically create new groups/forums</li>
<li>Associate products with any existing groups/forums</li>
<li>Automatically add users to correct groups on completed purchase (BuddyPress only)</li>
<li>Automatically create first post in each new forum</li>
<li>Doesn’t interfere with existing bbPress and BuddyPress functionality (you can still manually create Groups/forums and add users like you always have)</li>
</ul>
<p>The WooCommerce Product support extension allows you to improve your current product support workflow and easily provide support for users who buy your products. The settings for plugins, also have the option to write some stock forum instructions that can be published, locked and stuck to the top of a forum, when a new form is created.</p>
<p>If you’re looking for product support that’s easy to manage, we highly recommend that you install BuddyPress (a free plugin) and enable User Groups and Discussion Forums. It will give you the best control over who has access to what. With the addition of the EDD Product Support, you can completely automate group creation and user addition!</p>
<p><a href="http://webdevstudios.com/wp-content/uploads/2013/01/product_support_settings.png" rel="shadowbox[sbpost-7146];player=img;"><img class="alignleft size-large wp-image-7148" alt="product_support_settings" src="http://webdevstudios.com/wp-content/uploads/2013/01/product_support_settings-1024x604.png" width="615" height="362" /></a></p>
<p>At WebDevStudios, we are experts in the area of WordPress, WooCommerce, and BuddyPress &#8211; if you are interested in having WebDevStudios create a WordPress website for you (with bbPress and BuddyPress, too, if you want!) - <a href="http://webdevstudios.com/contact/">Contact us</a> today to discuss your project!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:98:"http://webdevstudios.com/2013/01/31/woocommerce-product-support-extension-from-webdevstudios/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:48:"
		
		
		
		
		
				
		
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:51:"WebDevStudios Welcomes Shayne Sanderson to the Lab!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:87:"http://webdevstudios.com/2013/01/29/webdevstudios-welcomes-shayne-sanderson-to-the-lab/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:96:"http://webdevstudios.com/2013/01/29/webdevstudios-welcomes-shayne-sanderson-to-the-lab/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 29 Jan 2013 15:42:46 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:3:{i:0;a:5:{s:4:"data";s:4:"Team";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:4:"team";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:13:"WebDevStudios";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"http://webdevstudios.com/?p=7138";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:425:"He is no stranger to the WordPress community and if you&#8217;ve attended a few WordCamps, you&#8217;ve likely run into him a time or two. WebDevStudios is very happy to announce that Shayne Sanderson has joined our team here at WebDevStudios &#8230; <a class="more-link" href="http://webdevstudios.com/2013/01/29/webdevstudios-welcomes-shayne-sanderson-to-the-lab/">Continue reading <span class="meta-nav">&#8594;</span></a>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:17:"Lisa Sabin-Wilson";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:1826:"<p>He is no stranger to the WordPress community and if you&#8217;ve attended a few WordCamps, you&#8217;ve likely run into him a time or two. WebDevStudios is very happy to announce that <a title="Shayne Sanderson" href="http://webdevstudios.com/team/shayne-sanderson">Shayne Sanderson</a> has joined our team here at WebDevStudios and we are very excited to bring his years of experience and knowledge with WordPress to round out our team.</p>
<p><a href="http://webdevstudios.com/team/shayne-sanderson"><img class="alignleft size-full wp-image-7139" alt="shayne" src="http://webdevstudios.com/wp-content/uploads/2013/01/shayne.jpg" width="250" height="300" /></a> You may also know of Shayne through his offerings at <a href="http://maintainn.com">Maintainn</a>, a Managed WordPress Support &amp; Maintenance service, that he runs with his wife, Abbie. Shayne has been working with WordPress since 2006 and has been a freelance developer for most of that time. He enjoys attending WordCamps and speaking/teaching about WordPress whenever possible. In his off-time he enjoys spending time with family, traveling and playing some old school Nintendo!</p>
<p>Shayne joins WebDevStudios in the position of Technical Project Manager with the unique challenge to bridge the gap between our clients and the rest of our technology team by understanding both the business challenges and system requirements, as well as the technology to put a solution in place for our clients. Shayne takes our projects and client relationships from proposal through delivery and make sure our client and WebDevStudios both have a happy and successful engagement. This position is an important part of our success with each project we take on and we couldn&#8217;t be happier to have Shayne filling that role.</p>
<p>Welcome to the Lab, Shayne!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:92:"http://webdevstudios.com/2013/01/29/webdevstudios-welcomes-shayne-sanderson-to-the-lab/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"4";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:48:"
		
		
		
		
		
				
		
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:32:"WebDevStudios Giveaway Tuesdays!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:68:"http://webdevstudios.com/2013/01/29/webdevstudios-giveaway-tuesdays/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:77:"http://webdevstudios.com/2013/01/29/webdevstudios-giveaway-tuesdays/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 29 Jan 2013 14:58:11 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:3:{i:0;a:5:{s:4:"data";s:8:"Giveaway";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:22:"professional wordpress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:7:"Twitter";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"http://webdevstudios.com/?p=7135";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:404:"WebDevStudios is trying something new! Every Tuesday, we will be doing a giveaway contest. Giving you die hard WDS fans a chance to win awesome goodies! Win things like the knowledgeable WordPress books written by our very own Brad Williams &#8230; <a class="more-link" href="http://webdevstudios.com/2013/01/29/webdevstudios-giveaway-tuesdays/">Continue reading <span class="meta-nav">&#8594;</span></a>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Melissa Hoppe";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:2227:"<p>WebDevStudios is trying something new! Every Tuesday, we will be doing a giveaway contest. Giving you die hard WDS fans a chance to win awesome goodies! Win things like the knowledgeable <a title="WordPress Books" href="http://webdevstudios.com/wordpress/books/">WordPress books</a> written by our very own <a title="Brad Williams" href="http://webdevstudios.com/team/brad-williams/">Brad Williams</a> and <a title="Lisa Sabin-Wilson" href="http://webdevstudios.com/team/lisa-sabin-wilson/">Lisa Sabin-Wilson</a>, a free hour of consultation on your project, or even a guest blog post; enabling you to promote your own business!</p>
<p>Every week will be something different. Ranging from trivia question about <a href="http://webdevstudios.com/wordpress">WordPress</a>, <a href="http://webdevstudios.com/buddypress">BuddyPress</a>, or bbPress &#8212; to sending in a picture of your workspace, or yourself in an awesomely creative WordPress t-shirt. My all time favorite &#8212; &#8220;Stump Brad&#8221;; which will give you an opportunity to ask Brad Williams questions about WordPress development. He will not be able to use Google, or any other source of knowledge, except his own brain! If you &#8220;Stump&#8221; him, the prize is yours!</p>
<p><img class="alignleft size-full wp-image-6970" alt="Professional WordPress by Brad Williams" src="http://webdevstudios.com/wp-content/uploads/2013/01/pwp1.png" width="120" height="151" />For our first GIVEAWAY TUESDAY  - today, January 29, 2013 &#8211; starting a 12:00pm (Noon, EST) we are holding a WordPress trivia contest on Twitter!  Watch our twitter account: <a href="http://twitter.com/webdevstudios">@WebDevStudios</a>, and the hashtag: <a href="https://twitter.com/search?q=%23wdsgiveaway">#wdsgiveaway</a> for your chance to win!  The people with the most correct answers get put into a drawing to win a signed copy of Brad&#8217;s <a href="http://bit.ly/prowp2">Professional WordPress</a> book, now in its 2nd edition!</p>
<p>The questions will be asked on Twitter and you must respond with you answer AND the #wdsgiveaway hashtag in order to win.  Winners will be announced, via Twitter, at the end of the day (by 5:00pm EST).  Good luck to everyone!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:73:"http://webdevstudios.com/2013/01/29/webdevstudios-giveaway-tuesdays/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"2";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:51:"
		
		
		
		
		
				
		
		
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"Products We Love: Gravity Forms";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:67:"http://webdevstudios.com/2013/01/28/products-we-love-gravity-forms/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:76:"http://webdevstudios.com/2013/01/28/products-we-love-gravity-forms/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 28 Jan 2013 15:15:01 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:4:{i:0;a:5:{s:4:"data";s:7:"Plugins";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:16:"Products We Love";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:13:"Gravity Forms";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:3;a:5:{s:4:"data";s:8:"Products";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"http://webdevstudios.com/?p=6555";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:313:"Gravity Forms requires no coding skills to create a number of different forms with different fields, a variety of functionality and many notification options. <a class="more-link" href="http://webdevstudios.com/2013/01/28/products-we-love-gravity-forms/">Continue reading <span class="meta-nav">&#8594;</span></a>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"April Williams";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:5345:"<p>WordPress wouldn&#8217;t be such a great platform without the amazing community that surrounds it.  The people who work with WordPress have created some truly great products that have become a necessity in most (if not all!) of our projects.  Because these are so important to us and out business, we thought we should share them with you!</p>
<p><a href="http://webdevstudios.com/go/gravity-forms/"><img class="alignleft size-full wp-image-5414" title="125x125" alt="" src="http://webdevstudios.com/wp-content/uploads/2010/12/125x125.gif" width="125" height="125" /></a>One WordPress plugin that we absolutely love is Gravity Forms!  <a title="Gravity Forms" href="http://webdevstudios.com/go/gravity-forms/">Gravity Forms</a> is one of my personal favorites and I know that I&#8217;m not alone. This plugin is listed on top plugin lists all over the internet and in numerous WordCamp presentations.  One of my favorite things about Gravity Forms is that it requires no coding skills to create a number of different forms with different fields, a variety of functionality and many notification options.  Having no coding abilities, this plugin is perfect for me!</p>
<p>If you have a general knowledge of the WordPress admin dashboard you should have no problem working with Gravity Forms! It is so versatile and can be used for a variety of needs. You really can create ANY form from a simple contact form to a robust, multi-page form that will notify different people based on different responses. No matter what kind of form you are looking to create, the drag and drop editor makes it easy and painless!</p>
<blockquote><p><span style="color: #fd9212;">&#8220;<strong>Least favorite plugin?</strong></span><br />
<span style="color: #808080;"><span style="color: #fd9212;"> Every contact form plugin that isn’t Gravity Forms (and they aren’t paying me to say that, but seriously, you should be Carl <img src=\'http://webdevstudios.com/wp-includes/images/smilies/icon_razz.gif\' alt=\':P\' class=\'wp-smiley\' />  ). There is nothing that is even in the same universe as Gravity Forms when it comes to contact form plugins. The best part is contact forms are one of the features I use the least. The fact that I can create posts from form entries is a HUGE time saver. If you don’t own it, you should. -</span><a href="http://wpengine.com/2013/01/brad-williams/" target="_blank">Brad Williams interview with WP Engine</a></span></p></blockquote>
<p>Gravity Forms has allowed me to create a number of forms without any help from a developer. This is a really big deal to me because WebDev is a very busy company and requests for updates on our own website always get pushed behind our client work.</p>
<p>Here are a few examples of forms I have been able to make with no assistance from a developer:</p>
<ul>
<li>I set up a great project request form <a title="Contact WDS" href="/contact/">here on our website</a>. When you select a Reason for Contact, the forms fields change to reflect that selection.</li>
<li>For our Jobs page I created a <a title="Jobs at WDS" href="/contact/jobs/">job inquiry form</a> that allows the user to upload documents. Emails are then forwarded to different people based on the job request and who will be reviewing the applications.</li>
<li>On <em>Tips on Trips and Camps</em> I used Gravity Forms to <a href="http://www.tipsontripsandcamps.com/register/">create a form where the visitor can request information on a specific type of of camp experience</a>. I used the multi-page feature to make the form less overwhelming and if you click on Language, Religious or Other you will see additional questions pop up regarding that selection. We also used the <a href="http://www.gravityforms.com/add-ons/user-registration/">Gravity Forms User Registration Add-On</a> to allow visitors to create an account at the end of the questionnaire.</li>
</ul>
<p>If you are a developer you can go far beyond the example I have above. The options with this plugin are seemingly <em>endless</em>. If you are lucky enough to have a <a title="About WDS" href="/about/team/">great development team</a> like I do, you can go well beyond forms with this plugin!  WDS has used Gravity Forms to create some really cool and helpful features for our clients:</p>
<ul>
<li>Custom Gravity Forms Add-Ons &#8211; We have built a number of add-ons depending on the clients needs. On example is an add-on that creates additional, specific fields beyond the options included in Gravity Forms and integrate these new fields seamlessly into the form setup.</li>
<li>Custom form processing- After form submitted the data is sent to another location outside of WordPress. For example we built a bridge between WordPress and SQL server and took submissions from Gravity Forms and copied them to an external SQL server database.</li>
<li>Gravity Form eCommerce integration- We built an add-on that automatically sends the visitor to WooCommerce to purchase an item after they fill out a Gravity Form.</li>
</ul>
<p>What do you guys think of Gravity Forms? Have you used the plugin in a different way than just creating forms? If you haven&#8217;t already go buy a copy of  <a title="Gravity Forms" href="http://webdevstudios.com/go/gravity-forms/">Gravity Forms</a> and check it out. You WON&#8217;T be disappointed!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:72:"http://webdevstudios.com/2013/01/28/products-we-love-gravity-forms/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:51:"
		
		
		
		
		
				
		
		
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:48:"Easy Digital Downloads Product Support Extension";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:85:"http://webdevstudios.com/2013/01/23/easy-digital-downloads-product-support-extension/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:94:"http://webdevstudios.com/2013/01/23/easy-digital-downloads-product-support-extension/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 23 Jan 2013 17:52:51 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:4:{i:0;a:5:{s:4:"data";s:10:"BuddyPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:7:"Plugins";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:7:"bbPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:3;a:5:{s:4:"data";s:22:"Easy Digital Downloads";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"http://webdevstudios.com/?p=7078";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:461:"WebDevStudios has created an extension for the popular Easy Digital Downloads (EDD) plugin that allows you to have easy support options right at your finger tips for your customers with bbPress or BuddyPress!  It is available for purchase and download within the Easy Digital &#8230; <a class="more-link" href="http://webdevstudios.com/2013/01/23/easy-digital-downloads-product-support-extension/">Continue reading <span class="meta-nav">&#8594;</span></a>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Melissa Hoppe";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:3269:"<p>WebDevStudios has created an extension for the popular <a href="http://webdevstudios.com/go/edd/" target="_blank">Easy Digital Downloads</a> (EDD) plugin that allows you to have easy support options right at your finger tips for your customers with bbPress or <a title="BuddyPress" href="http://webdevstudios.com/buddypress/">BuddyPress</a>!  It is available for purchase and download within the <a href="https://easydigitaldownloads.com/extension/product-support/">Easy Digital Downloads extensions store</a> for purchase, starting at just $49.00.</p>
<p>Our <a href="https://easydigitaldownloads.com/extension/product-support/">Product Support </a>extension for EDD is a simple solution for managing product support, with our hassle free EDD Product Support extension.</p>
<p>This extension for the EDD Product Support was developed by WebDevStudios to work right alongside with either BuddyPress or bbPress. It helps you automatically create forums, link products, and automatically grant users access when they purchase a product. When using BuddyPress, users will only gain access to groups that correspond to the product that is purchased.</p>
<p><a href="https://easydigitaldownloads.com/extension/product-support/"><img class="wp-image-7079 alignnone" title="Easy Digital Download Product Support " alt="Easy Digital Download Product Support " src="http://webdevstudios.com/wp-content/uploads/2013/01/edd_product_support1.png" width="559" height="350" /></a></p>
<p>Some of the key features are; automatically create new groups/forums, associate products with any existing groups/forums, automatically add users to correct groups on completed purchase (BuddyPress only) and automatically create first post in each new forum.</p>
<p>Also, EDD doesn’t interfere with existing bbPress and BuddyPress functionality at all, so you can still manually create Groups/forums and add users like you always have!  Check out these great features:</p>
<ul>
<li>Automatically create new groups/forums</li>
<li>Associate products with any existing groups/forums</li>
<li>Automatically add users to correct groups on completed purchase (BuddyPress only)</li>
<li>Automatically create first post in each new forum</li>
<li>Doesn’t interfere with existing bbPress and BuddyPress functionality (you can still manually create Groups/forums and add users like you always have)</li>
</ul>
<p>If you’re looking for product support that’s easy to manage, we highly recommend that you install BuddyPress (a free plugin) and enable User Groups and Discussion Forums. It will give you the best control over who has access to what. With the addition of the EDD Product Support, you can completely automate group creation and user addition!</p>
<p><strong>Some Practical Use Cases:</strong></p>
<ul>
<li>Support Packages for service-based clients</li>
<li>Supporting your digital goods</li>
<li>Building paid-community sites (best with BuddyPress)</li>
</ul>
<p>At WebDevStudios, we are experts in the area of WordPress and BuddyPress &#8211; if you are interested in having WebDevStudios create a WordPress website for you (with bbPress and BuddyPress, too, if you want!) - <a href="http://webdevstudios.com/contact/">Contact us</a> today to discuss your project!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:90:"http://webdevstudios.com/2013/01/23/easy-digital-downloads-product-support-extension/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:54:"
		
		
		
		
		
				
		
		
		
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:56:"StartBox Easy Hooks: Easily add custom code to your site";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:92:"http://webdevstudios.com/2013/01/23/startbox-easy-hooks-easily-add-custom-code-to-your-site/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:101:"http://webdevstudios.com/2013/01/23/startbox-easy-hooks-easily-add-custom-code-to-your-site/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 23 Jan 2013 15:15:42 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:5:{i:0;a:5:{s:4:"data";s:8:"Startbox";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:8:"StartBox";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:6:"themes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:3;a:5:{s:4:"data";s:13:"WebDevStudios";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:4;a:5:{s:4:"data";s:9:"WordPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"http://webdevstudios.com/?p=7110";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:379:"At the end of 2012, WebDevStudios acquired the StartBox Theme Framework from their very own Brian Richards. With that acquisition came all of the plugins that were officially associated with StartBox <a class="more-link" href="http://webdevstudios.com/2013/01/23/startbox-easy-hooks-easily-add-custom-code-to-your-site/">Continue reading <span class="meta-nav">&#8594;</span></a>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Michael Beckwith";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:1664:"<p>At the end of 2012, WebDevStudios acquired the <a href="http://wpstartbox.com/">StartBox Theme Framework</a> from their very own Brian Richards. With that acquisition came all of the plugins that were officially associated with StartBox. Now StartBox has an entire team behind it to help ensure quality code in the framework and plugins.</p>
<p><a href="http://wordpress.org/extend/plugins/startbox-easy-hooks/"><img class="alignleft  wp-image-7111" alt="easyhooks" src="http://webdevstudios.com/wp-content/uploads/2013/01/easyhooks.png" width="286" height="255" /></a></p>
<p>I was blessed with the task to upgrade the Easy Hooks plugin and I am very happy with the end result. The plugin code was rewritten from the bottom up, while retaining the functionality and end result: a settings page to add code or markup and attach it to any StartBox hook on the frontend.</p>
<p>Along with that, we made sure to keep it translation ready and easily extensible if you want to add your own hooks to the settings page. It doesn&#8217;t have to be limited to just what we add!</p>
<p>If you&#8217;re a StartBox framework user and want to make it easier for you or your clients to add code or content to the site, go ahead and give StartBox Easy Hooks a whirl. Just search &#8220;StartBox Easy Hooks&#8221; in your Add New Plugins screen in the WordPress admin or download it <a href="http://wordpress.org/extend/plugins/startbox-easy-hooks/">directly from the WordPress plugins repository</a>.</p>
<p>Related Posts:</p>
<p><a href="http://webdevstudios.com/2012/11/28/startbox-finds-a-new-home-with-webdevstudios/">Startbox Finds a New Home with WebDevStudios</a></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:97:"http://webdevstudios.com/2013/01/23/startbox-easy-hooks-easily-add-custom-code-to-your-site/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:57:"
		
		
		
		
		
				
		
		
		
		
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:54:"YMCA Pilots a WordPress Powered iPad Application Y-MVP";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:91:"http://webdevstudios.com/2013/01/18/ymca-pilots-a-wordpress-powered-ipad-application-y-mvp/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:100:"http://webdevstudios.com/2013/01/18/ymca-pilots-a-wordpress-powered-ipad-application-y-mvp/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 18 Jan 2013 17:30:53 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:6:{i:0;a:5:{s:4:"data";s:10:"BuddyPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:9:"WordPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:11:"Application";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:3;a:5:{s:4:"data";s:6:"badges";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:4;a:5:{s:4:"data";s:7:"web app";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:5;a:5:{s:4:"data";s:4:"ymca";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"http://webdevstudios.com/?p=7099";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:383:"WebDevStudios is very proud to announce the release of the Y-MVP application that we developed for the YMCA of Greater New York. Y-MVP is a social fitness application powered by WordPress and BuddyPress.  <a class="more-link" href="http://webdevstudios.com/2013/01/18/ymca-pilots-a-wordpress-powered-ipad-application-y-mvp/">Continue reading <span class="meta-nav">&#8594;</span></a>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Melissa Hoppe";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:2728:"<p>WebDevStudios is very proud to announce the release of the Y-MVP application that we developed for the YMCA of Greater New York. Y-MVP is a social fitness application powered by <a title="WordPress Applications" href="http://webdevstudios.com/wordpress/">WordPress</a> and <a title="BuddyPress Custom Applications" href="http://webdevstudios.com/buddypress/">BuddyPress</a>. It is a great example of how WordPress can be extended as an application framework. It has been developed specifically for the iPad.</p>
<p><a href="http://webdevstudios.com/wp-content/uploads/2013/01/YMVP-Badge.jpg" rel="shadowbox[sbpost-7099];player=img;"><img class="alignleft size-thumbnail wp-image-7100" alt="Y-MVP Badge Application" src="http://webdevstudios.com/wp-content/uploads/2013/01/YMVP-Badge-150x150.jpg" width="150" height="150" /></a><strong>YMVP &#8211; A Game Changer</strong><br />
&#8220;Adopting online game design techniques, New York City’s YMCA has created a dynamic badge system that motivates, recognizes and rewards young people’s MVP levels while helping them to create life-long healthy habits.&#8221;<br />
- <a href="http://www.ymcanyc.org/association/pages/y-mvp">YMCA-MVP: A Game Changer</a></p>
<h3>How Does it Work?</h3>
<p>Participants scan their membership card at a Y-MVP iPad kiosk which is where the fun begins! As participants log their exercises and increase their training time, they earn virtual badges and accumulate points. The digital badges “unlock” additional privileges (e.g., access to fitness classes), incentives (e.g., t-shirts, water bottles) and help them set new goals. The badge progression serves to empower kids to develop the knowledge and skills to take responsibility for their own personal fitness and celebrate their accomplishments.</p>
<h3>Check out this awesome video produced by YMCA that highlights the application:</h3>
<p><span class=\'embed-youtube\' style=\'text-align:center; display: block;\'><iframe class=\'youtube-player\' type=\'text/html\' width=\'615\' height=\'376\' src=\'http://www.youtube.com/embed/KVpBVTGop1c?version=3&#038;rel=1&#038;fs=1&#038;showsearch=0&#038;showinfo=1&#038;iv_load_policy=1&#038;wmode=transparent\' frameborder=\'0\'></iframe></span></p>
<h3>Where Can I See Y-MVP in Action?</h3>
<p>Y-MVP is currently a pilot program at the <a href="http://www.ymcanyc.org/bedstuy">Bedford-Stuyvesant</a> YMCA, in Brooklyn, NY. This year the Y plans to expand the pilot to other branches in New York with the goal of having the Y-MVP program functioning citywide by 2014.</p>
<p>Interested in having WebDevStudios help you to create a WordPress powered application? <a href="http://webdevstudios.com/contact/">Contact us</a> today to discuss your project!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:96:"http://webdevstudios.com/2013/01/18/ymca-pilots-a-wordpress-powered-ipad-application-y-mvp/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:57:"
		
		
		
		
		
				
		
		
		
		
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:45:"WebDevStudios is Attending NMX 2013 Las Vegas";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:81:"http://webdevstudios.com/2013/01/04/talk-about-wordpress-nmx-blogworld-las-vegas/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:90:"http://webdevstudios.com/2013/01/04/talk-about-wordpress-nmx-blogworld-las-vegas/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 04 Jan 2013 15:14:53 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:6:{i:0;a:5:{s:4:"data";s:10:"BuddyPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:9:"WordPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:4:"2013";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:3;a:5:{s:4:"data";s:14:"BlogWorld Expo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:4;a:5:{s:4:"data";s:9:"Las Vegas";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:5;a:5:{s:4:"data";s:3:"NMX";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"http://webdevstudios.com/?p=7022";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:408:"Brian Messenlehner (and his hat) from WDS will be attending the New Media Expo formerly known as BlogWorld at the Rio Hotel and Casino in Las Vegas from January 6th through January 8th. NMX is the largest conference and trade show &#8230; <a class="more-link" href="http://webdevstudios.com/2013/01/04/talk-about-wordpress-nmx-blogworld-las-vegas/">Continue reading <span class="meta-nav">&#8594;</span></a>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:18:"Brian Messenlehner";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:1266:"<p><a href="http://webdevstudios.com/wp-content/uploads/2013/01/nmx.png" rel="shadowbox[sbpost-7022];player=img;"><img class="size-full wp-image-7023 alignleft" alt="nmx" src="http://webdevstudios.com/wp-content/uploads/2013/01/nmx.png" width="240" height="240" /></a></p>
<p>Brian Messenlehner (and his hat) from WDS will be attending the <a title="NMX/BlogWorld" href="http://nmxlive.com" target="_blank">New Media Expo</a> formerly known as BlogWorld at the Rio Hotel and Casino in Las Vegas from January 6th through January 8th. NMX is the largest conference and trade show for bloggers and social media, so being <a title="WebDevStudios - WordPress Experts" href="http://webdevstudios.com/wordpress/" target="_blank">WordPress experts</a> this is right down our alley. Brian will be floating around talking up WebDevStudios and about how WDS is the best WordPress development shop on this planet! If you are also attending NMX and see him, grab him and talk shop! If you would like to meetup with Brian while at the event to discuss potential projects, have a drink or three, or just to kick it, connect with @bmess on <a href="https://twitter.com/bmess" target="_blank">Twitter</a> or <a href="http://www.facebook.com/bmess" target="_blank">Facebook</a>.</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:86:"http://webdevstudios.com/2013/01/04/talk-about-wordpress-nmx-blogworld-las-vegas/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:48:"
		
		
		
		
		
				
		
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:35:"Merry Christmas from WebDevStudios!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:76:"http://webdevstudios.com/2012/12/25/merry-christmas-from-webdevstudios-2012/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:85:"http://webdevstudios.com/2012/12/25/merry-christmas-from-webdevstudios-2012/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 25 Dec 2012 14:00:32 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:3:{i:0;a:5:{s:4:"data";s:7:"General";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:9:"Christmas";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:3:"WDS";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"http://webdevstudios.com/?p=6855";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Brad Williams";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:345:"<p><a href="http://webdevstudios.com/wp-content/uploads/2009/12/merry-christmas-from-wds.jpg" rel="shadowbox[sbpost-6855];player=img;"><img class="alignleft size-full wp-image-6395" title="merry-christmas-from-wds" src="http://webdevstudios.com/wp-content/uploads/2009/12/merry-christmas-from-wds.jpg" alt="" width="428" height="504" /></a></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:81:"http://webdevstudios.com/2012/12/25/merry-christmas-from-webdevstudios-2012/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}s:44:"http://purl.org/rss/1.0/modules/syndication/";a:2:{s:12:"updatePeriod";a:1:{i:0;a:5:{s:4:"data";s:6:"hourly";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:15:"updateFrequency";a:1:{i:0;a:5:{s:4:"data";s:1:"1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:27:"http://www.w3.org/2005/Atom";a:1:{s:4:"link";a:2:{i:0;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:3:{s:3:"rel";s:4:"self";s:4:"type";s:19:"application/rss+xml";s:4:"href";s:41:"http://feeds.feedburner.com/webdevstudios";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:2:{s:3:"rel";s:3:"hub";s:4:"href";s:32:"http://pubsubhubbub.appspot.com/";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:42:"http://rssnamespace.org/feedburner/ext/1.0";a:3:{s:4:"info";a:1:{i:0;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:1:{s:3:"uri";s:13:"webdevstudios";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:14:"emailServiceId";a:1:{i:0;a:5:{s:4:"data";s:13:"webdevstudios";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:18:"feedburnerHostname";a:1:{i:0;a:5:{s:4:"data";s:28:"http://feedburner.google.com";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";a:9:{s:12:"content-type";s:23:"text/xml; charset=UTF-8";s:4:"etag";s:27:"WIYEErs0V7tNPL2l2H1MrHWnQZk";s:13:"last-modified";s:29:"Wed, 06 Feb 2013 21:30:35 GMT";s:4:"date";s:29:"Wed, 06 Feb 2013 21:36:51 GMT";s:7:"expires";s:29:"Wed, 06 Feb 2013 21:36:51 GMT";s:13:"cache-control";s:18:"private, max-age=0";s:22:"x-content-type-options";s:7:"nosniff";s:16:"x-xss-protection";s:13:"1; mode=block";s:6:"server";s:3:"GSE";}s:5:"build";s:14:"20121202214312";}', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (156, '_transient_timeout_feed_mod_c809918297b2c893fd8504c06adcaf00', '1360229811', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (157, '_transient_feed_mod_c809918297b2c893fd8504c06adcaf00', '1360186611', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (159, 'acf_version', '4.0.3', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (160, 'acf_next_field_id', '10', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (164, '_site_transient_timeout_browser_3b819aedd9307a47000b5b77ea28842a', '1362456953', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (165, '_site_transient_browser_3b819aedd9307a47000b5b77ea28842a', 'a:9:{s:8:"platform";s:9:"Macintosh";s:4:"name";s:6:"Chrome";s:7:"version";s:12:"25.0.1364.99";s:10:"update_url";s:28:"http://www.google.com/chrome";s:7:"img_src";s:49:"http://s.wordpress.org/images/browsers/chrome.png";s:11:"img_src_ssl";s:48:"https://wordpress.org/images/browsers/chrome.png";s:15:"current_version";s:2:"18";s:7:"upgrade";b:0;s:8:"insecure";b:0;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (196, '_site_transient_timeout_poptags_40cd750bba9870f18aada2478b24840a', '1361862998', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (197, '_site_transient_poptags_40cd750bba9870f18aada2478b24840a', 'a:40:{s:6:"widget";a:3:{s:4:"name";s:6:"widget";s:4:"slug";s:6:"widget";s:5:"count";s:4:"3406";}s:4:"post";a:3:{s:4:"name";s:4:"Post";s:4:"slug";s:4:"post";s:5:"count";s:4:"2207";}s:6:"plugin";a:3:{s:4:"name";s:6:"plugin";s:4:"slug";s:6:"plugin";s:5:"count";s:4:"2091";}s:5:"admin";a:3:{s:4:"name";s:5:"admin";s:4:"slug";s:5:"admin";s:5:"count";s:4:"1732";}s:5:"posts";a:3:{s:4:"name";s:5:"posts";s:4:"slug";s:5:"posts";s:5:"count";s:4:"1645";}s:7:"sidebar";a:3:{s:4:"name";s:7:"sidebar";s:4:"slug";s:7:"sidebar";s:5:"count";s:4:"1450";}s:7:"twitter";a:3:{s:4:"name";s:7:"twitter";s:4:"slug";s:7:"twitter";s:5:"count";s:4:"1165";}s:6:"google";a:3:{s:4:"name";s:6:"google";s:4:"slug";s:6:"google";s:5:"count";s:4:"1161";}s:8:"comments";a:3:{s:4:"name";s:8:"comments";s:4:"slug";s:8:"comments";s:5:"count";s:4:"1153";}s:6:"images";a:3:{s:4:"name";s:6:"images";s:4:"slug";s:6:"images";s:5:"count";s:4:"1119";}s:4:"page";a:3:{s:4:"name";s:4:"page";s:4:"slug";s:4:"page";s:5:"count";s:4:"1066";}s:5:"image";a:3:{s:4:"name";s:5:"image";s:4:"slug";s:5:"image";s:5:"count";s:3:"983";}s:5:"links";a:3:{s:4:"name";s:5:"links";s:4:"slug";s:5:"links";s:5:"count";s:3:"892";}s:3:"seo";a:3:{s:4:"name";s:3:"seo";s:4:"slug";s:3:"seo";s:5:"count";s:3:"836";}s:8:"facebook";a:3:{s:4:"name";s:8:"Facebook";s:4:"slug";s:8:"facebook";s:5:"count";s:3:"826";}s:9:"shortcode";a:3:{s:4:"name";s:9:"shortcode";s:4:"slug";s:9:"shortcode";s:5:"count";s:3:"767";}s:9:"wordpress";a:3:{s:4:"name";s:9:"wordpress";s:4:"slug";s:9:"wordpress";s:5:"count";s:3:"724";}s:7:"gallery";a:3:{s:4:"name";s:7:"gallery";s:4:"slug";s:7:"gallery";s:5:"count";s:3:"719";}s:6:"social";a:3:{s:4:"name";s:6:"social";s:4:"slug";s:6:"social";s:5:"count";s:3:"665";}s:3:"rss";a:3:{s:4:"name";s:3:"rss";s:4:"slug";s:3:"rss";s:5:"count";s:3:"664";}s:5:"pages";a:3:{s:4:"name";s:5:"pages";s:4:"slug";s:5:"pages";s:5:"count";s:3:"617";}s:7:"widgets";a:3:{s:4:"name";s:7:"widgets";s:4:"slug";s:7:"widgets";s:5:"count";s:3:"613";}s:6:"jquery";a:3:{s:4:"name";s:6:"jquery";s:4:"slug";s:6:"jquery";s:5:"count";s:3:"593";}s:4:"ajax";a:3:{s:4:"name";s:4:"AJAX";s:4:"slug";s:4:"ajax";s:5:"count";s:3:"573";}s:5:"email";a:3:{s:4:"name";s:5:"email";s:4:"slug";s:5:"email";s:5:"count";s:3:"524";}s:5:"media";a:3:{s:4:"name";s:5:"media";s:4:"slug";s:5:"media";s:5:"count";s:3:"503";}s:10:"buddypress";a:3:{s:4:"name";s:10:"buddypress";s:4:"slug";s:10:"buddypress";s:5:"count";s:3:"498";}s:10:"javascript";a:3:{s:4:"name";s:10:"javascript";s:4:"slug";s:10:"javascript";s:5:"count";s:3:"496";}s:5:"video";a:3:{s:4:"name";s:5:"video";s:4:"slug";s:5:"video";s:5:"count";s:3:"490";}s:4:"feed";a:3:{s:4:"name";s:4:"feed";s:4:"slug";s:4:"feed";s:5:"count";s:3:"471";}s:5:"photo";a:3:{s:4:"name";s:5:"photo";s:4:"slug";s:5:"photo";s:5:"count";s:3:"466";}s:7:"content";a:3:{s:4:"name";s:7:"content";s:4:"slug";s:7:"content";s:5:"count";s:3:"444";}s:6:"photos";a:3:{s:4:"name";s:6:"photos";s:4:"slug";s:6:"photos";s:5:"count";s:3:"441";}s:4:"link";a:3:{s:4:"name";s:4:"link";s:4:"slug";s:4:"link";s:5:"count";s:3:"432";}s:8:"category";a:3:{s:4:"name";s:8:"category";s:4:"slug";s:8:"category";s:5:"count";s:3:"404";}s:4:"spam";a:3:{s:4:"name";s:4:"spam";s:4:"slug";s:4:"spam";s:5:"count";s:3:"401";}s:5:"stats";a:3:{s:4:"name";s:5:"stats";s:4:"slug";s:5:"stats";s:5:"count";s:3:"399";}s:5:"flash";a:3:{s:4:"name";s:5:"flash";s:4:"slug";s:5:"flash";s:5:"count";s:3:"383";}s:7:"youtube";a:3:{s:4:"name";s:7:"youtube";s:4:"slug";s:7:"youtube";s:5:"count";s:3:"382";}s:7:"comment";a:3:{s:4:"name";s:7:"comment";s:4:"slug";s:7:"comment";s:5:"count";s:3:"378";}}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (199, 'hmbkp_default_path', '/Applications/MAMP/htdocs/allisongrayce.com/wp-content/c4ca4238a0-backups', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (200, 'hmbkp_path', '/Applications/MAMP/htdocs/allisongrayce.com/wp-content/c4ca4238a0-backups', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (201, 'hmbkp_schedule_default-1', 'a:4:{s:4:"type";s:8:"complete";s:12:"reoccurrence";s:8:"manually";s:11:"max_backups";i:14;s:19:"HMBKP_Email_Service";a:1:{s:5:"email";s:0:"";}}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (202, 'hmbkp_schedule_default-2', 'a:3:{s:4:"type";s:8:"complete";s:12:"reoccurrence";s:6:"weekly";s:11:"max_backups";i:12;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (203, 'hmbkp_plugin_version', '2.2.4', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (208, '_transient_timeout_hmbkp_schedule_default-1_filesize', '2723790872', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (209, '_transient_hmbkp_schedule_default-1_filesize', '16585702', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (215, 'current_theme', 'Portfolio for Allison Grayce', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (216, 'theme_mods_wpportfolio', 'a:1:{i:0;b:0;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (217, 'theme_switched', '', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (218, 'theme_mods_twentytwelve', 'a:1:{s:16:"sidebars_widgets";a:2:{s:4:"time";i:1361860352;s:4:"data";a:4:{s:19:"wp_inactive_widgets";a:0:{}s:9:"sidebar-1";a:6:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";i:3;s:10:"archives-2";i:4;s:12:"categories-2";i:5;s:6:"meta-2";}s:9:"sidebar-2";a:0:{}s:9:"sidebar-3";a:0:{}}}}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (220, '_site_transient_timeout_theme_roots', '1366314536', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (221, '_site_transient_theme_roots', 'a:3:{s:12:"twentyeleven";s:7:"/themes";s:12:"twentytwelve";s:7:"/themes";s:11:"wpportfolio";s:7:"/themes";}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (222, '_site_transient_timeout_browser_3416e82921be08c0281cc5c660204f80', '1366917582', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (223, '_site_transient_browser_3416e82921be08c0281cc5c660204f80', 'a:9:{s:8:"platform";s:9:"Macintosh";s:4:"name";s:6:"Chrome";s:7:"version";s:12:"26.0.1410.65";s:10:"update_url";s:28:"http://www.google.com/chrome";s:7:"img_src";s:49:"http://s.wordpress.org/images/browsers/chrome.png";s:11:"img_src_ssl";s:48:"https://wordpress.org/images/browsers/chrome.png";s:15:"current_version";s:2:"18";s:7:"upgrade";b:0;s:8:"insecure";b:0;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (224, '_transient_timeout_feed_ac0b00fe65abe10e0c5b588f3ed8c7ca', '1366355983', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (225, '_transient_feed_ac0b00fe65abe10e0c5b588f3ed8c7ca', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"


";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:50:"
	
	
	
	
	
	
	
	
	
		
		
		
		
		
		
		
		
		
		
	";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:3:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:14:"WordPress News";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:25:"http://wordpress.org/news";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:14:"WordPress News";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:13:"lastBuildDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 11 Apr 2013 13:48:42 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:5:"en-US";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"generator";a:1:{i:0;a:5:{s:4:"data";s:39:"http://wordpress.org/?v=3.6-beta1-24021";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:10:{i:0;a:6:{s:4:"data";s:42:"
		
		
		
		
		
				

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:21:"Save the Date: May 27";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2013/04/save-the-date-may-27/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:64:"http://wordpress.org/news/2013/04/save-the-date-may-27/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 11 Apr 2013 13:48:42 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:13:"Uncategorized";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2555";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:325:"What&#8217;s on May 27, you ask? May 27, 2013 is the 10th anniversary of the first WordPress release! We think this is worth celebrating, and we want WordPress fans all over the world to celebrate with us by throwing their own parties. We&#8217;re using Meetup Everywhere to coordinate, and will be putting up a website [...]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Jen Mylo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:2102:"<p>What&#8217;s on May 27, you ask?</p>
<p>May 27, 2013 is the <strong>10th anniversary</strong> of the <a href="http://wordpress.org/news/2003/05/wordpress-now-available/">first WordPress release</a>!</p>
<p>We think this is worth celebrating, and we want WordPress fans all over the world to celebrate with us by throwing their own parties. <a href="http://www.meetup.com/WordPress/">We&#8217;re using Meetup Everywhere</a> to coordinate, and will be putting up a website just for the 10th Anniversary so that we can collect photos, videos, tweets, and posts from all the parties.</p>
<p>The rules are very simple:</p>
<ol>
<li><span style="line-height: 12.997159004211426px">Pick a place to go where a bunch of people can be merry &#8212; a park, a bar, a backyard, whatever</span></li>
<li>Spread the word to local meetups, tech groups, press, etc and get people to say they&#8217;ll come to your party</li>
<li>If 50 or more people RSVP to your party, we&#8217;ll try to send you some WordPress stickers and buttons</li>
<li>Have party attendees post photos, videos, and the like with the #wp10 hashtag</li>
</ol>
<p>We&#8217;ll be using Meetup Everywhere to coordinate parties all over the world, so get your city on the map and <a href="http://www.meetup.com/WordPress/">register your party now</a> !</p>
<p>We&#8217;ll follow up with registered organizers  over the next few weeks with some tips for how to publicize your party and to get addresses for swag packages. To that end, make sure you check the option that lets WordPress 10th Anniversary know your email, or we won&#8217;t be able to get in touch with you for these things or to give you access to the WP10 blog.</p>
<p>Whose party will be the biggest? The most fun? The most inventive? Will it be yours?</p>
<p><em>Note: If you already run a group on meetup.com, making your party an event in your group is great, but you still need to post it and have people RSVP at the <a href="http://www.meetup.com/WordPress/">special party page</a>, because regular groups and Meetup Everywhere groups aren&#8217;t connected yet. </em></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:60:"http://wordpress.org/news/2013/04/save-the-date-may-27/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:42:"
		
		
		
		
		
				

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:20:"WordPress 3.6 Beta 1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2013/04/wordpress-3-6-beta-1/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:64:"http://wordpress.org/news/2013/04/wordpress-3-6-beta-1/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 04 Apr 2013 17:25:29 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:13:"Uncategorized";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2547";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:377:"WordPress 3.6 Beta 1 is now available! This is software still in development and we really don’t recommend that you run it on a production site — set up a test site just to play with the new version. To test WordPress 3.6, try the WordPress Beta Tester plugin (you’ll want “bleeding edge nightlies”). Or you can download the beta here (zip). We&#8217;ve [...]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Mark Jaquith";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:4085:"<p>WordPress 3.6 Beta 1 is now available!</p>
<p>This is software still in development and <strong>we <em>really</em> don’t recommend that you run it on a production site</strong> — set up a test site just to play with the new version. To test WordPress 3.6, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you’ll want “bleeding edge nightlies”). Or you can <a href="http://wordpress.org/wordpress-3.6-beta1.zip">download the beta here</a> (zip).</p>
<p>We&#8217;ve been working for nearly three months and have completed all the features that are slated for this release. This is a bit of a change from the betas of previous release cycles. I felt very strongly that we shouldn&#8217;t release a beta if we were still working on completing the main features. This beta is <strong>actually a beta</strong>, not an alpha that we&#8217;re calling a beta. If you are a WordPress plugin or theme developer, or a WordPress hosting provider, you should absolutely start testing your code against this new version <strong>now</strong>. More bugs will be fixed, and some of the features will get polished, but we&#8217;re not going to shove in some big new feature. We&#8217;re ready for you to test it, so jump in there! The more you test the beta, the more stable our release candidates and our final release will be.</p>
<p>As always, if you think you’ve found a bug, you can post to the <a href="http://wordpress.org/support/forum/alphabeta">Alpha/Beta area</a> in the support forums. Or, if you’re comfortable writing a reproducible bug report, <a href="http://core.trac.wordpress.org/">file one on the WordPress Trac</a>. There, you can also find <a href="http://core.trac.wordpress.org/report/5">a list of known bugs</a> and <a href="http://core.trac.wordpress.org/query?status=closed&amp;group=component&amp;milestone=3.6">everything we&#8217;ve fixed</a> so far.</p>
<p>Here&#8217;s what&#8217;s new in 3.6:</p>
<ul>
<li><strong>Post Formats: </strong> Post Formats now have their own UI, and theme authors have access to templating functions to access the structured data.</li>
<li><strong>Twenty Thirteen:</strong> We&#8217;re shipping this year&#8217;s default theme in our first release of the year. Twenty Thirteen is an opinionated, color-rich, blog-centric theme that makes full use of the new Post Formats support.</li>
<li><strong>Audio/Video:</strong> You can embed audio and video files into your posts without relying on a plugin or a third party media hosting service.</li>
<li><strong>Autosave: </strong> Posts are now autosaved locally. If your browser crashes, your computer dies, or the server goes offline as you&#8217;re saving, you won&#8217;t lose the your post.</li>
<li><strong>Post Locking: </strong> See when someone is currently editing a post, and kick them out of it if they fall asleep at the keyboard.</li>
<li><strong>Nav Menus: </strong> Nav menus have been simplified with an accordion-based UI, and a separate tab for  bulk-assigning menus to locations.</li>
<li><strong>Revisions:</strong> The all-new revisions UI features avatars, a slider that &#8220;scrubs&#8221; through history, and two-slider range comparisons.</li>
</ul>
<p><strong>Developers: </strong> You make WordPress awesome(er). One of the things we strive to do with every release is be compatible with existing plugins and themes. But we need your help. <strong>Please test your plugins and themes against 3.6.</strong> If something isn&#8217;t quite right, please let us know. (Chances are, it wasn&#8217;t intentional.) If you&#8217;re a forward-thinking theme developer, you should be looking at implementing the new Post Format support in some of your themes (look to Twenty Thirteen for inspiration).</p>
<p>We&#8217;re looking forward to your feedback. If you break it (i.e. find a bug), please report it, and if you’re a developer, try to help us fix it. We&#8217;ve already had more than 150 contributors to version 3.6 — it&#8217;s not too late to join the party!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:60:"http://wordpress.org/news/2013/04/wordpress-3-6-beta-1/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:45:"
		
		
		
		
		
				
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:48:"WordPress 3.5.1 Maintenance and Security Release";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:50:"http://wordpress.org/news/2013/01/wordpress-3-5-1/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:59:"http://wordpress.org/news/2013/01/wordpress-3-5-1/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 24 Jan 2013 22:23:03 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:2:{i:0;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:8:"Security";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2531";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:359:"WordPress 3.5.1 is now available. Version 3.5.1 is the first maintenance release of 3.5, fixing 37 bugs. It is also a security release for all previous WordPress versions. For a full list of changes, consult the list of tickets and the changelog, which include: Editor: Prevent certain HTML elements from being unexpectedly removed or modified in rare [...]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:2499:"<p>WordPress 3.5.1 is now available. Version 3.5.1 is the first maintenance release of 3.5, <a href="http://core.trac.wordpress.org/milestone/3.5.1">fixing 37 bugs</a>. It is also a security release for all previous WordPress versions. For a full list of changes, consult the <a href="http://core.trac.wordpress.org/query?milestone=3.5.1">list of tickets</a> and the <a href="http://core.trac.wordpress.org/log/branches/3.5?rev=23341&amp;stop_rev=23167">changelog</a>, which include:</p>
<ul>
<li>Editor: Prevent certain HTML elements from being unexpectedly removed or modified in rare cases.</li>
<li>Media: Fix a collection of minor workflow and compatibility issues in the new media manager.</li>
<li>Networks: Suggest proper rewrite rules when creating a new network.</li>
<li>Prevent scheduled posts from being stripped of certain HTML, such as video embeds, when they are published.</li>
<li>Work around some misconfigurations that may have caused some JavaScript in the WordPress admin area to fail.</li>
<li>Suppress some warnings that could occur when a plugin misused the database or user APIs.</li>
</ul>
<p>Additionally, a bug affecting Windows servers running IIS can prevent updating from 3.5 to 3.5.1. If you receive the error &#8220;Destination directory for file streaming does not exist or is not writable,&#8221; you will need to <a href="http://codex.wordpress.org/Version_3.5.1">follow the steps outlined on the Codex</a>.</p>
<p>WordPress 3.5.1 also addresses the following security issues:</p>
<ul>
<li>A server-side request forgery vulnerability and remote port scanning using pingbacks. This vulnerability, which could potentially be used to expose information and compromise a site, affects all previous WordPress versions. This was fixed by the WordPress security team. We&#8217;d like to thank security researchers <a href="http://codeseekah.com/">Gennady Kovshenin</a> and <a href="http://www.ethicalhack3r.co.uk/">Ryan Dewhurst</a> for reviewing our work.</li>
<li>Two instances of cross-site scripting via shortcodes and post content. These issues were discovered by Jon Cave of the WordPress security team.</li>
<li>A cross-site scripting vulnerability in the external library Plupload. Thanks to the Moxiecode team for working with us on this, and for releasing Plupload 1.5.5 to address this issue.</li>
</ul>
<p><strong><a href="http://wordpress.org/download/">Download 3.5.1</a> or visit Dashboard → Updates in your site admin to update now.</strong></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2013/01/wordpress-3-5-1/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:42:"
		
		
		
		
		
				

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:17:"2012: A Look Back";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:51:"http://wordpress.org/news/2013/01/2012-a-look-back/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:60:"http://wordpress.org/news/2013/01/2012-a-look-back/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 01 Jan 2013 02:22:20 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:13:"Uncategorized";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2525";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:340:"Another year is coming to a close, and it&#8217;s time to look back and reflect on what we&#8217;ve accomplished in the past twelve months. The WordPress community is stronger than ever, and some of the accomplishments of the past year are definitely worth remembering. Software Releases We had two major releases of the WordPress web [...]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Jen Mylo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:4441:"<p>Another year is coming to a close, and it&#8217;s time to look back and reflect on what we&#8217;ve accomplished in the past twelve months. The WordPress community is stronger than ever, and some of the accomplishments of the past year are definitely worth remembering.</p>
<h4>Software Releases</h4>
<p>We had two major releases of the WordPress web application with versions <a href="http://wordpress.org/news/2012/06/green/">3.4</a> and <a href="http://wordpress.org/news/2012/12/elvin/">3.5</a>, as well as 5 security releases during 2012. 3.4 included the theme customizer, while 3.5 became the long awaited &#8220;media release&#8221; featuring a new uploader and gallery management tool. 3.5 contained code contributions from more people than ever, and we hope to continue growing the contributor ranks in the year ahead. We currently have native apps on 6 mobile platforms &#8212; <a href="http://ios.wordpress.org/">iOS</a>, <a href="http://android.wordpress.org/">Android</a>, <a href="http://blackberry.wordpress.org/">Blackberry</a>, <a href="http://wpwindowsphone.wordpress.com/">Windows Phone</a>, <a href="http://nokia.wordpress.org/">Nokia</a>, and <a href="http://webos.wordpress.org/">WebOS</a> &#8212; and saw several updates there as well.</p>
<h4>Plugin Directory</h4>
<p>A number of improvements were made to the Plugin Directory in 2012. More cosmetic  updates, like the introduction of branded plugin page headers, make it a nicer browsing experience, while functional changes like better-integrated support forums, plugin reviews, and a favorites system made the plugin directory even more useful as a resource.</p>
<h4>The &#8220;Make&#8221; Network and Team Reps</h4>
<p>2012 was the year that saw the creation of <a href="http://make.wordpress.org/">Make.wordpress.org</a>, a network of sites for the teams of contributors responsible for the different areas of the WordPress project. Now anyone can follow along and get involved with the teams that work on <a href="http://make.wordpress.org/core/">core</a>, <a href="http://make.wordpress.org/themes/">theme review</a>, <a href="http://make.wordpress.org/support/">forum support</a>, <a href="http://make.wordpress.org/docs/">documentation</a>, and more. In 2013 we&#8217;ll work to improve these sites to make it easier to become a contributor. Each team also now has elected Team Reps, a new role that has already led to more cross-team communication. Team reps post each week to the <a href="https://make.wordpress.org/updates/">Updates blog</a> so that the other reps can keep up with what&#8217;s going on in other teams.</p>
<h4>WordPress Community Summit</h4>
<p>At the end of October, about 100 of the most influential and respected members of the WordPress community attended an inaugural <a href="https://make.wordpress.org/summit">summit</a> to discuss where we all stand, and to figure out where we go next with WordPress. A &#8220;conference of conversations,&#8221; this unconference made everyone an active participant, and while not every issue brought to the table was solved by the end of the event, the right questions were being asked.</p>
<h4>Meetup.com</h4>
<p>The WordPress Foundation now has a central account with Meetup.com. We&#8217;ve brought in a couple dozen existing meetup groups as a pilot to test the system, and are in the process of working with more existing meetups (as well as new ones) to join us so that local organizers won&#8217;t have to pay organizer dues and can get more support from the WordPress project.</p>
<h4>Internet Blackout Day</h4>
<p>We participated in the protest against SOPA/PIPA, Internet Blackout Day, on January 18. Though we usually stay out of politics, this campaign was important, and we not only participated in the blackout on WordPress.org, we encouraged our users to do so as well, and recommended plugins to provide blackout functionality. It was deemed the <a href="http://sopastrike.com/numbers/">largest online protest in history</a>.</p>
<h4>WordCamps</h4>
<p>And finally, it wouldn&#8217;t be a recap without counting up the <a href="http://wordcamp.org">WordCamps</a>! There were 67 WordCamps around the world in 2012, bringing together WordPress users, developers, and fans. If you didn&#8217;t make it to a WordCamp this year, maybe it can be one of your new year resolutions: <a href="http://central.wordcamp.org/schedule/">check the schedule</a> to find one near you!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:56:"http://wordpress.org/news/2013/01/2012-a-look-back/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:42:"
		
		
		
		
		
				

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:25:"WordPress 3.5 “Elvin”";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:40:"http://wordpress.org/news/2012/12/elvin/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:49:"http://wordpress.org/news/2012/12/elvin/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 11 Dec 2012 16:54:23 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2517";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:363:"It&#8217;s the most wonderful time of the year: a new WordPress release is available and chock-full of goodies to delight bloggers and developers alike. We&#8217;re calling this one &#8220;Elvin&#8221; in honor of drummer Elvin Jones, who played with John Coltrane in addition to many others. If you&#8217;ve been around WordPress a while, the most dramatic [...]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Matt Mullenweg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:20083:"<p>It&#8217;s the most wonderful time of the year: a new WordPress release <a href="http://wordpress.org/download/">is available</a> and chock-full of goodies to delight bloggers and developers alike. We&#8217;re calling this one &#8220;Elvin&#8221; in honor of <a href="http://en.wikipedia.org/wiki/Elvin_Jones">drummer Elvin Jones</a>, who played with John Coltrane in addition to many others.</p>
<p>If you&#8217;ve been around WordPress a while, the most dramatic new change you&#8217;ll notice is a completely re-imagined flow for uploading photos and creating galleries. Media has long been a friction point and we&#8217;ve listened hard and given a lot of thought into crafting this new system. 3.5 includes a new default theme, Twenty Twelve, which has a very clean mobile-first responsive design and works fantastic as a base for a CMS site. Finally we&#8217;ve spent a lot of time refreshing the styles of the dashboard, updating everything to be Retina-ready with beautiful high resolution graphics, a new color picker, and streamlining a couple of fewer-used sections of the admin.</p>
<p>Here&#8217;s a quick video overview of everything you can share with your friends:</p>
<div id="v-jQDfEbzZ-1" class="video-player"><embed id="v-jQDfEbzZ-1-video" src="http://s0.videopress.com/player.swf?v=1.03&amp;guid=jQDfEbzZ&amp;isDynamicSeeking=true" type="application/x-shockwave-flash" width="692" height="388" title="Introducing WordPress 3.5" wmode="direct" seamlesstabbing="true" allowfullscreen="true" allowscriptaccess="always" overstretch="true"></embed></div>
<h3>For Developers</h3>
<p>You can now put your (or anyone&#8217;s) WordPress.org username on the plugins page and see your favorite tagged ones, to make it easy to install them again when setting up a new site. There&#8217;s a new Tumblr importer. New installs no longer show the links manager. Finally for multisite developers <code>switch_to_blog()</code> is way faster and you can now install MS in a sub-directory. The <a href="http://underscorejs.org/">Underscore</a> and <a href="http://backbonejs.org/">Backbone</a> JavaScript libraries are now available. <a href="http://codex.wordpress.org/Version_3.5">The Codex has a pretty good summary of the developer features above and beyond this</a>, and you can always <a href="http://core.trac.wordpress.org/milestone/3.5">grab a warm beverage and explore Trac directly</a>.</p>
<h3>Percussion Section</h3>
<p>Behind every great release is great contributors. 3.5 had more people involved than any release before it:</p>
<p><a href="http://profiles.wordpress.org/aaroncampbell">Aaron D. Campbell</a>, <a href="http://profiles.wordpress.org/aaronholbrook">aaronholbrook</a>, <a href="http://profiles.wordpress.org/jorbin">Aaron Jorbin</a>, <a href="http://profiles.wordpress.org/kawauso">Adam Harley</a>, <a href="http://profiles.wordpress.org/alyssonweb">akbortoli</a>, <a href="http://profiles.wordpress.org/alecrust">alecrust</a>, <a href="http://profiles.wordpress.org/xknown">Alex Concha</a>, <a href="http://profiles.wordpress.org/alexkingorg">Alex King</a>, <a href="http://profiles.wordpress.org/viper007bond">Alex Mills (Viper007Bond)</a>, <a href="http://profiles.wordpress.org/alexvorn2">alexvorn2</a>, <a href="http://profiles.wordpress.org/ampt">ampt</a>, <a href="http://profiles.wordpress.org/sabreuse">Amy Hendrix (sabreuse)</a>, <a href="http://profiles.wordpress.org/andrear">andrea.r</a>, <a href="http://profiles.wordpress.org/nacin">Andrew Nacin</a>, <a href="http://profiles.wordpress.org/azaozz">Andrew Ozz</a>, <a href="http://profiles.wordpress.org/andrewryno">Andrew Ryno</a>, <a href="http://profiles.wordpress.org/andrewspittle">Andrew Spittle</a>, <a href="http://profiles.wordpress.org/andy">Andy Skelton</a>, <a href="http://profiles.wordpress.org/apokalyptik">apokalyptik</a>, <a href="http://profiles.wordpress.org/bainternet">Bainternet</a>, <a href="http://profiles.wordpress.org/barrykooij">Barry Kooij</a>, <a href="http://profiles.wordpress.org/bazza">bazza</a>, <a href="http://profiles.wordpress.org/bbrooks">bbrooks</a>, <a href="http://profiles.wordpress.org/casben79">Ben Casey</a>, <a href="http://profiles.wordpress.org/husobj">Ben Huson</a>, <a href="http://profiles.wordpress.org/benkulbertis">Ben Kulbertis</a>, <a href="http://profiles.wordpress.org/bergius">bergius</a>, <a href="http://profiles.wordpress.org/neoxx">Bernhard Riedl</a>, <a href="http://profiles.wordpress.org/betzster">betzster</a>, <a href="http://profiles.wordpress.org/bananastalktome">Billy (bananastalktome)</a>, <a href="http://profiles.wordpress.org/bolo1988">bolo1988</a>, <a href="http://profiles.wordpress.org/bradparbs">bradparbs</a>, <a href="http://profiles.wordpress.org/bradthomas127">bradthomas127</a>, <a href="http://profiles.wordpress.org/bradyvercher">Brady Vercher</a>, <a href="http://profiles.wordpress.org/brandondove">Brandon Dove</a>, <a href="http://profiles.wordpress.org/brianlayman">Brian Layman</a>, <a href="http://profiles.wordpress.org/rzen">Brian Richards</a>, <a href="http://profiles.wordpress.org/sennza">Bronson Quick</a>, <a href="http://profiles.wordpress.org/bpetty">Bryan Petty</a>, <a href="http://profiles.wordpress.org/cannona">cannona</a>, <a href="http://profiles.wordpress.org/sixhours">Caroline Moore</a>, <a href="http://profiles.wordpress.org/caspie">Caspie</a>, <a href="http://profiles.wordpress.org/cdog">cdog</a>, <a href="http://profiles.wordpress.org/thee17">Charles Frees-Melvin</a>, <a href="http://profiles.wordpress.org/chellycat">chellycat</a>, <a href="http://profiles.wordpress.org/chexee">Chelsea Otakan</a>, <a href="http://profiles.wordpress.org/chouby">Chouby</a>, <a href="http://profiles.wordpress.org/c3mdigital">Chris Olbekson</a>, <a href="http://profiles.wordpress.org/cfinke">Christopher Finke</a>, <a href="http://profiles.wordpress.org/chriswallace">Chris Wallace</a>, <a href="http://profiles.wordpress.org/corvannoorloos">Cor van Noorloos</a>, <a href="http://profiles.wordpress.org/scribu">Cristi Burc&#259;</a>, <a href="http://profiles.wordpress.org/mrroundhill">Dan</a>, <a href="http://profiles.wordpress.org/dan-rivera">Dan Rivera</a>, <a href="http://profiles.wordpress.org/koopersmith">Daryl Koopersmith</a>, <a href="http://profiles.wordpress.org/lessbloat">Dave Martin</a>, <a href="http://profiles.wordpress.org/deltafactory">deltafactory</a>, <a href="http://profiles.wordpress.org/dd32">Dion Hulse</a>, <a href="http://profiles.wordpress.org/djzone">DjZoNe</a>, <a href="http://profiles.wordpress.org/dllh">dllh</a>, <a href="http://profiles.wordpress.org/ocean90">Dominik Schilling</a>, <a href="http://profiles.wordpress.org/doublesharp">doublesharp</a>, <a href="http://profiles.wordpress.org/drewapicture">Drew Jaynes (DrewAPicture)</a>, <a href="http://profiles.wordpress.org/drewstrojny">Drew Strojny</a>, <a href="http://profiles.wordpress.org/eddiemoya">Eddie Moya</a>, <a href="http://profiles.wordpress.org/elyobo">elyobo</a>, <a href="http://profiles.wordpress.org/emiluzelac">Emil Uzelac</a>, <a href="http://profiles.wordpress.org/empireoflight">Empireoflight</a>, <a href="http://profiles.wordpress.org/ericlewis">Eric Andrew Lewis</a>, <a href="http://profiles.wordpress.org/ethitter">Erick Hitter</a>, <a href="http://profiles.wordpress.org/ericmann">Eric Mann</a>, <a href="http://profiles.wordpress.org/ericwahlforss">ericwahlforss</a>, <a href="http://profiles.wordpress.org/evansolomon">Evan Solomon</a>, <a href="http://profiles.wordpress.org/fadingdust">fadingdust</a>, <a href="http://profiles.wordpress.org/f-j-kaiser">F J Kaiser</a>, <a href="http://profiles.wordpress.org/foxinni">foxinni</a>, <a href="http://profiles.wordpress.org/garyc40">Gary Cao</a>, <a href="http://profiles.wordpress.org/garyj">Gary Jones</a>, <a href="http://profiles.wordpress.org/pento">Gary Pendergast</a>, <a href="http://profiles.wordpress.org/geertdd">GeertDD</a>, <a href="http://profiles.wordpress.org/mamaduka">George Mamadashvili</a>, <a href="http://profiles.wordpress.org/georgestephanis">George Stephanis</a>, <a href="http://profiles.wordpress.org/ghosttoast">GhostToast</a>, <a href="http://profiles.wordpress.org/gnarf">gnarf</a>, <a href="http://profiles.wordpress.org/goldenapples">goldenapples</a>, <a href="http://profiles.wordpress.org/webord">Gustavo Bordoni</a>, <a href="http://profiles.wordpress.org/hakre">hakre</a>, <a href="http://profiles.wordpress.org/hanni">hanni</a>, <a href="http://profiles.wordpress.org/hardy101">hardy101</a>, <a href="http://profiles.wordpress.org/hebbet">hebbet</a>, <a href="http://profiles.wordpress.org/helenyhou">Helen Hou-Sandi</a>, <a href="http://profiles.wordpress.org/hugobaeta">Hugo Baeta</a>, <a href="http://profiles.wordpress.org/iamfriendly">iamfriendly</a>, <a href="http://profiles.wordpress.org/iandstewart">Ian Stewart</a>, <a href="http://profiles.wordpress.org/ikailo">ikailo</a>, <a href="http://profiles.wordpress.org/ipstenu">Ipstenu (Mika Epstein)</a>, <a href="http://profiles.wordpress.org/itworx">itworx</a>, <a href="http://profiles.wordpress.org/j-idris">j-idris</a>, <a href="http://profiles.wordpress.org/jakemgold">Jake Goldman</a>, <a href="http://profiles.wordpress.org/jakubtyrcha">jakub.tyrcha</a>, <a href="http://profiles.wordpress.org/jamescollins">James Collins</a>, <a href="http://profiles.wordpress.org/jammitch">jammitch</a>, <a href="http://profiles.wordpress.org/jane">Jane Wells</a>, <a href="http://profiles.wordpress.org/japh">Japh</a>, <a href="http://profiles.wordpress.org/jarretc">JarretC</a>, <a href="http://profiles.wordpress.org/madtownlems">Jason Lemahieu (MadtownLems)</a>, <a href="http://profiles.wordpress.org/javert03">javert03</a>, <a href="http://profiles.wordpress.org/jbrinley">jbrinley</a>, <a href="http://profiles.wordpress.org/jcakec">jcakec</a>, <a href="http://profiles.wordpress.org/jblz">Jeff Bowen</a>, <a href="http://profiles.wordpress.org/jeffsebring">Jeff Sebring</a>, <a href="http://profiles.wordpress.org/jeremyfelt">Jeremy Felt</a>, <a href="http://profiles.wordpress.org/hd-j">Jeremy Herve</a>, <a href="http://profiles.wordpress.org/jerrysarcastic">Jerry Bates (JerrySarcastic)</a>, <a href="http://profiles.wordpress.org/jayjdk">Jesper Johansen (Jayjdk)</a>, <a href="http://profiles.wordpress.org/jndetlefsen">jndetlefsen</a>, <a href="http://profiles.wordpress.org/joehoyle">Joe Hoyle</a>, <a href="http://profiles.wordpress.org/joelhardi">joelhardi</a>, <a href="http://profiles.wordpress.org/jkudish">Joey Kudish</a>, <a href="http://profiles.wordpress.org/johnbillion">John Blackbourn (johnbillion)</a>, <a href="http://profiles.wordpress.org/johnjamesjacoby">John James Jacoby</a>, <a href="http://profiles.wordpress.org/johnpbloch">John P. Bloch</a>, <a href="http://profiles.wordpress.org/jond3r">Jonas Bolinder</a>, <a href="http://profiles.wordpress.org/jondavidjohn">Jonathan D. Johnson</a>, <a href="http://profiles.wordpress.org/duck_">Jon Cave</a>, <a href="http://profiles.wordpress.org/joostdekeijzer">joostdekeijzer</a>, <a href="http://profiles.wordpress.org/koke">Jorge Bernal</a>, <a href="http://profiles.wordpress.org/josephscott">Joseph Scott</a>, <a href="http://profiles.wordpress.org/pottersys">Juan</a>, <a href="http://profiles.wordpress.org/justinsainton">Justin Sainton</a>, <a href="http://profiles.wordpress.org/jtsternberg">Justin Sternberg</a>, <a href="http://profiles.wordpress.org/greenshady">Justin Tadlock</a>, <a href="http://profiles.wordpress.org/trepmal">Kailey Lampert (trepmal)</a>, <a href="http://profiles.wordpress.org/ryelle">Kelly Dwan</a>, <a href="http://profiles.wordpress.org/keruspe">Keruspe</a>, <a href="http://profiles.wordpress.org/kitchin">kitchin</a>, <a href="http://profiles.wordpress.org/knutsp">Knut Sparhell</a>, <a href="http://profiles.wordpress.org/kovshenin">Konstantin Kovshenin</a>, <a href="http://profiles.wordpress.org/obenland">Konstantin Obenland</a>, <a href="http://profiles.wordpress.org/kopepasah">Kopepasah</a>, <a href="http://profiles.wordpress.org/klagraff">Kristopher Lagraff</a>, <a href="http://profiles.wordpress.org/kurtpayne">Kurt Payne</a>, <a href="http://profiles.wordpress.org/kyrylo">Kyrylo</a>, <a href="http://profiles.wordpress.org/lancewillett">Lance Willett</a>, <a href="http://profiles.wordpress.org/larysa">Larysa Mykhas</a>, <a href="http://profiles.wordpress.org/leogermani">leogermani</a>, <a href="http://profiles.wordpress.org/lesteph">lesteph</a>, <a href="http://profiles.wordpress.org/linuxologos">linuxologos</a>, <a href="http://profiles.wordpress.org/ldebrouwer">Luc De Brouwer</a>, <a href="http://profiles.wordpress.org/lgedeon">Luke Gedeon</a>, <a href="http://profiles.wordpress.org/latz">Lutz Schroer</a>, <a href="http://profiles.wordpress.org/mailnew2ster">mailnew2ster</a>, <a href="http://profiles.wordpress.org/targz-1">Manuel Schmalstieg</a>, <a href="http://profiles.wordpress.org/maor">Maor Chasen</a>, <a href="http://profiles.wordpress.org/mimecine">Marco</a>, <a href="http://profiles.wordpress.org/marcuspope">MarcusPope</a>, <a href="http://profiles.wordpress.org/markjaquith">Mark Jaquith</a>, <a href="http://profiles.wordpress.org/markoheijnen">Marko Heijnen</a>, <a href="http://profiles.wordpress.org/martythornley">MartyThornley</a>, <a href="http://profiles.wordpress.org/mattdanner">mattdanner</a>, <a href="http://profiles.wordpress.org/bigdawggi">Matthew Richmond</a>, <a href="http://profiles.wordpress.org/sivel">Matt Martz</a>, <a href="http://profiles.wordpress.org/iammattthomas">Matt Thomas</a>, <a href="http://profiles.wordpress.org/mattwiebe">Matt Wiebe</a>, <a href="http://profiles.wordpress.org/mattyrob">mattyrob</a>, <a href="http://profiles.wordpress.org/maxcutler">Max Cutler</a>, <a href="http://profiles.wordpress.org/melchoyce">Mel Choyce</a>, <a href="http://profiles.wordpress.org/merty">Mert Yazicioglu</a>, <a href="http://profiles.wordpress.org/mdawaffe">Michael Adams (mdawaffe)</a>, <a href="http://profiles.wordpress.org/mfields">Michael Fields</a>, <a href="http://profiles.wordpress.org/mbijon">Mike Bijon</a>, <a href="http://profiles.wordpress.org/mdgl">Mike Glendinning</a>, <a href="http://profiles.wordpress.org/mikehansenme">Mike Hansen</a>, <a href="http://profiles.wordpress.org/mikelittle">Mike Little</a>, <a href="http://profiles.wordpress.org/mikeschinkel">Mike Schinkel</a>, <a href="http://profiles.wordpress.org/DH-Shredder">Mike Schroder</a>, <a href="http://profiles.wordpress.org/toppa">Mike Toppa</a>, <a href="http://profiles.wordpress.org/dimadin">Milan Dinic</a>, <a href="http://profiles.wordpress.org/mitchoyoshitaka">mitcho (Michael Yoshitaka Erlewine)</a>, <a href="http://profiles.wordpress.org/batmoo">Mohammad Jangda</a>, <a href="http://profiles.wordpress.org/mohanjith">mohanjith</a>, <a href="http://profiles.wordpress.org/mpvanwinkle77">mpvanwinkle77</a>, <a href="http://profiles.wordpress.org/usermrpapa">Mr Papa</a>, <a href="http://profiles.wordpress.org/murky">murky</a>, <a href="http://profiles.wordpress.org/Nao">Naoko Takano</a>, <a href="http://profiles.wordpress.org/alex-ye">Nashwan Doaqan</a>, <a href="http://profiles.wordpress.org/niallkennedy">Niall Kennedy</a>, <a href="http://profiles.wordpress.org/nbachiyski">Nikolay Bachiyski</a>, <a href="http://profiles.wordpress.org/ntm">ntm</a>, <a href="http://profiles.wordpress.org/nvartolomei">nvartolomei</a>, <a href="http://profiles.wordpress.org/pavelevap">pavelevap</a>, <a href="http://profiles.wordpress.org/pdclark">pdclark</a>, <a href="http://profiles.wordpress.org/petemall">Pete Mall</a>, <a href="http://profiles.wordpress.org/westi">Peter Westwood</a>, <a href="http://profiles.wordpress.org/pas5027">Pete Schuster</a>, <a href="http://profiles.wordpress.org/philiparthurmoore">Philip Arthur Moore</a>, <a href="http://profiles.wordpress.org/phill_brown">Phill Brown</a>, <a href="http://profiles.wordpress.org/picklepete">picklepete</a>, <a href="http://profiles.wordpress.org/picklewagon">Picklewagon</a>, <a href="http://profiles.wordpress.org/nprasath002">Prasath Nadarajah</a>, <a href="http://profiles.wordpress.org/r-a-y">r-a-y</a>, <a href="http://profiles.wordpress.org/ramiy">Rami Yushuvaev</a>, <a href="http://profiles.wordpress.org/moraleidame">Ricardo Moraleida</a>, <a href="http://profiles.wordpress.org/miqrogroove">Robert Chapin (miqrogroove)</a>, <a href="http://profiles.wordpress.org/wet">Robert Wetzlmayr</a>, <a href="http://profiles.wordpress.org/wpmuguru">Ron Rennick</a>, <a href="http://profiles.wordpress.org/rstern">rstern</a>, <a href="http://profiles.wordpress.org/ryan">Ryan Boren</a>, <a href="http://profiles.wordpress.org/ryanimel">Ryan Imel</a>, <a href="http://profiles.wordpress.org/ryanjkoehler">Ryan Koehler</a>, <a href="http://profiles.wordpress.org/markel">Ryan Markel</a>, <a href="http://profiles.wordpress.org/rmccue">Ryan McCue</a>, <a href="http://profiles.wordpress.org/zeo">Safirul Alredha</a>, <a href="http://profiles.wordpress.org/solarissmoke">Samir Shah</a>, <a href="http://profiles.wordpress.org/gluten">Sam Margulies</a>, <a href="http://profiles.wordpress.org/otto42">Samuel Wood (Otto)</a>, <a href="http://profiles.wordpress.org/saracannon">sara cannon</a>, <a href="http://profiles.wordpress.org/gandham">Satish Gandham</a>, <a href="http://profiles.wordpress.org/scottgonzalez">scott.gonzalez</a>, <a href="http://profiles.wordpress.org/sc0ttkclark">Scott Kingsley Clark</a>, <a href="http://profiles.wordpress.org/coffee2code">Scott Reilly</a>, <a href="http://profiles.wordpress.org/wonderboymusic">Scott Taylor</a>, <a href="http://profiles.wordpress.org/greglone">ScreenfeedFr</a>, <a href="http://profiles.wordpress.org/sergeysbetkenovgaroru">sergey.s.betke</a>, <a href="http://profiles.wordpress.org/sergeybiryukov">Sergey Biryukov</a>, <a href="http://profiles.wordpress.org/pross">Simon Prosser</a>, <a href="http://profiles.wordpress.org/simonwheatley">Simon Wheatley</a>, <a href="http://profiles.wordpress.org/sirzooro">sirzooro</a>, <a href="http://profiles.wordpress.org/ssamture">ssamture</a>, <a href="http://profiles.wordpress.org/sterlo">sterlo</a>, <a href="http://profiles.wordpress.org/sumindmitriy">sumindmitriy</a>, <a href="http://profiles.wordpress.org/sushkov">sushkov</a>, <a href="http://profiles.wordpress.org/swekitsune">swekitsune</a>, <a href="http://profiles.wordpress.org/iamtakashi">Takashi Irie</a>, <a href="http://profiles.wordpress.org/taylorde">Taylor Dewey</a>, <a href="http://profiles.wordpress.org/tlovett1">Taylor Lovett</a>, <a href="http://profiles.wordpress.org/saltcod">Terry Sutton</a>, <a href="http://profiles.wordpress.org/griffinjt">Thomas Griffin</a>, <a href="http://profiles.wordpress.org/tott">Thorsten Ott</a>, <a href="http://profiles.wordpress.org/timbeks">timbeks</a>, <a href="http://profiles.wordpress.org/timfs">timfs</a>, <a href="http://profiles.wordpress.org/tmoorewp">Tim Moore</a>, <a href="http://profiles.wordpress.org/tobiasbg">TobiasBg</a>, <a href="http://profiles.wordpress.org/tomasm">TomasM</a>, <a href="http://profiles.wordpress.org/tomauger">Tom Auger</a>, <a href="http://profiles.wordpress.org/tommcfarlin">tommcfarlin</a>, <a href="http://profiles.wordpress.org/willmot">Tom Willmot</a>, <a href="http://profiles.wordpress.org/toscho">toscho</a>, <a href="http://profiles.wordpress.org/wpsmith">Travis Smith</a>, <a href="http://profiles.wordpress.org/vhauri">Vasken Hauri</a>, <a href="http://profiles.wordpress.org/viniciusmassuchetto">Vinicius Massuchetto</a>, <a href="http://profiles.wordpress.org/lightningspirit">Vitor Carvalho</a>, <a href="http://profiles.wordpress.org/waclawjacek">Waclaw</a>, <a href="http://profiles.wordpress.org/waldojaquith">WaldoJaquith</a>, <a href="http://profiles.wordpress.org/wojtekszkutnik">Wojtek Szkutnik</a>, <a href="http://profiles.wordpress.org/xibe">Xavier Borderie</a>, <a href="http://profiles.wordpress.org/yoavf">Yoav Farhi</a>, <a href="http://profiles.wordpress.org/yogi-t">Yogi T</a>, <a href="http://profiles.wordpress.org/tollmanz">Zack Tollman</a>, and <a href="http://profiles.wordpress.org/zamoose">ZaMoose</a>.</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:45:"http://wordpress.org/news/2012/12/elvin/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:45:"
		
		
		
		
		
				
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:33:"WordPress 3.5 Release Candidate 3";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:68:"http://wordpress.org/news/2012/12/wordpress-3-5-release-candidate-3/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:77:"http://wordpress.org/news/2012/12/wordpress-3-5-release-candidate-3/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 04 Dec 2012 08:37:39 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:2:{i:0;a:5:{s:4:"data";s:11:"Development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:7:"Testing";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:68:"http://wordpress.org/news/2012/12/wordpress-3-5-release-candidate-3/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:339:"The third release candidate for WordPress 3.5 is now available. We&#8217;ve made a number of changes over the last week since RC2 that we can&#8217;t wait to get into your hands. Hope you&#8217;re ready to do some testing! Final UI improvements for the new media manager, based on lots of great feedback. Show more information about [...]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:1950:"<p>The third release candidate for WordPress 3.5 is now available. We&#8217;ve made a number of changes over the last week since <a title="WordPress 3.5 Release Candidate 2" href="http://wordpress.org/news/2012/11/wordpress-3-5-release-candidate-2/">RC2</a> that we can&#8217;t wait to get into your hands. Hope you&#8217;re ready to do some testing!</p>
<ul>
<li><span style="line-height: 13px">Final UI improvements for the new media manager, based on lots of great feedback.</span></li>
<li>Show more information about uploading errors when they occur.</li>
<li>When inserting an image into a post, don&#8217;t forget the alternative text.</li>
<li>Fixes for the new admin button styles.</li>
<li>Improvements for mobile devices, Internet Explorer, and right-to-left languages.</li>
<li>Fix cookies for subdomain installs when multisite is installed in a subdirectory.</li>
<li>Fix ms-files.php rewriting for very old multisite installs.</li>
</ul>
<p>At this point, we only have a <a href="http://core.trac.wordpress.org/report/5">few minor issues</a> left. If all goes well, you will see WordPress 3.5 very soon. If you run into any issues, please post to the <a href="http://wordpress.org/support/forum/alphabeta/">Alpha/Beta area in the support forums</a>.</p>
<p>If you&#8217;d like to know what to test, visit the About page (<strong><img style="vertical-align: middle" alt="" src="http://wordpress.org/wp-content/themes/twentyten/images/wordpress.png" /> → About</strong> in the toolbar) and check out the list of features. This is still development software, so your boss may get mad if you install this on a live site. To test WordPress 3.5, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you&#8217;ll want &#8220;bleeding edge nightlies&#8221;). Or you can <a href="http://wordpress.org/wordpress-3.5-RC3.zip">download the release candidate here (zip)</a>.</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:73:"http://wordpress.org/news/2012/12/wordpress-3-5-release-candidate-3/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:45:"
		
		
		
		
		
				
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:33:"WordPress 3.5 Release Candidate 2";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:68:"http://wordpress.org/news/2012/11/wordpress-3-5-release-candidate-2/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:77:"http://wordpress.org/news/2012/11/wordpress-3-5-release-candidate-2/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 29 Nov 2012 19:55:12 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:2:{i:0;a:5:{s:4:"data";s:11:"Development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:7:"Testing";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2494";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:339:"The second release candidate for WordPress 3.5 is now available for download and testing. We&#8217;re still working on about a dozen remaining issues, but we hope to deliver WordPress 3.5 to your hands as early as next week. If you&#8217;d like to know what to test, visit the About page ( → About in the toolbar) and check out [...]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:1509:"<p>The second release candidate for WordPress 3.5 is now available for download and testing.</p>
<p>We&#8217;re still working on about a dozen remaining issues, but we hope to deliver WordPress 3.5 to your hands as early as next week. If you&#8217;d like to know what to test, visit the About page (<strong><img alt="" src="http://wordpress.org/wp-content/themes/twentyten/images/wordpress.png" /> → About</strong> in the toolbar) and check out the list of features! As usual, this is still development software and we suggest you do not install this on a live site unless you are adventurous.</p>
<p><strong>Think you&#8217;ve found a bug?</strong> Please post to the <a href="http://wordpress.org/support/forum/alphabeta/">Alpha/Beta area in the support forums</a>.</p>
<p><strong>Developers,</strong> please continue to test your plugins and themes, so that if there is a compatibility issue, we can figure it out before the final release. You can find our <a href="http://core.trac.wordpress.org/report/6">list of known issues here</a>.</p>
<p>To test WordPress 3.5, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you&#8217;ll want &#8220;bleeding edge nightlies&#8221;). Or you can <a href="http://wordpress.org/wordpress-3.5-RC2.zip">download the release candidate here (zip)</a>.</p>
<p><em>&#8211;<br />
</em><em>We are getting close<br />
</em><em>Should have asked for haiku help<br />
</em><em>Please test RC2</em></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:73:"http://wordpress.org/news/2012/11/wordpress-3-5-release-candidate-2/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:45:"
		
		
		
		
		
				
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"WordPress 3.5 Release Candidate";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:66:"http://wordpress.org/news/2012/11/wordpress-3-5-release-candidate/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:75:"http://wordpress.org/news/2012/11/wordpress-3-5-release-candidate/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 22 Nov 2012 13:35:09 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:2:{i:0;a:5:{s:4:"data";s:11:"Development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:7:"Testing";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2479";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:341:"The first release candidate for WordPress 3.5 is now available. We hope to ship WordPress 3.5 in two weeks. But to do that, we need your help! If you haven&#8217;t tested 3.5 yet, there&#8217;s no time like the present. (The oft-repeated warning: Please, not on a live site, unless you&#8217;re adventurous.) Think you&#8217;ve found a [...]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:1545:"<p>The first release candidate for WordPress 3.5 is now available.</p>
<p>We hope to ship WordPress 3.5 in <em>two weeks</em>. But to do that, we need your help! If you haven&#8217;t tested 3.5 yet, there&#8217;s no time like the present. (The oft-repeated warning: Please, not on a live site, unless you&#8217;re adventurous.)</p>
<p><strong>Think you&#8217;ve found a bug?</strong> Please post to the <a href="http://wordpress.org/support/forum/alphabeta/">Alpha/Beta area in the support forums</a>. If any known issues come up, you’ll be able to <a href="http://core.trac.wordpress.org/report/6">find them here</a>. <strong>Developers,</strong> please test your plugins and themes, so that if there is a compatibility issue, we can figure it out before the final release.</p>
<p>To test WordPress 3.5, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you&#8217;ll want &#8220;bleeding edge nightlies&#8221;). Or you can <a href="http://wordpress.org/wordpress-3.5-RC1.zip">download the release candidate here (zip)</a>.</p>
<p>If you&#8217;d like to know what to <del>break</del> test, visit the About page (<strong><img style="vertical-align: text-top" alt="" src="http://wordpress.org/wp-content/themes/twentyten/images/wordpress.png" /> → About</strong> in the toolbar) and check out the list of features! Trust me, you want to try out media.</p>
<p><em>Release candidate</em><br />
<em>Three point five in two weeks time</em><br />
<em>Please test all the things</em></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:71:"http://wordpress.org/news/2012/11/wordpress-3-5-release-candidate/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:48:"
		
		
		
		
		
				
		
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:20:"WordPress 3.5 Beta 3";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2012/11/wordpress-3-5-beta-3/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:64:"http://wordpress.org/news/2012/11/wordpress-3-5-beta-3/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 13 Nov 2012 04:26:23 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:3:{i:0;a:5:{s:4:"data";s:11:"Development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:7:"Testing";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2467";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:341:"The third beta release of WordPress 3.5 is now available for download and testing. Hey, developers! We expect to WordPress 3.5 to be ready in just a few short weeks. Please, please test your plugins and themes against beta 3. Media management has been rewritten, and we&#8217;ve taken great pains to ensure most plugins will work the [...]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:2677:"<p>The third beta release of WordPress 3.5 is now available for download and testing.</p>
<p><strong>Hey, developers!</strong> We expect to WordPress 3.5 to be ready in just a few short weeks. <em>Please, please</em> test your plugins and themes against beta 3. Media management has been rewritten, and we&#8217;ve taken great pains to ensure most plugins will work the same as before, but we&#8217;re not perfect. We would like to hear about any incompatibilities we&#8217;ve caused so we can work with you to address them <em>before</em> release, rather than after. I think you&#8217;ll agree it&#8217;s much better that way. <img src=\'http://wordpress.org/news/wp-includes/images/smilies/icon_smile.gif\' alt=\':-)\' class=\'wp-smiley\' /> </p>
<p>To test WordPress 3.5, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you’ll want “bleeding edge nightlies”). Or you can <a href="http://wordpress.org/wordpress-3.5-beta3.zip">download the beta here</a> (zip). For more on 3.5, <a title="WordPress 3.5 Beta 1" href="http://wordpress.org/news/2012/09/wordpress-3-5-beta-1/">check out the extensive Beta 1 blog post</a>, which covers what’s new in version 3.5 and how you can help. We made <a href="http://core.trac.wordpress.org/log/trunk?action=stop_on_copy&amp;mode=stop_on_copy&amp;rev=22557&amp;stop_rev=22224&amp;limit=400">more than 300 changes</a> since <a href="http://wordpress.org/news/2012/10/wordpress-3-5-beta-2/">beta 2</a>. <span style="line-height: 13px">At this point, the Add Media dialog is complete, and we&#8217;re now just working on fixing up inserting images into the editor. We&#8217;ve also u</span>pdated to jQuery UI 1.9.1, SimplePie 1.3.1, and TinyMCE 3.5.7.</p>
<p>The usual warnings apply: We can see the light at the end of the tunnel, but this is software still in development, so we don’t recommend that you run it on a production site. Set up a test site to play with the new version.</p>
<p>As always, if you think you’ve found a bug, you can post to the <a href="http://wordpress.org/support/forum/alphabeta">Alpha/Beta area</a> in the support forums. Or, if you’re comfortable writing a reproducible bug report, <a href="http://core.trac.wordpress.org/">file one on the WordPress Trac</a>. There, you can also find <a href="http://core.trac.wordpress.org/report/5">a list of known bugs</a> and <a href="http://core.trac.wordpress.org/query?status=closed&amp;group=component&amp;milestone=3.5">everything we’ve fixed</a> so far.</p>
<p><em>Beta three is out</em><br />
<em>Soon, a release candidate</em><br />
<em>Three point five is near</em></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:60:"http://wordpress.org/news/2012/11/wordpress-3-5-beta-3/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:45:"
		
		
		
		
		
				
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:20:"WordPress 3.5 Beta 2";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2012/10/wordpress-3-5-beta-2/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:64:"http://wordpress.org/news/2012/10/wordpress-3-5-beta-2/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 13 Oct 2012 00:02:08 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:2:{i:0;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:7:"Testing";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2458";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:342:"Two weeks after the first beta, WordPress 3.5 Beta 2 is now available for download and testing. This is software still in development, so we don’t recommend that you run it on a production site. Set up a test site to play with the new version. To test WordPress 3.5, try the WordPress Beta Tester plugin (you’ll want “bleeding [...]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:1856:"<p>Two weeks after the first beta, WordPress 3.5 Beta 2 is now available for download and testing.</p>
<p>This is software still in development, so we don’t recommend that you run it on a production site. Set up a test site to play with the new version. To test WordPress 3.5, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you’ll want “bleeding edge nightlies”). Or you can <a href="http://wordpress.org/wordpress-3.5-beta2.zip">download the beta here</a> (zip).</p>
<p>For more, <a title="WordPress 3.5 Beta 1" href="http://wordpress.org/news/2012/09/wordpress-3-5-beta-1/"><strong>check out the extensive Beta 1 blog post</strong></a>, which covers what&#8217;s new in version 3.5 and how you can help. What&#8217;s new since beta 1? I&#8217;m glad you asked:</p>
<ul>
<li>New workflow for working with image galleries, including drag-and-drop reordering and quick caption editing.</li>
<li>New image editing API. (<a title="Ticket 6821" href="http://core.trac.wordpress.org/ticket/6821">#6821</a>)</li>
<li><del>New user interface for setting static front pages for the Reading Settings screen. (<a title="Ticket 16379" href="http://core.trac.wordpress.org/ticket/16379">#16379</a>)</del></li>
</ul>
<p>As always, if you think you’ve found a bug, you can post to the <a href="http://wordpress.org/support/forum/alphabeta">Alpha/Beta area</a> in the support forums. Or, if you’re comfortable writing a reproducible bug report, <a href="http://core.trac.wordpress.org/">file one on the WordPress Trac</a>. There, you can also find <a href="http://core.trac.wordpress.org/report/5">a list of known bugs</a> and <a href="http://core.trac.wordpress.org/query?status=closed&amp;group=component&amp;milestone=3.5">everything we’ve fixed</a> so far. Happy testing!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:60:"http://wordpress.org/news/2012/10/wordpress-3-5-beta-2/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}s:27:"http://www.w3.org/2005/Atom";a:1:{s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:3:{s:4:"href";s:31:"http://wordpress.org/news/feed/";s:3:"rel";s:4:"self";s:4:"type";s:19:"application/rss+xml";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:44:"http://purl.org/rss/1.0/modules/syndication/";a:2:{s:12:"updatePeriod";a:1:{i:0;a:5:{s:4:"data";s:6:"hourly";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:15:"updateFrequency";a:1:{i:0;a:5:{s:4:"data";s:1:"1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";a:8:{s:6:"server";s:5:"nginx";s:4:"date";s:29:"Thu, 18 Apr 2013 19:19:43 GMT";s:12:"content-type";s:23:"text/xml; charset=UTF-8";s:10:"connection";s:5:"close";s:4:"vary";s:15:"Accept-Encoding";s:10:"x-pingback";s:36:"http://wordpress.org/news/xmlrpc.php";s:13:"last-modified";s:29:"Thu, 11 Apr 2013 13:48:42 GMT";s:4:"x-nc";s:11:"HIT luv 138";}s:5:"build";s:14:"20121202214312";}', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (226, '_transient_timeout_feed_mod_ac0b00fe65abe10e0c5b588f3ed8c7ca', '1366355983', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (227, '_transient_feed_mod_ac0b00fe65abe10e0c5b588f3ed8c7ca', '1366312783', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (228, '_transient_timeout_dash_4077549d03da2e451c8b5f002294ff51', '1366355983', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (229, '_transient_dash_4077549d03da2e451c8b5f002294ff51', '<div class="rss-widget"><ul><li><a class=\'rsswidget\' href=\'http://wordpress.org/news/2013/04/save-the-date-may-27/\' title=\'What’s on May 27, you ask? May 27, 2013 is the 10th anniversary of the first WordPress release! We think this is worth celebrating, and we want WordPress fans all over the world to celebrate with us by throwing their own parties. We’re using Meetup Everywhere to coordinate, and will be putting up a website [&hellip;]\'>Save the Date: May 27</a> <span class="rss-date">April 11, 2013</span><div class=\'rssSummary\'>What’s on May 27, you ask? May 27, 2013 is the 10th anniversary of the first WordPress release! We think this is worth celebrating, and we want WordPress fans all over the world to celebrate with us by throwing their own parties. We’re using Meetup Everywhere to coordinate, and will be putting up a website [&hellip;]</div></li><li><a class=\'rsswidget\' href=\'http://wordpress.org/news/2013/04/wordpress-3-6-beta-1/\' title=\'WordPress 3.6 Beta 1 is now available! This is software still in development and we really don’t recommend that you run it on a production site — set up a test site just to play with the new version. To test WordPress 3.6, try the WordPress Beta Tester plugin (you’ll want “bleeding edge nightlies”). Or you can download the beta here (zip). We’ve [&hellip;]\'>WordPress 3.6 Beta 1</a> <span class="rss-date">April 4, 2013</span><div class=\'rssSummary\'>WordPress 3.6 Beta 1 is now available! This is software still in development and we really don’t recommend that you run it on a production site — set up a test site just to play with the new version. To test WordPress 3.6, try the WordPress Beta Tester plugin (you’ll want “bleeding edge nightlies”). Or you can download the beta here (zip). We’ve [&hellip;]</div></li></ul></div>', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (230, '_transient_timeout_feed_fec30b017abe520072e5f51214c0d845', '1366355983', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (231, '_transient_feed_fec30b017abe520072e5f51214c0d845', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:4:"
  
";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:33:"
    
    
    
    
    
    
  ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:3:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:61:"link:http://localhost/allisongrayce.com/ - Google Blog Search";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:98:"http://www.google.com/search?ie=utf-8&q=link:http://localhost/allisongrayce.com/&tbm=blg&tbs=sbd:1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:92:"Your search - <b>link:http://localhost/allisongrayce.com/</b> - did not match any documents.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://a9.com/-/spec/opensearch/1.1/";a:3:{s:12:"totalResults";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"startIndex";a:1:{i:0;a:5:{s:4:"data";s:1:"1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:12:"itemsPerPage";a:1:{i:0;a:5:{s:4:"data";s:2:"10";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";a:9:{s:12:"content-type";s:28:"text/xml; charset=ISO-8859-1";s:4:"date";s:29:"Thu, 18 Apr 2013 19:19:43 GMT";s:7:"expires";s:2:"-1";s:13:"cache-control";s:18:"private, max-age=0";s:10:"set-cookie";a:2:{i:0;s:143:"PREF=ID=36fc753d7c71ddba:FF=0:TM=1366312783:LM=1366312783:S=6UPhf52DasHZwrgq; expires=Sat, 18-Apr-2015 19:19:43 GMT; path=/; domain=.google.com";i:1;s:212:"NID=67=Xt4_BGt96Ss7sgmbywvWyD-crTGB1-NVldcs98rwbBcgRYVUiw3pWzHbv2PXdSujR0EEHYYRsc5vIoeWrBvF1Mys0FCLzPb0tsMHsRGA1XzAMGoD1sJIkXdwnA9O6vYW; expires=Fri, 18-Oct-2013 19:19:43 GMT; path=/; domain=.google.com; HttpOnly";}s:3:"p3p";s:122:"CP="This is not a P3P policy! See http://www.google.com/support/accounts/bin/answer.py?hl=en&answer=151657 for more info."";s:6:"server";s:3:"gws";s:16:"x-xss-protection";s:13:"1; mode=block";s:15:"x-frame-options";s:10:"SAMEORIGIN";}s:5:"build";s:14:"20121202214312";}', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (232, '_transient_timeout_feed_mod_fec30b017abe520072e5f51214c0d845', '1366355983', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (233, '_transient_feed_mod_fec30b017abe520072e5f51214c0d845', '1366312783', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (234, '_transient_timeout_dash_20494a3d90a6669585674ed0eb8dcd8f', '1366355983', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (235, '_transient_dash_20494a3d90a6669585674ed0eb8dcd8f', '<p>This dashboard widget queries <a href="http://blogsearch.google.com/">Google Blog Search</a> so that when another blog links to your site it will show up here. It has found no incoming links&hellip; yet. It&#8217;s okay &#8212; there is no rush.</p>
', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (236, '_transient_timeout_feed_867bd5c64f85878d03a060509cd2f92c', '1366355983', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (237, '_transient_feed_867bd5c64f85878d03a060509cd2f92c', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"


";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:61:"
	
	
	
	




















































";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:16:"WordPress Planet";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:28:"http://planet.wordpress.org/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:2:"en";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:47:"WordPress Planet - http://planet.wordpress.org/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:50:{i:0;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:67:"WordPress.tv: Erick Arbe: WordPress Navigation in Responsive Design";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18729";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:84:"http://wordpress.tv/2013/04/17/erick-arbe-wordpress-navigation-in-responsive-design/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:682:"<div id="v-ixOlP9OU-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18729/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18729/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18729&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/04/17/erick-arbe-wordpress-navigation-in-responsive-design/"><img alt="WordPress Navigation in Responsive Design.mp4" src="http://videos.videopress.com/ixOlP9OU/video-40e99c6285_scruberthumbnail_0.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 18 Apr 2013 02:33:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:60:"WP Android: Version 2.3 is Here: New User Interface and More";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://android.wordpress.org/?p=759";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:52:"http://android.wordpress.org/2013/04/17/2-3-release/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:6294:"<p><a href="http://wpandroid.files.wordpress.com/2013/04/wordpress-for-android-version-2-3-devices.jpg"><img src="http://wpandroid.files.wordpress.com/2013/04/wordpress-for-android-version-2-3-devices.jpg?w=620&h=454" alt="Version 2.3 of WordPress for Android: menu drawer and action bar" width="620" height="454" class="alignnone size-large wp-image-816" /></a></p>
<p>Today, we&#8217;ve jubilantly released version 2.3 of <a href="http://android.wordpress.org/">WordPress for Android</a> to <a href="https://play.google.com/store/apps/details?id=org.wordpress.android&hl=en">Google Play</a>. After updating, you&#8217;ll see right away that this release includes very exciting updates to the user interface. Let&#8217;s dive in to what&#8217;s new!</p>
<h3>Action Bar</h3>
<p><a href="http://wpandroid.files.wordpress.com/2013/04/wordpress-for-android-version-2-3-action-bar-on-nexus-7.jpg"><img src="http://wpandroid.files.wordpress.com/2013/04/wordpress-for-android-version-2-3-action-bar-on-nexus-7.jpg?w=620&h=295" alt="Version 2.3 of WordPress for Android: action bar on a Nexus 7" width="620" height="295" class="alignnone size-large wp-image-819" /></a><br />
You&#8217;ll notice a fresh, new look. We&#8217;ve taken into account Android&#8217;s &#8220;Holo&#8221; style guidelines and implemented the Action Bar interface throughout the app. If you&#8217;ve used any other apps designed for Android 4.0 or higher, you&#8217;ll feel right at home with the new user interface. Your Action Bar provides easy access to common actions such as creating a new post, refreshing, and sharing to other apps.</p>
<p>We also couldn&#8217;t resist making the Action Bar in WordPress blue. <img src="http://s1.wp.com/wp-includes/images/smilies/icon_wink.gif" alt=";)" class="wp-smiley" /> </p>
<h3>Menu Drawer</h3>
<p><a href="http://wpandroid.files.wordpress.com/2013/04/wordpress-for-android-version-2-3-menu-drawer-on-samsung-galaxy-s3.jpg"><img src="http://wpandroid.files.wordpress.com/2013/04/wordpress-for-android-version-2-3-menu-drawer-on-samsung-galaxy-s3.jpg?w=242&h=491" alt="Version 2.3 of WordPress for Android: menu drawer on Samsung Galaxy S3" width="242" height="491" class="alignright size-medium wp-image-822" /></a></p>
<p>The older-style <a href="http://android.wordpress.org/2011/12/19/version-2-0-android-blogging-re-imagined/">dashboard</a> user interface has been replaced with a Menu Drawer for quick and easy navigation to other areas of the app from wherever you are. You&#8217;ll find all of the same actions the dashboard had, but with the addition of some nifty new ones.</p>
<p>To access the menu, simply tap the arrow next to the WordPress logo &#8211; in the top-left corner of the app &#8212; or swipe from the left side of the screen. If you&#8217;re on a large tablet device, the menu will always be visible, which takes advantage of the extra screen space. If you have multiple blogs in the app, you&#8217;ll see a drop-down list at the top of your Menu Drawer that you can access to quickly switch to another blog to work with, right in the app.</p>
<p>When you leave the app, it will remember the last selection you made in the Menu Drawer so when you return, you can pick up where you left off.</p>
<h3>Other new features</h3>
<p>In addition to the revamped user interface, you&#8217;ll find these new features as well:</p>
<ul>
<li><span><strong>View Site option</strong>. A <em>View Site</em> option has been added to the Menu Drawer so you can view your blogs from within the app.</span></li>
<li><strong>Admin area access.</strong> You can access the wp-admin areas of your WordPress.com blogs by loading the <em>Dashboard</em> option in the Menu Drawer.</li>
<li><strong>Faster loading.</strong> The WordPress.com Reader now takes advantage of caching for faster loading.</li>
<li><strong>Updated look and feel.</strong> Settings have been converted to use the Android standard for preferences, giving them the Holo look and feel on supported devices. Many views have been updated to the Holo look and feel as well, including the post editor and all list views.</li>
<li><strong>Improved post editor experience.</strong> The post editor now has an expandable content area, which makes it much easier to navigate around the post content when you&#8217;re editing.</li>
<li><strong>Improved image uploading.</strong> If a post has an image but fails to upload the image, the post will be saved as a draft first &#8212; instead of published &#8212; so the image upload can be corrected.</li>
</ul>
<h3>Thanks &#8212; and what&#8217;s next</h3>
<p>We thank the developers who worked so hard on this release &#8211; <a href="http://wordpress.org/support/profile/mrroundhill">mrroundhill</a>, <a href="http://wordpress.org/support/profile/willnorris">willnorris</a>, <a href="http://wordpress.org/support/profile/isaackeyet">isaackeyet</a>, <a href="http://wordpress.org/support/profile/daniloercoli">daniloercoli</a> and <a href="http://wordpress.org/support/profile/aerych">aerych</a> &#8211; as well as the beta testers who tried out the app over at the <a href="http://dev.android.wordpress.org">Developer Blog</a>. Great work, all!</p>
<p>We also thank <a href="http://jakewharton.com/">Jake Wharton</a> and <a href="http://simonvt.net/">Simon Vig Therkildsen</a> for creating the ActionBarSherlock and android-menudrawer libraries that enabled us to use the Action Bar and Menu Drawer on older Android devices. Good stuff!</p>
<p>What&#8217;s next? We&#8217;re looking at adding notifications to the app so you can keep up with what&#8217;s happening on your WordPress sites while mobile and on the go.</p>
<p>What would you like to see added to the app?</p>
<h3>Want to contribute?</h3>
<p>Don&#8217;t forget that WordPress for Android is an open source project. Want to get involved? Check out <a href="http://make.wordpress.org/mobile">make.wordpress.org/mobile</a> to get started.</p>
<p>Finally, we&#8217;re always excited to get feedback on the app. Please feel free to leave a comment here or send a tweet to <a href="http://twitter.com/wpandroid">@WPAndroid</a>.</p>
<br />  <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=android.wordpress.org&blog=9426921&post=759&subd=wpandroid&ref=&feed=1" width="1" height="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 17 Apr 2013 19:57:12 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:3:"Dan";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:26:"Alex King: Scared Straight";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://alexking.org/?p=16510";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:51:"http://alexking.org/blog/2013/04/17/scared-straight";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1207:".threads-post-notice {
	background: #e8e8e8;
	padding: 10px;
}
.threads-post-notice a {
	font-weight: bold;
}

<p>I woke up to a bit of a scare when some of my alexking.org Gmail accounts were unable to log in to Gmail. I was afraid the accounts had been compromised and the passwords changed. I had secure passwords, but had been lazy about turning on 2-factor authentication for several of them &#8211; that&#8217;s all fixed now.</p>
<p>As it turned out, the hiccup ended up being due to a Gmail disruption.</p>
<p>I&#8217;ve also turned on 2-factor authentication for this site using <a href="http://wordpress.org/extend/plugins/google-authenticator/">this plugin</a> (make sure to enable the app key if you use iOS or Android apps to connect to your site). Note that the Social logins for commenting still work without 2-factor authentication.</p>
<p>I&#8217;d recommend taking similar steps for your sites. Waking up to an &#8220;uh-oh&#8221; feeling is no fun at all.</p>
<p class="threads-post-notice">This post is part of the thread: <a href="http://alexking.org/blog/thread/passwords">Passwords</a> &#8211; an ongoing story on this site. View the thread timeline for more context on this post.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 17 Apr 2013 13:56:41 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Alex";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:24:"Matt: Dave Keeps Working";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:21:"http://ma.tt/?p=42344";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:40:"http://ma.tt/2013/04/dave-keeps-working/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:617:"<p><a href="http://scripting.com/">Dave Winer</a> tweeted this on Saturday:</p>
<blockquote class="twitter-tweet" width="550"><p>I have a little spare time today so I decided to start on River3. It&#8217;ll be much much smaller and more focused than River2.</p>
<p>&mdash; Dave Winer ? (@davewiner) <a href="https://twitter.com/davewiner/status/323063982061649922">April 13, 2013</a></p></blockquote>
<p></p>
<p>One of the things I love and admire about him is that many, many years after he doesn&#8217;t have to anymore he&#8217;s still learning, hacking, and taking free time on a weeknd to make something new.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 16 Apr 2013 00:57:16 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:64:"Alex King: Any icon artists out there interested in creating …";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://alexking.org/?p=16482";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:41:"http://alexking.org/blog/2013/04/15/16482";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:161:"<div>
<p>Any icon artists out there interested in creating an application icon for a free (GPL) WordPress-based app that @crowdfavorite is working on?</p>
</div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 15 Apr 2013 17:27:57 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Alex";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:53:"Alex King: Backward Compatible WP Heartbeat API Usage";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://alexking.org/?p=16470";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:78:"http://alexking.org/blog/2013/04/14/backward-compatible-wp-heartbeat-api-usage";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:448:"<p>I wanted to utilize the <a href="http://core.trac.wordpress.org/ticket/23216">WP 3.6 heartbeat API</a> in an app I&#8217;m working on. I also wanted to include this feature before WordPress 3.6 officially shipped, so that meant it had to be compatible with WordPress 3.5.x as well.</p>
<p>Turns out, it&#8217;s really easy. The heartbeat API looks excellent.</p>
<p><p>View the code on <a href="https://gist.github.com/5381074">Gist</a>.</p></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sun, 14 Apr 2013 17:52:49 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Alex";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"Matt: Passwords and Brute Force";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:21:"http://ma.tt/?p=42342";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:47:"http://ma.tt/2013/04/passwords-and-brute-force/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1404:"<p>Almost 3 years ago we released a version of WordPress (<a href="http://wordpress.org/news/2010/06/thelonious/">3.0</a>) that allowed you to pick a custom username on installation, which largely ended people using &#8220;admin&#8221; as their default username. Right now there&#8217;s a botnet going around all of the WordPresses it can find trying to login with the &#8220;admin&#8221; username and a bunch of common passwords, and it has turned into a news story (especially from companies that sell &#8220;solutions&#8221; to the problem).</p>
<p>Here&#8217;s what I would recommend: If you still use &#8220;admin&#8221; as a username on your blog, <a href="http://www.digitalkonline.com/blog/change-your-wordpress-admin-username/">change it</a>, use a <a href="http://en.support.wordpress.com/selecting-a-strong-password/">strong password</a>, if you&#8217;re on WP.com <a href="http://en.blog.wordpress.com/2013/04/05/two-step-authentication/">turn on two-factor authentication</a>, and of course make sure you&#8217;re up-to-date on the latest version of WordPress. Do this and you&#8217;ll be ahead of 99% of sites out there and probably never have a problem. Most other advice isn&#8217;t great &#8212; supposedly this botnet has over 90,000 IP addresses, so an IP limiting or login throttling plugin isn&#8217;t going to be great (they could try from a different IP a second for 24 hours).</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 12 Apr 2013 23:55:11 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:57:"WordPress.tv: Mel Choyce: Design Basics for Non-Designers";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18626";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:74:"http://wordpress.tv/2013/04/12/mel-choyce-design-basics-for-non-designers/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:664:"<div id="v-9ujSwIjD-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18626/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18626/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18626&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/04/12/mel-choyce-design-basics-for-non-designers/"><img alt="Mel Choyce: Design Basics for Non-Designers" src="http://videos.videopress.com/9ujSwIjD/mel_choyce_scruberthumbnail_1.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 12 Apr 2013 18:50:49 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:71:"WordPress.tv: Tracy Levesque: Custom Post Types for Right-Brained Folks";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18630";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:88:"http://wordpress.tv/2013/04/12/tracy-levesque-custom-post-types-for-right-brained-folks/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:690:"<div id="v-s94zl0hm-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18630/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18630/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18630&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/04/12/tracy-levesque-custom-post-types-for-right-brained-folks/"><img alt="Tracy Levesque: Custom Post Types for Right-Brained Folks" src="http://videos.videopress.com/s94zl0hm/tracy_levesque_std.original.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 12 Apr 2013 17:49:50 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:54:"WordPress.tv: Jayvie Canono: Designing for Development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18642";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:71:"http://wordpress.tv/2013/04/12/jayvie-canono-designing-for-development/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:661:"<div id="v-CNvoz0Ym-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18642/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18642/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18642&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/04/12/jayvie-canono-designing-for-development/"><img alt="Jayvie Canono: Designing for Development" src="http://videos.videopress.com/CNvoz0Ym/jayvie_canono_scruberthumbnail_0.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 12 Apr 2013 14:45:39 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:10;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:64:"WordPress.tv: Jeremy Pry: An Introduction to WordPress Multisite";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18636";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:81:"http://wordpress.tv/2013/04/12/jeremy-pry-an-introduction-to-wordpress-multisite/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:678:"<div id="v-gM1IUiuf-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18636/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18636/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18636&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/04/12/jeremy-pry-an-introduction-to-wordpress-multisite/"><img alt="Jeremy Pry: An Introduction to WordPress Multisite" src="http://videos.videopress.com/gM1IUiuf/jeremy_pry_scruberthumbnail_0.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 12 Apr 2013 12:44:10 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:11;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:62:"BuddyPress: It’s time to update your BuddyPress installation";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:31:"http://buddypress.org/?p=161349";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:78:"http://buddypress.org/2013/04/its-time-to-update-your-buddypress-installation/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3149:"<p>With the release of BuddyPress 1.7 just a few days ago, and with almost 1.5 million downloads behind us, I wanted to take the time to remind everyone about what&#8217;s gone into improving BuddyPress recently, and to reassure everyone that it&#8217;s okay to update.</p>
<p>In the early days of BuddyPress, things were in flux. Andy and I were furiously building components and features, deprecating code, refactoring the way things worked, and generally tearing up the codebase over and over again. It helped us build a great foundation, but it made updating to the next version a scary and frustrating experience. To those that remember those days, I apologize; to everyone else, I&#8217;m sorry you missed out on the fun. <img src="http://buddypress.org/wp-includes/images/smilies/icon_smile.gif" alt=":)" class="wp-smiley" /> </p>
<p>Whenever your WordPress installation checks to see if BuddyPress needs an update, the WordPress.org Extend API remembers the current version of BuddyPress that you&#8217;re running. This is how we know (with relative accuracy) approximately how many of what versions are out in the wild, and it&#8217;s also how we generated the pinwheel below, taken from the Stats page from WordPress.org Extend:</p>
<div id="attachment_161350" class="wp-caption aligncenter"><img class=" wp-image-161350   " alt="Active BuddyPress Versions" src="http://buddypress.org/wp-content/uploads/1/2013/04/Screen-Shot-2013-04-11-at-3.18.43-PM.png" width="576" height="283" /><p class="wp-caption-text">Every color of the rainbow is clearly represented</p></div>
<p>Despite the pretty colors, this pie chart is actually a little scary. There are so many old and outdated installations of BuddyPress out there, not taking advantage of the neat new features, and not running the most stable and secure code available. The irony is, this is largely our fault.</p>
<p>These days, BuddyPress is a 1 click update in your WordPress dashboard, and we&#8217;ve built a bunch of API&#8217;s that allow third party plugin developers to write plugins that won&#8217;t break when BuddyPress needs an update. We&#8217;ve spent a large part of the past 2 years reinforcing the foundation we invested in, so that no one needs to be afraid to update BuddyPress ever again.</p>
<p>Starting with BuddyPress 1.8, the core team will be focusing our efforts on including automated tests with each enhancement and critical bug fix, to help ensure that each future release gets more stable than the release before it. Boone Gorges and Paul Gibbs both donated huge amounts of labor building a test suite that is already committed into our development branch, just days after BuddyPress 1.7 was packaged up. Their dedication towards making BuddyPress stable and amazing for everyone is unwavering, and their contributions are truly awesome.</p>
<p>If you&#8217;re running an old version of BuddyPress, I urge you to check out and update to BuddyPress 1.7. It&#8217;s the culmination of thousands of hours of effort, and is the most stable, secure, and performant version of BuddyPress yet. Help us change that pinwheel into more of a Pac-Man or a circle.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 11 Apr 2013 21:02:25 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:17:"John James Jacoby";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:12;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:55:"Andrew Nacin: Keynoting php[tek] in Chicago, May 14-17";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:24:"http://nacin.com/?p=4090";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:57:"http://nacin.com/2013/04/11/tek13-php-conference-keynote/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3466:"<p>I&#8217;m excited to announce <strong>I&#8217;m giving a keynote address at <a href="http://tek.phparch.com/">php[tek] 2013</a></strong>. It&#8217;s a fantastic PHP conference put on by the folks behind <a href="http://www.phparch.com/">php|architect</a>. &#8220;The premier professional PHP conference with a community flair,&#8221; #tek13 has a rockstar <a href="http://tek.phparch.com/speakers/">speaker line-up</a>, four tracks of content, and a day of training. I&#8217;m thrilled to be attending the conference &#8212; I also attended #tek11 &#8212; let alone speaking.</p>
<p>Last night I tested a few ideas at the <a href="http://meetup.com/dc-php">DC PHP meetup</a> and got some great feedback from the attendees. Some early reviews:</p>
<blockquote class="twitter-tweet"><p><a href="https://twitter.com/wardnetinc/status/322140560523673601"></a></p></blockquote>
<p></p>
<blockquote class="twitter-tweet"><p><a href="https://twitter.com/kingkool68/status/322151835756544000"></a></p></blockquote>
<p></p>
<blockquote class="twitter-tweet"><p><a href="https://twitter.com/openwestconf/status/322393612249886720"></a></p></blockquote>
<p></p>
<p>I&#8217;m continuing to conduct a <em>lot</em> of research for this talk. There&#8217;s a lot WordPress has learned over the years, so I&#8217;ve been searching through the codebase and old commit messages, as well as compiling a ton of data and statistics. If you have anything you think might help, please <a href="http://gravatar.com/nacin">contact me</a>. Here&#8217;s the full talk description:</p>
<blockquote><p>
<strong>WordPress is Everywhere: Extreme Portability as a Double-Edged Sword</strong></p>
<p>WordPress has tens of millions of users worldwide and powers over a fifth of new sites. But such a large and diverse user base presents unique challenges, and as it approaches its tenth birthday, the WordPress codebase is showing its age. So why is it so ubiquitous?</p>
<p>The answer lies not in its UI, UX, ecosystem, or community, though those are certainly among its strengths. The answer lies instead in a core philosophy that holds the user above all else.</p>
<p>This user-centric design starts not with the interface, but rather with the code itself. Developers should approach software development with an unwavering promise they will deal with the nonsense instead of passing it off to the user.</p>
<p>Some WordPress positions might seem draconian and inflexible. Backwards compatibility is almost never broken. The technical requirements appeal to lowest common denominators. But because the project maintainers deal with all the pain — technical debt, difficulties with PHP, working on as many server configurations (and misconfigurations) as possible — its users don’t have to. Thanks to the WordPress project’s portability efforts, you can pick a web host or a PHP configuration at random and WordPress will run on it. Because of this, adoption has soared.</p>
<p>The way WordPress operates is not for everyone. But whether your projects are used by 10 users, or 10 million, it may help you to see your code in an entirely new light.</p></blockquote>
<p>Tickets are <a href="http://tek.phparch.com/">still available</a>. Hope to see you there!</p>
<p class="share-sfc-stc"><a href="http://twitter.com/share?url=http%3A%2F%2Fwp.me%2FpQEdq-13Y&count=horizontal&related=nacin&text=Keynoting%20php%5Btek%5D%20in%20Chicago%2C%20May%2014-17" class="twitter-share-button"></a></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 11 Apr 2013 17:33:47 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:13;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"Dev Blog: Save the Date: May 27";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2555";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2013/04/save-the-date-may-27/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2059:"<p>What&#8217;s on May 27, you ask?</p>
<p>May 27, 2013 is the <strong>10th anniversary</strong> of the <a href="http://wordpress.org/news/2003/05/wordpress-now-available/">first WordPress release</a>!</p>
<p>We think this is worth celebrating, and we want WordPress fans all over the world to celebrate with us by throwing their own parties. <a href="http://www.meetup.com/WordPress/">We&#8217;re using Meetup Everywhere</a> to coordinate, and will be putting up a website just for the 10th Anniversary so that we can collect photos, videos, tweets, and posts from all the parties.</p>
<p>The rules are very simple:</p>
<ol>
<li><span>Pick a place to go where a bunch of people can be merry &#8212; a park, a bar, a backyard, whatever</span></li>
<li>Spread the word to local meetups, tech groups, press, etc and get people to say they&#8217;ll come to your party</li>
<li>If 50 or more people RSVP to your party, we&#8217;ll try to send you some WordPress stickers and buttons</li>
<li>Have party attendees post photos, videos, and the like with the #wp10 hashtag</li>
</ol>
<p>We&#8217;ll be using Meetup Everywhere to coordinate parties all over the world, so get your city on the map and <a href="http://www.meetup.com/WordPress/">register your party now</a> !</p>
<p>We&#8217;ll follow up with registered organizers  over the next few weeks with some tips for how to publicize your party and to get addresses for swag packages. To that end, make sure you check the option that lets WordPress 10th Anniversary know your email, or we won&#8217;t be able to get in touch with you for these things or to give you access to the WP10 blog.</p>
<p>Whose party will be the biggest? The most fun? The most inventive? Will it be yours?</p>
<p><em>Note: If you already run a group on meetup.com, making your party an event in your group is great, but you still need to post it and have people RSVP at the <a href="http://www.meetup.com/WordPress/">special party page</a>, because regular groups and Meetup Everywhere groups aren&#8217;t connected yet. </em></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 11 Apr 2013 13:48:42 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Jen Mylo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:14;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:87:"WP Windows Phone 7: Push Notifications and a Rich Text Editor: Version 2.1 Is Available";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"http://wpwindowsphone.wordpress.com/?p=429";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:59:"http://wpwindowsphone.wordpress.com/2013/04/11/version-2-1/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3905:"<p><a href="http://wpwindowsphone.files.wordpress.com/2013/04/wpwindowsphone-2-0-comment-push-notifications-and-rich-text-editor.png"><img class="alignright size-large wp-image-453" alt="Screenshot of Version 2.1 of WordPress for Windows Phone: Rich Text Editor and Comment Push Notifications" src="http://wpwindowsphone.files.wordpress.com/2013/04/wpwindowsphone-2-0-comment-push-notifications-and-rich-text-editor.png?w=300&h=560" width="300" height="560" /></a>It’s that time again. Version 2.1 of WordPress for Windows Phone is out and adds some exciting new features.</p>
<p>We’re happy to announce that you can now get comment push notifications on your Windows Phone (OS 7.5+) which enables you to moderate comments from wherever you happen to be at the time. With 2.1 you also get a rich text editor, making it much easier to write longer posts having to deal with any HTML code.</p>
<p>Read on to learn what’s new or update/download version 2.1 from the Windows Phone Store right now by clicking below.</p>
<p class="download"><a href="http://windowsphone.com/s?appid=5f64ad85-f801-e011-9264-00237de2db9e"><strong>Download App</strong>WordPress for Windows Phone</a><span class="download-info">Supported: WordPress.com or self-hosted WordPress (v. 2.9+)</span></p>
<h3>Rich Text Editor</h3>
<p>Now you finally have the ability to use a rich text editor when creating or editing a post or page. The new editor has easy to access styling options beneath the keyboard and in the app menu, these include bulleted/numbered lists, bold, underline, and italic text. You&#8217;ll also find a handy link helper among the text editing tools.</p>
<h3>Comment Push Notifications</h3>
<p>If you have a WordPress.com blog (or a self-hosted blog with the <a href="http://jetpack.me/">Jetpack plugin</a>) added to the app, you can now opt in to receive push notifications for new comments. This makes it easier than ever to keep up with your readers and moderate comments while on the go. You&#8217;ll get push notifications for new comments only and viewing a notification takes you right to the comment within the app. From there you can easily respond and moderate like usual.</p>
<h3>Stability Improvements</h3>
<p>In addition to the new features, we’ve worked hard on making the app even more stable. In total, almost <a href="http://windowsphone.trac.wordpress.org/query?status=closed&group=resolution&milestone=Push+Notifications+and+Content+Editor" target="_blank">40 bugs and crashes</a> have been fixed in this release.</p>
<h3>Screenshots</h3>
<a href="http://wpwindowsphone.wordpress.com/2013/04/11/version-2-1/#gallery-429-1-slideshow">Click to view slideshow.</a>
<h3>Contributors</h3>
<p>The following contributors have worked on this release of WordPress for Windows Phone:  <a href="http://wordpress.org/support/profile/aerych">aerych</a>, <a href="http://wordpress.org/support/profile/isaackeyet">isaackeyet</a>, and <a href="http://wordpress.org/support/profile/daniloercoli">daniloercoli</a>.</p>
<h3>Get Involved!</h3>
<p>We now have a feature-driven release cycle, meaning that updates will come faster and focus on single features and enhancements. This is the perfect time to get involved in the WordPress for Windows Phone project. Check out <a href="http://make.wordpress.org/mobile">make.wordpress.org/mobile</a> and the <a href="http://windowsphonedev.wordpress.org/" target="_blank">WordPress for Windows Phone dev blog</a> to see how you can get involved!</p>
<p>If you’d like to help us translate the app into your native language, check out the <a href="http://translate.wordpress.org/projects/wordpress-for-windows-phone/development" target="_blank">translation project</a>.</p>
<br />  <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wpwindowsphone.wordpress.com&blog=16495748&post=429&subd=wpwindowsphone&ref=&feed=1" width="1" height="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 11 Apr 2013 07:14:53 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:6:"Danilo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:15;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:44:"BuddyPress: BuddyPress 1.7 is now available!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:31:"http://buddypress.org/?p=160310";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:62:"http://buddypress.org/2013/04/buddypress-1-7-is-now-available/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:8955:"<p>BuddyPress 1.7 &#8220;Totonno&#8221; has arrived, and it&#8217;s our best version yet!</p>
<h3>What&#8217;s New in 1.7</h3>
<p>BuddyPress 1.7 is a major feature release, containing hundreds of bugfixes and dozens of new features. We&#8217;ll show off a few of our favorites below. Want to see a full changelog for 1.7? Check it out <a href="http://codex.buddypress.org/developer/releases/version-1-7/">on the Codex</a>.</p>
<p><em>Theme Compatibility</em></p>
<p>BuddyPress&#8217;s social features add new kinds of content to your WordPress site: groups, profiles, and so on. Until now, displaying that content has required building or finding a BP-compatible theme &#8211; one of the biggest hurdles to using BuddyPress. Version 1.7 makes this a thing of the past. Using a feature we call &#8220;theme compatibility&#8221;, BuddyPress can display its content within the context of any WordPress theme &#8211; no modifications required. Here are a few screenshots showing BP running on a few popular themes:</p>
<p><div id="attachment_160342" class="wp-caption alignleft"><a href="http://buddypress.org/wp-content/uploads/1/2013/04/bp-twentytwelve.png"><img src="http://buddypress.org/wp-content/uploads/1/2013/04/bp-twentytwelve-150x150.png" alt="Twenty Twelve" width="150" height="150" class="size-thumbnail wp-image-160342" /></a><p class="wp-caption-text">Twenty Twelve</p></div> <div id="attachment_160343" class="wp-caption alignleft"><a href="http://buddypress.org/wp-content/uploads/1/2013/04/bp-coraline.png"><img src="http://buddypress.org/wp-content/uploads/1/2013/04/bp-coraline-150x150.png" alt="Coraline" width="150" height="150" class="size-thumbnail wp-image-160343" /></a><p class="wp-caption-text">Coraline</p></div> <div id="attachment_160344" class="wp-caption alignleft"><a href="http://buddypress.org/wp-content/uploads/1/2013/04/bp-superstore.png"><img src="http://buddypress.org/wp-content/uploads/1/2013/04/bp-superstore-150x150.png" alt="Woo Superstore" width="150" height="150" class="size-thumbnail wp-image-160344" /></a><p class="wp-caption-text">Woo Superstore</p></div></p>
<div> </div>
<p>Not satisfied with the way it looks out of the box? Not a problem. BuddyPress still provides a sophisticated, modular templating system, which you can easily customize in your own theme. Theme developers and designers can learn much more about theme compat on <a href="http://codex.buddypress.org/developer/theme-development/a-quick-look-at-1-7-theme-compatibility/">the BuddyPress codex</a>.</p>
<div> </div>
<p><em>Group Administration</em></p>
<div id="attachment_160321" class="wp-caption alignright"><a href="http://buddypress.org/wp-content/uploads/1/2013/04/dashboard.png"><img src="http://buddypress.org/wp-content/uploads/1/2013/04/dashboard-300x216.png" alt="Group Administration in BuddyPress 1.7" width="150" class="size-medium wp-image-160321" /></a><p class="wp-caption-text">Group Administration in BP 1.7</p></div>
<p>If you&#8217;ve run a BuddyPress-powered community site, you know that groups are a powerful way for members to connect. But there&#8217;s been no way for site administrators to manage groups. BP 1.7 introduces a brand new set of Group Administration panels on your WordPress Dashboard. Now BP admins can bulk-delete groups, edit group settings, and manage group membership without ever leaving wp-admin.</p>
<div> </div>
<p><em>A Better Installation Experience</em></p>
<div id="attachment_160328" class="wp-caption alignright"><a href="http://buddypress.org/wp-content/uploads/1/2013/04/about.png"><img src="http://buddypress.org/wp-content/uploads/1/2013/04/about-150x150.png" alt="About Screen" width="150" height="150" class="size-thumbnail wp-image-160328" /></a><p class="wp-caption-text">About Screen</p></div>
<p>BuddyPress makes it easy to add social features to your site, and BP 1.7 streamlines the process more than ever. We&#8217;ve removed the installation wizard in favor of a totally automated setup &#8211; just hit Activate, and we&#8217;ll handle the rest. On new installations, only the Activity and Extended Profiles components are activated, helping you to start small and grow your community features bit by bit. And, following in WordPress&#8217;s footsteps, we&#8217;ve added About and Credits screens, helping you to get up to date on the BuddyPress project.</p>
<div> </div>
<h3>Springtime Goodies</h3>
<p>BuddyPress 1.7 is codenamed &#8220;Totonno&#8221;, after <a href="https://en.wikipedia.org/wiki/Totonno%27s">the legendary Brooklyn pizza joint</a>. Totonno&#8217;s is just a few blocks from <a href="https://en.wikipedia.org/wiki/Coney_Island_Cyclone">the Cyclone</a> and the Coney Island boardwalk, and there&#8217;s no better end to a lovely spring day than to indulge in what may be the world&#8217;s greatest pepperoni pie. With spring finally coming to Brooklyn, we think it&#8217;s appropriate to honor a pizza institution with what we think will be a watershed BuddyPress release.</p>
<div> </div>
<h3>The BuddyPress Community Rocks</h3>
<p>Hundreds of developers, designers, and community volunteers have put thousands of hours into this version of BuddyPress. When you use BP, you&#8217;re standing on their shoulders. The following individuals contributed patches during the 1.7 release cycle: </p>
<p>			<a href="http://profiles.wordpress.org/aesqe">aesqe</a>, <a href="http://profiles.wordpress.org/apeatling">apeatling</a>, <a href="http://profiles.wordpress.org/borkweb">borkweb</a>, <a href="http://profiles.wordpress.org/calin">calin</a>, <a href="http://profiles.wordpress.org/chouf1">chouf1</a>, <a href="http://profiles.wordpress.org/chrisclayton">chrisclayton</a>, <a href="http://profiles.wordpress.org/cnorris23">cnorris23</a>, <a href="http://profiles.wordpress.org/ddean">ddean</a>, <a href="http://profiles.wordpress.org/DennisSmolek">DennisSmolek</a>, <a href="http://profiles.wordpress.org/Dianakc">Dianakc</a>, <a href="http://profiles.wordpress.org/dontdream">dontdream</a>, <a href="http://profiles.wordpress.org/empireoflight">empireoflight</a>, <a href="http://profiles.wordpress.org/enej">enej</a>, <a href="http://profiles.wordpress.org/ethitter">ethitter</a>, <a href="http://profiles.wordpress.org/fanquake">fanquake</a>, <a href="http://profiles.wordpress.org/gmax21">gmax21</a>, <a href="http://profiles.wordpress.org/hnla">hnla</a>, <a href="http://profiles.wordpress.org/humanshell">humanshell</a>, <a href="http://profiles.wordpress.org/imath">imath</a>, <a href="http://profiles.wordpress.org/Jacek">Jacek</a>, <a href="http://profiles.wordpress.org/jag1989">jag1989</a>, <a href="http://profiles.wordpress.org/jbobich">jbobich</a>, <a href="http://profiles.wordpress.org/jkudish">jkudish</a>, <a href="http://profiles.wordpress.org/jpsb">jpsb</a>, <a href="http://profiles.wordpress.org/karmatosed">karmatosed</a>, <a href="http://profiles.wordpress.org/MacPresss">MacPresss</a>, <a href="http://profiles.wordpress.org/magnus78">magnus78</a>, <a href="http://profiles.wordpress.org/markjaquith">markjaquith</a>, <a href="http://profiles.wordpress.org/Maty">Maty</a>, <a href="http://profiles.wordpress.org/mercime">mercime</a>, <a href="http://profiles.wordpress.org/michael.ecklund">michael.ecklund</a>, <a href="http://profiles.wordpress.org/modemlooper">modemlooper</a>, <a href="http://profiles.wordpress.org/nacin">nacin</a>, <a href="http://profiles.wordpress.org/netweb">netweb</a>, <a href="http://profiles.wordpress.org/rogercoathup">rogercoathup</a>, <a href="http://profiles.wordpress.org/sboisvert">sboisvert</a>, <a href="http://profiles.wordpress.org/sbrajesh">sbrajesh</a>, <a href="http://profiles.wordpress.org/slaFFik">slaFFik</a>, <a href="http://profiles.wordpress.org/steve7777">steve7777</a>, <a href="http://profiles.wordpress.org/tiraeth">tiraeth</a>, <a href="http://profiles.wordpress.org/will_c">will_c</a>, <a href="http://profiles.wordpress.org/wpdennis">wpdennis</a>, <a href="http://profiles.wordpress.org/xt4v">xt4v</a>.</p>
<div> </div>
<h3>Enjoy!</h3>
<p>Do you have questions about the latest BuddyPress release? Check out the <a href="http://codex.buddypress.org">BuddyPress Codex</a> &#8211; our growing collection of official documentation &#8211; and especially the pages in <a href="http://codex.buddypress.org/version/1-7/">the 1.7 category</a>. Volunteers are also standing by in our active <a href="http://buddypress.org/support">support and discussion forums</a>. If you&#8217;ve found a bug in BuddyPress, or if you want to contribute code to the next release, our development home is <a href="http://buddypress.trac.wordpress.org">buddypress.trac.wordpress.org</a></p>
<p>You might not be able to make it to Coney Island this summer, but we think that BuddyPress 1.7 &#8220;Totonno&#8221; is (almost) just as good. Download it today from the <a href="http://wordpress.org/extend/plugins/buddypress">wordpress.org plugin repository</a>, or from your WordPress Dashboard.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 08 Apr 2013 18:51:06 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Boone Gorges";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:16;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:51:"WordPress.tv: Understanding the WordPress Dashboard";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18552";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:69:"http://wordpress.tv/2013/04/07/understanding-the-wordpress-dashboard/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:631:"<div id="v-HSaaObvw-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18552/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18552/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18552&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/04/07/understanding-the-wordpress-dashboard/"><img alt="wpdashboard.mp4" src="http://videos.videopress.com/HSaaObvw/video-fba8d875a3_std.original.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 08 Apr 2013 06:42:33 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:17;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:63:"Mark Jaquith: WordPress 3.6: shortcode_atts_{$shortcode} filter";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:40:"http://markjaquith.wordpress.com/?p=3975";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:84:"http://markjaquith.wordpress.com/2013/04/04/wordpress-36-shortcode-attribute-filter/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2282:"<p>Since WordPress 3.6 is in beta, I thought I&#8217;d use this nearly-abandoned blog (hey, been busy working on WordPress!) to talk about some of the cool stuff for developers. For the first installment, check out the new <code>shortcode_atts_{$shortcode}</code> filter. The <code>shortcode_atts()</code> function now accepts a third parameter — the name of the shortcode — which enables the running of this filter. All of the core shortcodes now pass this parameter.</p>
<p>This filter passes three things:</p>
<ol>
<li><code>$out</code> — the output array of shortcode attributes</li>
<li><code>$pairs</code> — the array of accepted parameters and their defaults.</li>
<li><code>$atts</code> — the input array of shortcode attributes</li>
</ol>
<p>Let&#8217;s look at what we can do with this. One thing is that you can dynamically set or override shortcode values. You an also define new ones, and transpose them into accepted ones. Let&#8217;s look at the &#8220;gallery&#8221; shortcode for example. What if there was a gallery of images that you would reuse. Instead of picking the images each time, you could have a plugin that gives that set of attachment IDs a shortcut name. Then you could do <code>[gallery foo=my-gallery-name]</code>, which the plugin would convert to a list of IDs. Or, you could enforce a certain number of gallery columns on the fly. Let someone set it theme-wide, without having them go back and change their shortcodes.</p>
<p>What other uses can you think of?</p>
<p>Now, if you&#8217;re a plugin or theme author who provides their own shortcodes, you should immediately start providing this third parameter to your <code>shortcode_atts()</code> calls (since it is an extra parameter, you can do this without a WordPress version check). Maybe it&#8217;ll reduce the number of times people need to fork your code just to add an option to your shortcode!</p>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/markjaquith.wordpress.com/3975/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/markjaquith.wordpress.com/3975/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=markjaquith.wordpress.com&blog=316&post=3975&subd=markjaquith&ref=&feed=1" width="1" height="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 05 Apr 2013 03:12:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Mark Jaquith";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:18;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:30:"Dev Blog: WordPress 3.6 Beta 1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2547";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2013/04/wordpress-3-6-beta-1/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4076:"<p>WordPress 3.6 Beta 1 is now available!</p>
<p>This is software still in development and <strong>we <em>really</em> don’t recommend that you run it on a production site</strong> — set up a test site just to play with the new version. To test WordPress 3.6, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you’ll want “bleeding edge nightlies”). Or you can <a href="http://wordpress.org/wordpress-3.6-beta1.zip">download the beta here</a> (zip).</p>
<p>We&#8217;ve been working for nearly three months and have completed all the features that are slated for this release. This is a bit of a change from the betas of previous release cycles. I felt very strongly that we shouldn&#8217;t release a beta if we were still working on completing the main features. This beta is <strong>actually a beta</strong>, not an alpha that we&#8217;re calling a beta. If you are a WordPress plugin or theme developer, or a WordPress hosting provider, you should absolutely start testing your code against this new version <strong>now</strong>. More bugs will be fixed, and some of the features will get polished, but we&#8217;re not going to shove in some big new feature. We&#8217;re ready for you to test it, so jump in there! The more you test the beta, the more stable our release candidates and our final release will be.</p>
<p>As always, if you think you’ve found a bug, you can post to the <a href="http://wordpress.org/support/forum/alphabeta">Alpha/Beta area</a> in the support forums. Or, if you’re comfortable writing a reproducible bug report, <a href="http://core.trac.wordpress.org/">file one on the WordPress Trac</a>. There, you can also find <a href="http://core.trac.wordpress.org/report/5">a list of known bugs</a> and <a href="http://core.trac.wordpress.org/query?status=closed&group=component&milestone=3.6">everything we&#8217;ve fixed</a> so far.</p>
<p>Here&#8217;s what&#8217;s new in 3.6:</p>
<ul>
<li><strong>Post Formats: </strong> Post Formats now have their own UI, and theme authors have access to templating functions to access the structured data.</li>
<li><strong>Twenty Thirteen:</strong> We&#8217;re shipping this year&#8217;s default theme in our first release of the year. Twenty Thirteen is an opinionated, color-rich, blog-centric theme that makes full use of the new Post Formats support.</li>
<li><strong>Audio/Video:</strong> You can embed audio and video files into your posts without relying on a plugin or a third party media hosting service.</li>
<li><strong>Autosave: </strong> Posts are now autosaved locally. If your browser crashes, your computer dies, or the server goes offline as you&#8217;re saving, you won&#8217;t lose the your post.</li>
<li><strong>Post Locking: </strong> See when someone is currently editing a post, and kick them out of it if they fall asleep at the keyboard.</li>
<li><strong>Nav Menus: </strong> Nav menus have been simplified with an accordion-based UI, and a separate tab for  bulk-assigning menus to locations.</li>
<li><strong>Revisions:</strong> The all-new revisions UI features avatars, a slider that &#8220;scrubs&#8221; through history, and two-slider range comparisons.</li>
</ul>
<p><strong>Developers: </strong> You make WordPress awesome(er). One of the things we strive to do with every release is be compatible with existing plugins and themes. But we need your help. <strong>Please test your plugins and themes against 3.6.</strong> If something isn&#8217;t quite right, please let us know. (Chances are, it wasn&#8217;t intentional.) If you&#8217;re a forward-thinking theme developer, you should be looking at implementing the new Post Format support in some of your themes (look to Twenty Thirteen for inspiration).</p>
<p>We&#8217;re looking forward to your feedback. If you break it (i.e. find a bug), please report it, and if you’re a developer, try to help us fix it. We&#8217;ve already had more than 150 contributors to version 3.6 — it&#8217;s not too late to join the party!</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 04 Apr 2013 17:25:29 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Mark Jaquith";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:19;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:35:"Dougal Campbell: CodePoet Interview";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"http://dougal.gunters.org/?p=72513";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:77:"http://dougal.gunters.org/blog/2013/04/04/dougal-campbell-codepoet-interview/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1589:"<div class="featured-image align-right"><img width="164" height="52" src="http://geekramblings.gunters.netdna-cdn.com/wordpress/wp-content/uploads/2013/04/codepoet-logo.png?9bb111" class="attachment-post-thumbnail wp-post-image" alt="CodePoet Logo" /></div><!--
article.tag-codepoet div.featured-image img{background-color: #333;}
-->
<p>I was honored to be chosen for an <a title="It\'s me!" href="http://build.codepoet.com/2013/04/04/dougal-campbell-interview/">interview on CodePoet</a>. Though I haven&#8217;t been able to stay as involved with WordPress as much lately as I&#8217;d like, due to job and family, I guess I&#8217;m of &#8220;historical interest&#8221; because of my involvement as a core developer back in the first couple of years. (I jest &#8212; a little)</p>
<p>We discuss how I came to web development and from there to WordPress, my more recent activity as a speaker at WordCamp Atlanta on the topic of security, the community and why someone should become involved, and the differences between web development as a job versus as a hobby, among other things.</p>
<p>I enjoyed answering the questions, and I hope you all will enjoy reading the interview!</p>
<p>&nbsp;</p>
<p>Original Article: <a href="http://dougal.gunters.org/blog/2013/04/04/dougal-campbell-codepoet-interview/">CodePoet Interview</a>
<a href="http://dougal.gunters.org">Dougal Campbell&#039;s geek ramblings - WordPress, web development, and world domination.</a></p><div class="yarpp-related-rss yarpp-related-none">
<img src="http://yarpp.org/pixels/5db43ee24c4f1e1d0e45d08cc91b0130" />
</div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 04 Apr 2013 16:03:51 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"Dougal Campbell";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:20;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:54:"Gravatar: Gravatar and WordPress.com, Together Forever";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:31:"http://blog.gravatar.com/?p=437";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:80:"http://blog.gravatar.com/2013/04/03/gravatar-and-wordpress-com-together-forever/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3493:"<p>Did you know that your Gravatar.com account has always been a WordPress.com account? It&#8217;s true.</p>
<p>Back in 2007 we (<a href="http://automattic.com">Automattic</a>) acquired Gravatar. Heading into 2008 we <a href="http://blog.gravatar.com/2008/03/14/big-changes-afoot/">rewrote it in PHP</a>, and ever since then, it&#8217;s been using the same integrated user system as WordPress.com for accounts. Previously we handled that &#8220;behind the scenes,&#8221; but we found that it made things pretty confusing for everyone. We&#8217;ve now switched over to using <a href="http://en.support.wordpress.com/wpcc-faq/">WordPress.com Connect</a> exclusively, which allows you to explicitly connect Gravatar and WordPress.com, and to use your WordPress.com credentials to log into Gravatar. That&#8217;s one less set of login credentials to worry about!</p>
<div id="attachment_438" class="wp-caption aligncenter"><img class="size-full wp-image-438" alt="wpcc-button" src="http://gravatar.files.wordpress.com/2013/04/wpcc-button.png?w=258&h=65" width="258" height="65" /><p class="wp-caption-text">This is not a real button <img src="http://s0.wp.com/wp-includes/images/smilies/icon_smile.gif" alt=":)" class="wp-smiley" /></p></div>
<ol>
<li><span>If you had a Gravatar account before, it&#8217;s actually always been a WordPress.com account!</span></li>
<li>When you try to log in at Gravatar.com now, you will be asked to do so using WordPress.com Connect.</li>
<li>Once you&#8217;re logged into WordPress.com, you then grant Gravatar access to use your WordPress.com account.</li>
<li>After that, you&#8217;ll use your WordPress.com username and password to log in to Gravatar, for evermore.</li>
</ol>
<p>You might be wondering about existing accounts and creating new accounts, and what your options are:</p>
<ul>
<li><span>If you have a Gravatar account, it&#8217;s actually also a WordPress.com account. You can use those details to log into WordPress.com, then grant access to Gravatar.</span></li>
<li>If you already have a WordPress.com account, then you can use that to log into Gravatar.com now.</li>
<li>If you don&#8217;t have a WordPress.com (or Gravatar) account, you can create one for free (no need for a blog, although you can do that also if you like!) and then you can grant access to Gravatar to get started.</li>
</ul>
<p>The beauty of switching to WordPress.com Connect is that it means your account information is all managed in one, super-secure place (WordPress.com), and it avoids all sorts of complexity and potential for problems with password resets, account activations, and more. We&#8217;re in the process of switching all of our services to using WordPress.com Connect, so you can use the same account to log into our other nifty products, including <a href="http://vaultpress.com">VaultPress</a>, <a href="http://akismet.com">Akismet</a> and <a href="http://polldaddy.com">Polldaddy</a>.</p>
<p>There&#8217;s a bunch more info on the <a href="http://en.support.wordpress.com/wpcc-faq/">WordPress.com Connect FAQ</a>, which will hopefully help clear up any other questions you have.</p>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/gravatar.wordpress.com/437/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/gravatar.wordpress.com/437/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=blog.gravatar.com&blog=1886259&post=437&subd=gravatar&ref=&feed=1" width="1" height="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 03 Apr 2013 18:33:55 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Beau Lebens";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:21;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:61:"WordPress.tv: Understanding the WordPress Add New User Screen";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18463";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:79:"http://wordpress.tv/2013/03/31/understanding-the-wordpress-add-new-user-screen/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:642:"<div id="v-pjAMiXtc-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18463/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18463/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18463&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/03/31/understanding-the-wordpress-add-new-user-screen/"><img alt="wpaddnewuser.mp4" src="http://videos.videopress.com/pjAMiXtc/video-5b0b00cf6d_std.original.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 01 Apr 2013 04:45:07 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:22;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:57:"WordPress.tv: Understanding WordPress Discussion Settings";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18455";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"http://wordpress.tv/2013/03/31/understanding-wordpress-discussion-settings/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:644:"<div id="v-QKczX0JE-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18455/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18455/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18455&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/03/31/understanding-wordpress-discussion-settings/"><img alt="wpdiscussion.mp4" src="http://videos.videopress.com/QKczX0JE/video-5280873d59_scruberthumbnail_2.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 01 Apr 2013 04:30:17 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:23;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:59:"WordPress.tv: Phil Erb: WordPress is Installed… Now What?";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18452";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:72:"http://wordpress.tv/2013/03/28/phil-erb-wordpress-is-installed-now-what/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:674:"<div id="v-f6li6sy6-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18452/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18452/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18452&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/03/28/phil-erb-wordpress-is-installed-now-what/"><img alt="Phil Erb: WordPress is Installed&#8230; Now What?" src="http://videos.videopress.com/f6li6sy6/video-50494d19a5_scruberthumbnail_0.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 01 Apr 2013 04:30:06 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:24;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:100:"Weblog Tools Collection: I am taking my leave of Weblog Tools Collection, and thanks for everything!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"http://weblogtoolscollection.com/?p=12845";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"http://feedproxy.google.com/~r/weblogtoolscollection/UXMP/~3/NRKA8GMV-fA/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4720:"<p>Not many of the present readers might know me very well, and that in part, is the reason that I have made the decision to transfer WLTC to more willing and presently capable hands. I am a stranger on my blog and the time has come for me to make sure that this blog, its contents and its knowledge are archived and preserved and maybe rejuvenated at a later time.</p>
<p>I delved into blogging tools back in 2004 when I started my Masters degree in CS. I wanted some code to mess around with in my free time and everyone was talking about blogging. I looked into a variety of tools, built a small Linux server for myself at home, and installed a few of the tools that were freely available at that time. I had a heck of a time getting a hold of MT (Moveable Type, the most well-known name) and then found b2 by sheer luck. I loved the cool look of Michael&#8217;s blog and the people involved in the tool seemed to be open to comments and replied warmly to my emails and questions. Through the b2 forums I heard about WordPress and proceeded to install it on my own. To my astonishment, it worked without a hitch and I was blogging away in no time. I started looking through the code to understand how it worked and it drew me in every step of the way.</p>
<p>Within a few months of installing WordPress, I started to take part in the forums and wrote a few plugins and created some &#8220;hacks&#8221; for the tool. I even gained some notoriety with my MT VS WP post and that&#8217;s when the WordPress ecosphere started to look very attractive to me. I did not do this to seek attention, but I was getting a lot of attention and I was loving it. I believe that was when Matt first noticed me and we exchanged some emails and chatted with each other. With every month and with every release of WordPress I was getting more involved. At some point I realized that I could not do it alone and hired a few interested people to help me write posts and the blog started to get popular. I brought on some advertisers to help me offset costs. Matt gave me and my blog the highest honor of being included in the WordPress Planet and that&#8217;s when things really started to happen for this blog. I also started a WordPress Job blog (http://jobs.wordpress.net) which I still curate and I got involved in WordPress evangelism. Somewhere within this time, Matt had asked me to work for him at the new company he was starting and I had to turn him down because of visa restrictions and because I wanted to finish school (I kick myself every time I think about that).</p>
<p>WordPress started to mature and WordCamps started to happen. I graduated from school with a Master&#8217;s Degree in Computer Science and found a job. I wanted to stay involved but it was getting bigger than I could handle. I could either dive in and get into WordPress and the blogging world, or I could focus on my job, career and family. I decided to choose the latter. I still wanted to loosely be involved with WordPress and things went well for a couple of years with me being casually involved. I even visited and spoke at a couple of WordCamps.</p>
<p>When my son Lucien was born, all my time and attention was exhausted on him. I could not spend any time with WordPress or blogging at all. In addition to my growing family, I was diagnosed with a serious health condition just as I was starting a new job and moving to a new city. Needless to say, the blog was the last thing on my mind. James, who has been the sole author and curator for a long time, was my winning hand and just a fantastic helper and well wisher. He has kept things running for a long time and I have had no complaints.</p>
<p>But I have found very little time to come back and spend with my old friends, Weblog Tools Collection and WordPress. I do not want this blog&#8217;s content and conversations to be lost or forgotten because of my neglect. I am hoping this move will help it live on as an archive, or find new lifeblood in another form. I know that it is in the right hands.</p>
<p>So Adios and Gracias. I hope to see you in another blog, and take part in another conversation with you someday. It has been a wonderful journey and I appreciate everything that has taken place because of WordPress and every bit of help and encouragement that has been provided to me by so many of you. So thank to my wonderful audience of many years, thanks to my advertisers, thanks to my authors and finally thanks to Matt and to WordPress for making my life so much more fulfilling and successful.</p>
<p>Peace on Earth, Goodwill to All, And to All a Goodnight!</p>
<img src="http://feeds.feedburner.com/~r/weblogtoolscollection/UXMP/~4/NRKA8GMV-fA" height="1" width="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sun, 31 Mar 2013 13:41:38 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:10:"Mark Ghosh";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:25;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:53:"Weblog Tools Collection: Where to Find WordPress News";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"http://weblogtoolscollection.com/?p=12846";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"http://feedproxy.google.com/~r/weblogtoolscollection/UXMP/~3/ah3QRPNnlhs/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2837:"<p>The landscape of news has changed so much over the last few years that news about a particular topic or platform is readily available to anyone within an instant. With <a href="http://wordpress.org">WordPress</a>, I imagine that could be one of the perks of <a href="http://weblogtoolscollection.com/archives/2012/08/08/the-state-of-the-word-in-2012/">powering over 16% of the web</a>, but it&#8217;s true that news is becoming incredibly accessible. In short, news is everywhere.</p>
<p>Speaking of WordPress in general, you can of course acquire official direct news from <a href="http://wordpress.org/news/">WordPress News</a>, but you can also take a peak behind the curtain and follow news in the making at <a href="http://make.wordpress.org">Make WordPress.org</a>. Though it&#8217;s only specific to the <a href="http://wordpress.com">WordPress.com</a> blogging platform, <a href="http://en.blog.wordpress.com">WordPress.com News</a> is also worth watching for WordPress development news, as WordPress.com users often get access to new WordPress features before they&#8217;re released, so you&#8217;ll be able to try new features rather than just read about them.</p>
<p>There&#8217;s more news than just direct official news, like I said earlier, it&#8217;s everywhere. You could subscribe to every general news site, every core developer&#8217;s personal blog, every premium theme shop, and every plugin developer, but why not subscribe to a few curated news sources instead? I guess you could call <a href="http://planet.wordpress.org">WordPress Planet</a> the official curated news source, but it&#8217;s really just a collection of all news items from a particular set of curated blogs. For specific news items curated from sources through the entire WordPress community, subscribe to <a href="http://poststat.us">Post Status</a>, and don&#8217;t neglect the power of allowing the folks you follow on <a href="http://twitter.com">Twitter</a>, <a href="http://plus.google.com">Google+</a>, and/or <a href="http://www.facebook.com">Facebook</a> to curate news for you.</p>
<p>Speaking of the WordPress community, you should <a href="http://codex.wordpress.org/Contributing_to_WordPress">get involved</a> if you aren&#8217;t already. If you don&#8217;t even use WordPress yet, it&#8217;s time to get started <a href="http://codex.wordpress.org/Getting_Started_with_WordPress">with either WordPress.org</a> or <a href="http://learn.wordpress.com/get-started/">with WordPress.com</a>, share your thoughts with the world, and maybe spread some WordPress news on your blog too.</p>
<p>The news is out there, and it&#8217;s well within your reach. If you can&#8217;t find the news, it&#8217;s time to make your own.</p>
<img src="http://feeds.feedburner.com/~r/weblogtoolscollection/UXMP/~4/ah3QRPNnlhs" height="1" width="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sun, 31 Mar 2013 00:05:06 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"James";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:26;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:59:"Weblog Tools Collection: WordPress Plugin Releases for 3/30";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"http://weblogtoolscollection.com/?p=12837";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"http://feedproxy.google.com/~r/weblogtoolscollection/UXMP/~3/-vmyakR-BnA/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1089:"<h3>New plugins</h3>
<p><a href="http://wordpress.org/extend/plugins/gc-message-box/"><strong>GC Message Box</strong></a> allows you to highlight your key message(s) in smart ways within articles and blog posts.</p>
<p><a href="http://wordpress.org/extend/plugins/simple-social-icons/"><strong>Simple Social Icons</strong></a> allows you to insert social icons in any widget area.</p>
<p><a href="http://askwebexpert.com/stick-it/"><strong>Stick It</strong></a> allows you to stick the navigation menu in any theme to the top of browser window.</p>
<h3>Updated plugins</h3>
<p><a href="http://jetpack.me/"><strong>Jetpack</strong></a> allows you to supercharge your WordPress site with powerful features previously only available to <a href="http://wordpress.com/">WordPress.com</a> users.</p>
<p><a href="http://blog.milandinic.com/wordpress/plugins/nav-menu-images/"><strong>Nav Menu Images</strong></a> enables uploading of images for nav menu items on the menu edit screen.</p>
<img src="http://feeds.feedburner.com/~r/weblogtoolscollection/UXMP/~4/-vmyakR-BnA" height="1" width="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 30 Mar 2013 14:00:38 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"James";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:27;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"Matt: (Un)organized Consumption";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:21:"http://ma.tt/?p=42334";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:45:"http://ma.tt/2013/03/unorganized-consumption/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:387:"<p><a href="http://writingthroughthefog.com/2013/03/09/on-unorganized-consumption/">On (Un)organized Consumption</a> by Automattician Cheri Lucas. &#8220;I stopped using Instapaper. Early on, I relied on it as a space to store ideas and information I could draw from, but it quickly became my intellectual limbo: the unfortunate vault of forgotten stories and Twitter residue.&#8221;</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 29 Mar 2013 14:20:19 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:28;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:32:"Matt: Evolution of San Francisco";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:21:"http://ma.tt/?p=42333";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:48:"http://ma.tt/2013/03/evolution-of-san-francisco/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2968:"<p>There have been three excellent writings on the effects and consequences of the latest boom on the Bay Area, each long but worth reading.</p>
<p>The East Bay Express, with a permalink I&#8217;m sure won&#8217;t work a decade from now, brings us <a href="http://www.eastbayexpress.com/oakland/the-bacon-wrapped-economy/Content?oid=3494301&showFullText=true">The Bacon-Wrapped Economy</a>:</p>
<div class="blockquote">
<blockquote>The arts economy, already unstable, has been forced to contend with the twin challenges of changing tastes and new funding models. Entire industries that didn&#8217;t exist ten years ago are either thriving on venture capital, or thriving on companies that are thriving on it. It is now possible to find a $6 bottle of Miller High Life, a $48 plate of fried chicken, or a $20 BLT in parts of the city that used to be known for their dive bars and taco stands. If, after all, money has always been a means of effecting the world we want to bring about, when a region is flooded with uncommonly rich and uncommonly young people, that world begins to look very different. And we&#8217;re all living in it, whether we like it or not.</p></blockquote>
</div>
<p>SFGate has <a href="http://www.sfgate.com/technology/dotcommentary/article/Innovation-and-the-face-of-capitalism-4342160.php">The hypocrisy in Silicon Valley&#8217;s big talk on innovation</a>:</p>
<div class="blockquote">
<blockquote>&#8220;[I]nnovation&#8221; is something of a magic word around here, shape-shifting to fit the speaker&#8217;s immediate needs. So long as semiconductors and coding are involved, people will staple it to anything from flying cars to the iFart app.</p>
<p>Other times it&#8217;s just code for &#8220;jobs,&#8221; used to justify asking for government favors one day and scolding them for meddling in the free market the next.</p>
<p>&#8220;Lower our payroll taxes because &#8230; innovation.&#8221;<br />
&#8220;Drop that antitrust inquiry because &#8230; innovation.&#8221;</p>
<p>But for all the funding announcements, product launches, media attention and wealth creation, most of Silicon Valley doesn&#8217;t concern itself with aiming &#8220;almost ridiculously high.&#8221; It concerns itself primarily with getting people to click on ads or buy slightly better gadgets than the ones they got last year.</p></blockquote>
</div>
<p>The final comes from Rebecca Solnit, <a href="http://ma.tt/2011/07/on-blue/">who I&#8217;ve quoted before</a>, writes <a href="http://www.lrb.co.uk/v35/n03/rebecca-solnit/diary">a diary for the London Review of Books</a>.</p>
<div class="blockquote">
<blockquote>I weathered the dot-com boom of the late 1990s as an observer, but I sold my apartment to a Google engineer last year and ventured out into both the rental market (for the short term) and home buying market (for the long term) with confidence that my long standing in this city and respectable finances would open a path.</p></blockquote>
</div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 28 Mar 2013 15:49:52 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:29;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:58:"Weblog Tools Collection: WordPress Theme Releases for 3/28";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"http://weblogtoolscollection.com/?p=12825";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"http://feedproxy.google.com/~r/weblogtoolscollection/UXMP/~3/gKIU6AevNTQ/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1374:"<p><a href="http://emptynestthemes.com/2013/03/26/airtime-wordpress-blog-theme"><img class="alignnone size-thumbnail wp-image-12826" alt="screenshot2" src="http://i1.wp.com/weblogtoolscollection.com/wp-content/uploads/2013/03/screenshot21.png?resize=150%2C150" /></a></p>
<p><a href="http://emptynestthemes.com/2013/03/26/airtime-wordpress-blog-theme/"><strong>AirTime</strong></a> is a subtle and simple theme.</p>
<p><a href="http://wordpress.org/extend/themes/firmasite"><img class="alignnone size-thumbnail wp-image-12827" alt="screenshot" src="http://i2.wp.com/weblogtoolscollection.com/wp-content/uploads/2013/03/screenshot6.png?resize=150%2C150" /></a></p>
<p><a href="http://wordpress.org/extend/themes/firmasite"><strong>FirmaSite</strong></a> is a responsive theme with <a href="http://buddypress.org">BuddyPress</a> and <a href="http://bbpress.org">bbPress</a> support.</p>
<p><a href="http://wordpress.org/extend/themes/stark-lite"><img class="alignnone size-thumbnail wp-image-12828" alt="screenshot-1" src="http://i2.wp.com/weblogtoolscollection.com/wp-content/uploads/2013/03/screenshot-16.png?resize=150%2C150" /></a></p>
<p><a href="http://wordpress.org/extend/themes/stark-lite"><strong>Stark Lite</strong></a> is a minimalist and simple theme.</p>
<img src="http://feeds.feedburner.com/~r/weblogtoolscollection/UXMP/~4/gKIU6AevNTQ" height="1" width="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 28 Mar 2013 14:00:13 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"James";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:30;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:44:"bbPress: bbPress 2.3 – Release Candidate 1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://bbpress.org/?p=131092";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:64:"http://bbpress.org/blog/2013/03/bbpress-2-3-release-candidate-1/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1175:"<p>Today the bbPress team is happy to announce <a href="http://downloads.wordpress.org/plugin/bbpress.zip">bbPress 2.3, release candidate 1</a>.</p>
<p>bbPress 2.3 introduces forum-specific search functionality, so that your users are able to search your forum posts without interfering with your blog posts. It simplifies the fancy topic and reply editors, enabling only the functionality your users should see. Lastly, we&#8217;ve included more forum migration tools to help you transition to bbPress from Vanilla, Mingle, and SimplePress.</p>
<p>With that, we bring you <a href="http://downloads.wordpress.org/plugin/bbpress.zip">bbPress 2.3, Release Candidate 1</a>. Please try it, either on a test site, or wherever you feel comfortable running it, and <a href="http://bbpress.trac.wordpress.org">let us know if you run into any issues</a>.</p>
<p>Oh yeah&#8230; If you want to stay on the bleeding edge of releases, check out the <a href="http://wordpress.org/extend/plugins/bbpress-beta-tester/">bbPress Beta Tester</a> plugin! It&#8217;s really neat. <img src="http://bbpress.org/wordpress/wp-includes/images/smilies/icon_smile.gif" alt=":)" class="wp-smiley" /> </p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 27 Mar 2013 21:14:18 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:17:"John James Jacoby";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:31;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:60:"WordPress.tv: WordPress General Settings and WordPress Roles";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18439";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:78:"http://wordpress.tv/2013/03/27/wordpress-general-settings-and-wordpress-roles/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:652:"<div id="v-Pz6kgctM-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18439/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18439/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18439&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/03/27/wordpress-general-settings-and-wordpress-roles/"><img alt="wpgeneralsettings.mp4" src="http://videos.videopress.com/Pz6kgctM/video-1094a9ccf9_scruberthumbnail_0.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 27 Mar 2013 20:20:23 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:32;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:50:"BuddyPress: BuddyPress 1.7 – Release Candidate 1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:31:"http://buddypress.org/?p=158776";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:65:"http://buddypress.org/2013/03/buddypress-1-7-release-candidate-1/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1388:"<p>Today the BuddyPress team would like to tell you a bit about <a href="http://downloads.wordpress.org/plugin/buddypress.zip">BuddyPress 1.7, release candidate 1</a>.</p>
<p>BuddyPress 1.7 is going to be one of our most exciting releases to date. It comes packaged with the same theme compatibility that was introduced in bbPress 2.0, which means that BuddyPress will now work out-of-the-box with a majority of the WordPress themes available today.</p>
<p>We&#8217;ve also fixed <a href="http://buddypress.trac.wordpress.org/milestone/1.7">a bunch of annoyances</a>, and smoothed out the installation and update experiences, to provide users and site-admins with a less intimidating introduction into building a community with BuddyPress.</p>
<p>Because of the hugeness of 1.7&#8242;s features and changes, we&#8217;ve spent a little extra time rigorously testing it with various types of themes and installations, to make it a worry-free update from BuddyPress 1.5 or later. The beta-testing phase has gone well, and uncovered only a few loose-ends that needed tying.</p>
<p>With that, we bring you <a href="http://downloads.wordpress.org/plugin/buddypress.zip">BuddyPress 1.7, Release Candidate 1</a>. Please try it, either on a test site, or wherever you feel comfortable running it, and <a href="http://buddypress.trac.wordpress.org/">let us know if you run into any issues</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 27 Mar 2013 19:47:53 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:17:"John James Jacoby";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:33;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:37:"Matt: Imports Keep Rolling, and Trust";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:21:"http://ma.tt/?p=42335";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:39:"http://ma.tt/2013/03/imports-and-trust/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:900:"<p>TechCrunch writes <a href="http://techcrunch.com/2013/03/26/wordpress-com-has-imported-15m-posts-in-the-last-30-days-remains-a-top-safe-haven-for-nomad-bloggers/">WordPress.com Has Imported 15M Posts In The Last 30 Days, Remains A Top Safe Haven For Nomad Bloggers</a>. I&#8217;m very proud of the 8+ years we&#8217;ve been a home for, and protected, our users blogs. Protection covers many aspects: backups, scalability, security, speed, permalinks, mobile versions, forward-compatible markup, clean exports&#8230; the list goes on. We&#8217;ve done the same with other internet-scale services, like <a href="http://akismet.com/">Akismet</a>, <a href="http://gravatar.com/">Gravatar</a>, and <a href="http://jetpack.me/">Jetpack</a>, and I hope to earn the same trust in the coming decade with <a href="http://vaultpress.com/">VaultPress</a> and <a href="http://simperium.com/">Simperium</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 27 Mar 2013 14:07:56 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:34;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:16:"Matt: No to NoUI";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:21:"http://ma.tt/?p=42332";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:32:"http://ma.tt/2013/03/no-to-noui/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:231:"<p><a href="http://www.elasticspace.com/2013/03/no-to-no-ui">No to NoUI</a> by Timo Arnall is one of the better pieces I&#8217;ve read on design and interfaces, and is also chock-full of links that will keep you busy for hours.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 26 Mar 2013 14:12:47 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:35;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:48:"WordPress.tv: Understanding WordPress Permalinks";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18376";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:66:"http://wordpress.tv/2013/03/25/understanding-wordpress-permalinks/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:633:"<div id="v-kEYdKErG-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18376/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18376/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18376&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/03/25/understanding-wordpress-permalinks/"><img alt="permalinks.mp4" src="http://videos.videopress.com/kEYdKErG/video-f10e063f57_scruberthumbnail_1.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 25 Mar 2013 20:02:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:36;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:66:"WP iPhone: Version 3.5 is Here: Draft Previews, Autosave, and More";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"http://ios.wordpress.org/?p=1376";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:89:"http://ios.wordpress.org/2013/02/22/version-3-5-is-here-draft-previews-autosave-and-more/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3713:"<p><a href="http://wpiphone.files.wordpress.com/2013/02/wpios-3-5-draft-previews-plus-autosave.png"><img src="http://wpiphone.files.wordpress.com/2013/02/wpios-3-5-draft-previews-plus-autosave.png?w=240&h=517" alt="Version 3.5 of WordPress for iOS: Draft Previews + Autosave" width="240" height="517" class="alignright size-medium wp-image-1402" /></a>We&#8217;re pleased as punch to announce that WordPress for iOS 3.5 is now available in the <a href="https://itunes.apple.com/us/app/wordpress/id335703880?ls=1&mt=8">App Store</a>. The dev team focused on the content editor for this release, which adds some very handy new features:</p>
<h3>Draft previews</h3>
<p>We know that publishing your very best stuff is important, and you should be able to see what your post or page will look like <em>before</em> you publish. Now, in version 3.5 of WordPress for iOS, you can preview your drafts! Just tap the preview &#8220;eye&#8221; tab while drafting your post or page to see the post as it will appear on your WordPress site after you hit publish.</p>
<p>If you have a <a href="http://en.wikipedia.org/wiki/Responsive_web_design">responsive</a> WordPress theme the preview will show what your post looks like on a mobile device.</p>
<h3>Autosave</h3>
<p>Thanks to a new Autosave feature, your site&#8217;s content is safer than ever before. Now, when you edit a draft in the app, you&#8217;ll notice a small &#8220;Autosaved ✓&#8221; message appear as you type. The draft is instantly saved locally, and if you have a reliable Internet connection at the time, it will autosave online to your WordPress site, too.</p>
<p><img src="http://wpiphone.files.wordpress.com/2013/02/wpios-3-5-autosave1.jpg?w=420&h=188" alt="Version 3.5 of WordPress for iOS: Autosave" width="420" height="188" class="aligncenter size-full wp-image-1395" /></p>
<h3>More improvements and bug fixes</h3>
<p>This release also includes improvements for WordPress.com and Jetpack notifications, as well as fixes for crashes and other bugs. You can check out all the changes <a href="http://ios.trac.wordpress.org/timeline?from=02%2F11%2F13&daysback=6&authors=&ticket=on&milestone=on&changeset=on&wiki=on&update=Update">here</a>.</p>
<p>The crash on launch that some of you were seeing has been fixed in this release.</p>
<h3>What&#8217;s next?</h3>
<p>We want to continue making your mobile blogging experience better and better! While the dev team is currently deciding what to work on for version 3.6, these next items are high on our list:</p>
<ul>
<li>Rich Text Editor</li>
<li>Improved media management</li>
<li>Sharing to the app from third-party apps and services</li>
</ul>
<p>Want to keep up with the latest happenings in the WordPress mobile world? Head over to <a href="http://make.wordpress.org/mobile">http://make.wordpress.org/mobile</a>.</p>
<p>A huge thanks to the contributors that worked on this release: <a href="http://wordpress.org/support/profile/beaucollins">beaucollins</a>, <a href="http://wordpress.org/support/profile/daniloercoli">daniloercoli</a>, <a href="http://wordpress.org/support/profile/koke">koke</a>, and <a href="http://wordpress.org/support/profile/mrroundhill">mrroundhill.</a></p>
<p>If you have any feedback about the app, please leave a comment below or follow us <a href="http://twitter.com/wordpressios">@WordPressiOS</a>.</p>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wpiphone.wordpress.com/1376/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wpiphone.wordpress.com/1376/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=ios.wordpress.org&blog=3882653&post=1376&subd=wpiphone&ref=&feed=1" width="1" height="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 25 Mar 2013 18:30:11 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:3:"Dan";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:37;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:59:"Weblog Tools Collection: WordPress Plugin Releases for 3/25";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"http://weblogtoolscollection.com/?p=12819";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"http://feedproxy.google.com/~r/weblogtoolscollection/UXMP/~3/J5kgleppg3E/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1264:"<h3>New plugins</h3>
<p><a href="http://wordpress.org/extend/plugins/easy-watermark/"><strong>Easy Watermark</strong></a> automatically adds watermark to images when they are uploaded.</p>
<p><a href="http://wordpress.org/extend/plugins/cat-signal/"><strong>Internet Defense League Cat Signal</strong></a> automatically loads either the modal or the banner Cat Signal when there is an active campaign from <a href="http://internetdefenseleague.org">the Internet Defense League</a>.</p>
<h3>Updated plugins</h3>
<p><a href="http://calendarscripts.info/autoresponder-wordpress.html"><strong>BFT Autoresponder</strong></a> allows scheduling of automated autoresponder messages and managing a mailing list.</p>
<p><a href="http://wordpress.org/extend/plugins/google-analytics-dashboard-for-wp/"><strong>Google Analytics Dashboard for WP</strong></a> will display Google Analytics data and statistics inside your Dashboard.</p>
<p><a href="http://wordpress.org/extend/plugins/wordpress-mu-domain-mapping/"><strong>WordPress MU Domain Mapping</strong></a> allows users of a WordPress MU site or WordPress 3.0 network to map their blog/site to another domain.</p>
<img src="http://feeds.feedburner.com/~r/weblogtoolscollection/UXMP/~4/J5kgleppg3E" height="1" width="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 25 Mar 2013 18:03:16 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"James";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:38;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:28:"BuddyPress: BuddyPress 1.6.5";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:31:"http://buddypress.org/?p=157571";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:47:"http://buddypress.org/2013/03/buddypress-1-6-5/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:649:"<p><a href="http://wordpress.org/extend/plugins/buddypress/">BuddyPress 1.6.5</a> is now available. It&#8217;s the fifth minor release to the 1.6 branch, and is a recommended update for all previous versions of BuddyPress.</p>
<p>1.6.5 fixes 1 security issue potentially allowing access to the &#8216;delete-account&#8217; Settings screen for users that should not normally have that privilege. This bug was reported and researched by Rob Begic, and fixed by the BuddyPress core team.</p>
<p><a href="http://wordpress.org/extend/plugins/buddypress/">Download 1.6.5</a> or visit Dashboard &rarr; Updates in your administration area to update now.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 23 Mar 2013 20:53:15 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:17:"John James Jacoby";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:39;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:58:"Weblog Tools Collection: WordPress Theme Releases for 3/23";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"http://weblogtoolscollection.com/?p=12813";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"http://feedproxy.google.com/~r/weblogtoolscollection/UXMP/~3/RRyaMSkB1LI/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1260:"<p><a href="http://wordpress.org/extend/themes/memori-jingga"><img class="alignnone size-thumbnail wp-image-12814" alt="screenshot" src="http://i1.wp.com/weblogtoolscollection.com/wp-content/uploads/2013/03/screenshot5.png?resize=150%2C150" /></a></p>
<p><a href="http://wordpress.org/extend/themes/memori-jingga"><strong>Memori Jingga</strong></a> is a responsive, clean, and simple theme.</p>
<p><a href="http://wordpress.org/extend/themes/rockers"><img class="alignnone size-thumbnail wp-image-12815" alt="screenshot-1" src="http://i0.wp.com/weblogtoolscollection.com/wp-content/uploads/2013/03/screenshot-15.png?resize=150%2C150" /></a></p>
<p><a href="http://wordpress.org/extend/themes/rockers"><strong>Rockers</strong></a> is a responsive theme with a clean design.</p>
<p><a href="http://wordpress.org/extend/themes/satu"><img class="alignnone size-thumbnail wp-image-12816" alt="screenshot-2" src="http://i0.wp.com/weblogtoolscollection.com/wp-content/uploads/2013/03/screenshot-23.png?resize=150%2C150" /></a></p>
<p><a href="http://wordpress.org/extend/themes/satu"><strong>Satu</strong></a> is an elegant single-column responsive theme.</p>
<img src="http://feeds.feedburner.com/~r/weblogtoolscollection/UXMP/~4/RRyaMSkB1LI" height="1" width="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 23 Mar 2013 14:00:42 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"James";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:40;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:68:"Weblog Tools Collection: WordCamp San Francisco 2013 Dates Announced";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"http://weblogtoolscollection.com/?p=12807";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"http://feedproxy.google.com/~r/weblogtoolscollection/UXMP/~3/tdYxbhgsXyo/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:859:"<p>The dates <a href="http://2013.sf.wordcamp.org/2013/03/22/wordcamp-sf-2013-announcement/">have been announced</a> for <a href="http://2013.sf.wordcamp.org">WordCamp San Francisco 2013</a>, an event which is often heralded as the annual <a href="http://wordpress.org/">WordPress</a> conference.</p>
<p>WordCamp San Francisco 2013 will be held on July 26 and 27 at <a href="http://goo.gl/maps/rT6ou">the Mission Bay Conference Center</a> with a Developer Hack Day on July 28. A list of speakers is not yet available, but they would like you to <a href="http://wordcampcentral.polldaddy.com/s/best-2012-2013-wordcamp-speakers-so-far">nominate your favorite past WordCamp speakers</a>.</p>
<p>Will you be attending WordCamp San Francisco this year?</p>
<img src="http://feeds.feedburner.com/~r/weblogtoolscollection/UXMP/~4/tdYxbhgsXyo" height="1" width="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 23 Mar 2013 00:30:07 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"James";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:41;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:66:"WordPress.tv: Chris Lema: Says No Automatically (w/ Gravity Forms)";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18041";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:80:"http://wordpress.tv/2013/03/22/chris-lema-says-no-automatically-w-gravity-forms/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:692:"<div id="v-NF4VIeHi-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18041/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18041/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18041&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/03/22/chris-lema-says-no-automatically-w-gravity-forms/"><img alt="OCWP &#8211; Chris Lema &#8211; Recording on 2013-03-11.mp4" src="http://videos.videopress.com/NF4VIeHi/video-548cfa5139_scruberthumbnail_0.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 22 Mar 2013 19:45:08 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:42;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:59:"Weblog Tools Collection: WordPress Plugin Releases for 3/21";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"http://weblogtoolscollection.com/?p=12802";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"http://feedproxy.google.com/~r/weblogtoolscollection/UXMP/~3/0LUWJ6dWyoE/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1145:"<h3>New plugins</h3>
<p><a href="http://wordpress.org/extend/plugins/google-adsense-dashboard-for-wp/"><strong>Google Adsense Dashboard for WP</strong></a> will display your Google Adsense earnings and related reports inside your Dashboard.</p>
<p><a href="http://wordpress.org/extend/plugins/google-analytics-dashboard-for-wp/"><strong>Google Analytics Dashboard for WP</strong></a> will display Google Analytics data and statistics inside your Dashboard.</p>
<h3>Updated plugins</h3>
<p><a href="http://wordpress.org/extend/plugins/ad-code-manager/"><strong>Ad Code Manager</strong></a> allows you to manage your ad codes through the WordPress admin in a safe and easy way.</p>
<p><a href="http://calendarscripts.info/autoresponder-wordpress.html"><strong>BFT Autoresponder</strong></a> allows scheduling of automated autoresponder messages and managing a mailing list.</p>
<p><a href="http://wordpress.org/extend/plugins/camptix/"><strong>CampTix Event Ticketing</strong></a> is an easy to use and flexible event ticketing plugin.</p>
<img src="http://feeds.feedburner.com/~r/weblogtoolscollection/UXMP/~4/0LUWJ6dWyoE" height="1" width="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 21 Mar 2013 14:00:16 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"James";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:43;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:103:"WordPress.tv: Walter Dal Mut: WordPress incontra il Cloud Computing: Scalabilità ed Alta Disponiblità";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=17317";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:117:"http://wordpress.tv/2013/03/20/walter-dal-mut-wordpress-incontra-il-cloud-computing-scalabilita-ed-alta-disponiblita/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:710:"<div id="v-8DjnnEnW-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/17317/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/17317/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=17317&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/03/20/walter-dal-mut-wordpress-incontra-il-cloud-computing-scalabilita-ed-alta-disponiblita/"><img alt="02 Gabriele Mittica & Walter Dal Mut.mp4" src="http://videos.videopress.com/8DjnnEnW/video-5d332310a1_scruberthumbnail_2.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 21 Mar 2013 01:20:48 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:44;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:67:"Alex King: WordPress Maturity – An Interview with Me at WP Engine";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://alexking.org/?p=16267";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:88:"http://alexking.org/blog/2013/03/20/wordpress-maturity-an-interview-with-me-at-wp-engine";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:402:"<p>An <a href="http://wpengine.com/2013/03/alex-king-on-the-maturity-of-wordpress/">interview with me about WordPress&#8217;s maturity</a> is up on the WP Engine blog. It&#8217;s a bit of a long read (~4500 words), but <a href="http://www.austingunter.com/">Austin</a> did a great job asking good questions and follow-ups. I quite enjoyed the discussion and I hope you&#8217;ll find it interesting.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 20 Mar 2013 21:26:47 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Alex";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:45;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:58:"Weblog Tools Collection: WordPress Theme Releases for 3/19";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"http://weblogtoolscollection.com/?p=12792";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"http://feedproxy.google.com/~r/weblogtoolscollection/UXMP/~3/yiyrwU_8gQQ/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1378:"<p><a href="http://wordpress.org/extend/themes/cazuela"><img class="alignnone size-thumbnail wp-image-12793" alt="screenshot" src="http://i2.wp.com/weblogtoolscollection.com/wp-content/uploads/2013/03/screenshot4.png?resize=150%2C150" /></a></p>
<p><a href="http://wordpress.org/extend/themes/cazuela"><strong>Cazuela</strong></a> is a neutral colored theme.</p>
<p><a href="http://wordpress.org/extend/themes/ilisa"><img class="alignnone size-thumbnail wp-image-12795" alt="screenshot-1" src="http://i2.wp.com/weblogtoolscollection.com/wp-content/uploads/2013/03/screenshot-14.png?resize=150%2C150" /></a></p>
<p><a href="http://wordpress.org/extend/themes/ilisa"><strong>Ilisa</strong></a> is a clean and minimal theme that can be easily used as a personal portfolio or a business website.</p>
<p><a href="http://emptynestthemes.com/2013/03/18/partition-professional-wordpress-theme/"><img class="alignnone size-thumbnail wp-image-12794" alt="DemoBlog" src="http://i0.wp.com/weblogtoolscollection.com/wp-content/uploads/2013/03/DemoBlog3.png?resize=150%2C150" /></a></p>
<p><a href="http://emptynestthemes.com/2013/03/18/partition-professional-wordpress-theme/"><strong>Partition</strong></a> has a light, lively, colorful, yet professional and classic appearance.</p>
<img src="http://feeds.feedburner.com/~r/weblogtoolscollection/UXMP/~4/yiyrwU_8gQQ" height="1" width="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 19 Mar 2013 14:00:17 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"James";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:46;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"WordPress.tv: Noah Dyer: Growth";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=18187";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:48:"http://wordpress.tv/2013/03/18/noah-dyer-growth/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:612:"<div id="v-xvr1P7XJ-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/18187/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/18187/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=18187&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/03/18/noah-dyer-growth/"><img alt="Noah Dyer: Growth" src="http://videos.videopress.com/xvr1P7XJ/video-c774cda819_std.original.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 18 Mar 2013 20:29:35 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:47;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:70:"WordPress.tv: How to Install Jetpack Site Stats on your WordPress site";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=17936";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:88:"http://wordpress.tv/2013/03/18/how-to-install-jetpack-site-stats-on-your-wordpress-site/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:664:"<div id="v-0EUXgeTM-1" class="video-player">
</div>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/17936/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/17936/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=17936&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2013/03/18/how-to-install-jetpack-site-stats-on-your-wordpress-site/"><img alt="WSC-001-jetpack-analitics.mov" src="http://videos.videopress.com/0EUXgeTM/video-c95e94a6ba_std.original.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 18 Mar 2013 15:56:20 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:48;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:32:"WordPress.tv Blog: Get Involved!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"http://wptvblog.wordpress.com/?p=291";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:54:"http://wptvblog.wordpress.com/2013/03/18/get-involved/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1594:"<p>WordPress.tv is now open for video submissions from the WordPress community.</p>
<p>Do you record your WordPress meetup? <a href="http://wordpress.tv/submit-video/">Submit it to WordPress.tv!</a> Do you record WordPress screencast tutorials? <a href="http://wordpress.tv/submit-video/">Submit them to WordPress.tv!</a> Do you create some other form of WP video awesomesauce that would benefit the community? WordPress.tv might be just the place for it.</p>
<p>Fair warning: Our intrepid group of WordPress.tv event video moderators already works hard to review and publish WordCamp videos, and if WordPress.tv is suddenly flooded with video submissions, they may take a while to get around to reviewing and publishing your video. Please be patient as we iterate toward success&#8230; and if you&#8217;re interested in donating your time toward becoming a WordPress.tv moderator, please apply <a href="http://wordpress.tv/apply-to-be-a-wordpress-tv-moderator/">here</a>. If this takes off like we think it might, we will definitely need some extra eyes!</p>
<p>Thanks in advance for helping to make WordPress.tv an even more fantastic resource. If you have questions about this, please don&#8217;t hesitate to ask.</p>
<br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptvblog.wordpress.com/291/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptvblog.wordpress.com/291/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wptvblog.wordpress.com&blog=5310177&post=291&subd=wptvblog&ref=&feed=1" width="1" height="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 18 Mar 2013 08:57:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Andrea Middleton";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:49;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:29:"Alex King: Announcing Threads";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://alexking.org/?p=16176";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:54:"http://alexking.org/blog/2013/03/17/announcing-threads";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2417:".threads-post-notice {
	background: #e8e8e8;
	padding: 10px;
}
.threads-post-notice a {
	font-weight: bold;
}

<p><img src="http://alexking.org/wp-content/uploads/2013/03/threads-timeline-510x382.jpg" alt="threads-timeline" width="480" height="359" class="aligncenter size-medium-img wp-image-16181" /></p>
<p>I&#8217;ve just released an initial beta of <a href="http://wordpress.org/extend/plugins/threads/">Threads</a>, a WordPress plugin I&#8217;ve been working on for about a year. The idea is simple: show posts that comprise a single overall story/topic in a timeline. Then link to that timeline from the posts so that your readers have a chance to get more historical context about a post without you having to link back to 20 previous posts.</p>
<p>Here are some example threads:</p>
<ul>
<li><a href="http://alexking.org/blog/thread/social">Social</a></li>
<li><a href="http://alexking.org/blog/thread/hard-drive-recovery">My Hard Drive Recovery Saga</a></li>
<li><a href="http://alexking.org/blog/thread/twitter-tools">Twitter Tools</a></li>
<li><a href="http://alexking.org/blog/thread/passwords">Passwords</a></li>
<li><a href="http://alexking.org/blog/thread/weight-loss">Weight Loss</a></li>
</ul>
<p>As you can see on this site, the thread timeline is responsive and retina/HiDPI ready. Also included is a sidebar widget to show recently active threads and a shortcode so that you can embed a thread timeline in a page.</p>
<p>Give it a spin &#8211; I hope it works out well for you!</p>
<p>A quick note about support: As this is a free plugin released under the GPL I am offering only &#8220;Product Support&#8221; for this plugin. That means I will do my best to fix bugs and usabiity issues that are posted on the <a href="http://wordpress.org/support/">WordPress support forums</a>. Contrast this with &#8220;User Support&#8221; which we offer for all of <a href="http://crowdfavorite.com">Crowd Favorite</a>&#8216;s commercial products. With &#8220;User Support&#8221; we do our best to troubleshoot and address each customer&#8217;s issues.</p>
<p>Developers, contributions are welcome on <a href="https://github.com/crowdfavorite/wp-threads">GitHub</a>.</p>
<p class="threads-post-notice">This post is part of the thread: <a href="http://alexking.org/blog/thread/content">Content Presentation</a> &#8211; an ongoing story on this site. View the thread timeline for more context on this post.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sun, 17 Mar 2013 21:35:55 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Alex";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";a:9:{s:6:"server";s:5:"nginx";s:4:"date";s:29:"Thu, 18 Apr 2013 19:19:43 GMT";s:12:"content-type";s:8:"text/xml";s:14:"content-length";s:6:"118995";s:10:"connection";s:5:"close";s:4:"vary";s:15:"Accept-Encoding";s:13:"last-modified";s:29:"Thu, 18 Apr 2013 19:15:26 GMT";s:4:"x-nc";s:11:"HIT luv 138";s:13:"accept-ranges";s:5:"bytes";}s:5:"build";s:14:"20121202214312";}', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (238, '_transient_timeout_feed_mod_867bd5c64f85878d03a060509cd2f92c', '1366355983', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (239, '_transient_feed_mod_867bd5c64f85878d03a060509cd2f92c', '1366312783', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (240, '_transient_timeout_dash_aa95765b5cc111c56d5993d476b1c2f0', '1366355983', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (241, '_transient_dash_aa95765b5cc111c56d5993d476b1c2f0', '<div class="rss-widget"><ul><li><a class=\'rsswidget\' href=\'http://wordpress.tv/2013/04/17/erick-arbe-wordpress-navigation-in-responsive-design/\' title=\' [&hellip;]\'>WordPress.tv: Erick Arbe: WordPress Navigation in Responsive Design</a></li><li><a class=\'rsswidget\' href=\'http://android.wordpress.org/2013/04/17/2-3-release/\' title=\'Today, we’ve jubilantly released version 2.3 of WordPress for Android to Google Play. After updating, you’ll see right away that this release includes very exciting updates to the user interface. Let’s dive in to what’s new! Action Bar You’ll notice a fresh, new look. We’ve taken into account Android’s “Holo” style guidelines and implemented the Action Bar i [&hellip;]\'>WP Android: Version 2.3 is Here: New User Interface and More</a></li><li><a class=\'rsswidget\' href=\'http://alexking.org/blog/2013/04/17/scared-straight\' title=\'.threads-post-notice { background: #e8e8e8; padding: 10px; } .threads-post-notice a { font-weight: bold; } I woke up to a bit of a scare when some of my alexking.org Gmail accounts were unable to log in to Gmail. I was afraid the accounts had been compromised and the passwords changed. I had secure passwords, but had been lazy about turning on 2-factor authe [&hellip;]\'>Alex King: Scared Straight</a></li><li><a class=\'rsswidget\' href=\'http://ma.tt/2013/04/dave-keeps-working/\' title=\'Dave Winer tweeted this on Saturday: I have a little spare time today so I decided to start on River3. It’ll be much much smaller and more focused than River2. — Dave Winer ? (@davewiner) April 13, 2013 One of the things I love and admire about him is that many, many years after he doesn’t have to anymore he’s still learning, hacking, and taking free time on [&hellip;]\'>Matt: Dave Keeps Working</a></li><li><a class=\'rsswidget\' href=\'http://alexking.org/blog/2013/04/15/16482\' title=\'Any icon artists out there interested in creating an application icon for a free (GPL) WordPress-based app that @crowdfavorite is working on? [&hellip;]\'>Alex King: Any icon artists out there interested in creating …</a></li></ul></div>', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (242, '_transient_timeout_feed_a5420c83891a9c88ad2a4f04584a5efc', '1366355984', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (243, '_transient_feed_a5420c83891a9c88ad2a4f04584a5efc', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"
	
";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:72:"
		
		
		
		
		
		
				

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

	";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:39:"WordPress Plugins » View: Most Popular";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:51:"http://wordpress.org/extend/plugins/browse/popular/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:39:"WordPress Plugins » View: Most Popular";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:5:"en-US";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 18 Apr 2013 19:03:42 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"generator";a:1:{i:0;a:5:{s:4:"data";s:25:"http://bbpress.org/?v=1.1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:15:{i:0;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:14:"Contact Form 7";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:61:"http://wordpress.org/extend/plugins/contact-form-7/#post-2141";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 02 Aug 2007 12:45:03 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"2141@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:54:"Just another contact form plugin. Simple but flexible.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Takayuki Miyoshi";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"WordPress SEO by Yoast";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:60:"http://wordpress.org/extend/plugins/wordpress-seo/#post-8321";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 01 Jan 2009 20:34:44 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"8321@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:131:"Improve your WordPress SEO: Write better content and have a fully optimized WordPress site using the WordPress SEO plugin by Yoast.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Joost de Valk";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:24:"Jetpack by WordPress.com";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/extend/plugins/jetpack/#post-23862";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 20 Jan 2011 02:21:38 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"23862@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:104:"Supercharge your WordPress site with powerful features previously only available to WordPress.com users.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:24:"Michael Adams (mdawaffe)";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:18:"WordPress Importer";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:66:"http://wordpress.org/extend/plugins/wordpress-importer/#post-18101";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 20 May 2010 17:42:45 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"18101@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:101:"Import posts, pages, comments, custom fields, categories, tags and more from a WordPress export file.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Brian Colinger";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:14:"WP Super Cache";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:61:"http://wordpress.org/extend/plugins/wp-super-cache/#post-2572";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 05 Nov 2007 11:40:04 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"2572@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:73:"A very fast caching engine for WordPress that produces static html files.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Donncha O Caoimh";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:7:"Akismet";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:52:"http://wordpress.org/extend/plugins/akismet/#post-15";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 09 Mar 2007 22:11:30 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:39:"15@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:98:"Akismet checks your comments against the Akismet web service to see if they look like spam or not.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Matt Mullenweg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:30:"Google Analytics for WordPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:77:"http://wordpress.org/extend/plugins/google-analytics-for-wordpress/#post-2316";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 14 Sep 2007 12:15:27 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"2316@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:145:"Track your WordPress site easily and with lots of metadata: views per author &#38; category, automatic tracking of outbound clicks and pageviews.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Joost de Valk";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:19:"Google XML Sitemaps";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:70:"http://wordpress.org/extend/plugins/google-sitemap-generator/#post-132";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 09 Mar 2007 22:31:32 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:40:"132@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:105:"This plugin will generate a special XML sitemap which will help search engines to better index your blog.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"arnee";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:19:"All in One SEO Pack";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:65:"http://wordpress.org/extend/plugins/all-in-one-seo-pack/#post-753";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 30 Mar 2007 20:08:18 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:40:"753@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:86:"WordPress SEO plugin to automatically optimize your Wordpress blog for Search Engines.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"uberdose";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:14:"W3 Total Cache";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:62:"http://wordpress.org/extend/plugins/w3-total-cache/#post-12073";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 29 Jul 2009 18:46:31 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"12073@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:132:"Easy Web Performance Optimization (WPO) using caching: browser, page, object, database, minify and content delivery network support.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Frederick Townes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:10;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:19:"Social Media Widget";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:67:"http://wordpress.org/extend/plugins/social-media-widget/#post-18183";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 25 May 2010 02:22:34 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"18183@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:129:"Adds links to all of your social media and sharing site profiles. Tons of icons come in 3 sizes, 4 icon styles, and 4 animations.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:17:"Blink Web Effects";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:11;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:33:"WooCommerce - excelling eCommerce";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:59:"http://wordpress.org/extend/plugins/woocommerce/#post-29860";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 05 Sep 2011 08:13:36 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"29860@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:97:"WooCommerce is a powerful, extendable eCommerce plugin that helps you sell anything. Beautifully.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:9:"WooThemes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:12;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:15:"NextGEN Gallery";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:62:"http://wordpress.org/extend/plugins/nextgen-gallery/#post-1169";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 23 Apr 2007 20:08:06 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:41:"1169@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:120:"The most popular WordPress gallery plugin and one of the most popular plugins of all time with over 6 million downloads.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:9:"Alex Rabe";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:13;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:16:"Ultimate TinyMCE";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:64:"http://wordpress.org/extend/plugins/ultimate-tinymce/#post-32088";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 14 Nov 2011 09:06:40 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"32088@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:84:"Description: Beef up your visual tinymce editor with a plethora of advanced options.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Josh";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:14;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:18:"Better WP Security";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:66:"http://wordpress.org/extend/plugins/better-wp-security/#post-21738";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 22 Oct 2010 22:06:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"21738@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:107:"The easiest, most effective way to secure WordPress. Improve the security of any WordPress site in seconds.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"ChrisWiegman";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}s:27:"http://www.w3.org/2005/Atom";a:1:{s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:3:{s:4:"href";s:52:"http://wordpress.org/extend/plugins/rss/view/popular";s:3:"rel";s:4:"self";s:4:"type";s:19:"application/rss+xml";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";a:10:{s:6:"server";s:5:"nginx";s:4:"date";s:29:"Thu, 18 Apr 2013 19:19:43 GMT";s:12:"content-type";s:23:"text/xml; charset=UTF-8";s:10:"connection";s:5:"close";s:4:"vary";s:15:"Accept-Encoding";s:7:"expires";s:29:"Thu, 18 Apr 2013 19:38:42 GMT";s:13:"cache-control";s:0:"";s:6:"pragma";s:0:"";s:13:"last-modified";s:31:"Thu, 18 Apr 2013 19:03:42 +0000";s:4:"x-nc";s:11:"HIT luv 138";}s:5:"build";s:14:"20121202214312";}', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (244, '_transient_timeout_feed_mod_a5420c83891a9c88ad2a4f04584a5efc', '1366355984', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (245, '_transient_feed_mod_a5420c83891a9c88ad2a4f04584a5efc', '1366312784', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (246, '_transient_timeout_feed_57bc725ad6568758915363af670fd8bc', '1366355984', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (247, '_transient_feed_57bc725ad6568758915363af670fd8bc', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"
	
";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:72:"
		
		
		
		
		
		
				

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

	";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:33:"WordPress Plugins » View: Newest";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:47:"http://wordpress.org/extend/plugins/browse/new/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:33:"WordPress Plugins » View: Newest";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:5:"en-US";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 18 Apr 2013 19:16:51 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"generator";a:1:{i:0;a:5:{s:4:"data";s:25:"http://bbpress.org/?v=1.1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:15:{i:0;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:23:"Featured Podcast Widget";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:71:"http://wordpress.org/extend/plugins/featured-podcast-widget/#post-52172";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 17 Apr 2013 15:38:54 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52172@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:147:"A widget that enables you to display your latest podcast from a category or featured podcast utilising the PowerPress plugin&#039;s default player.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Richard Farrar";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:26:"Publicly Submitted Content";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:74:"http://wordpress.org/extend/plugins/publicly-submitted-content/#post-52170";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 17 Apr 2013 14:45:51 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52170@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:81:"Allow the public to submit information to your site and then you can moderate it.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"Walker Hamilton";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:19:"WP Expire Passwords";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:67:"http://wordpress.org/extend/plugins/wp-expire-passwords/#post-52176";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 17 Apr 2013 18:58:40 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52176@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:106:"This plugin allows you to set passwords to expire every X amount of days and to expire all user passwords.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"rob.divincenzo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"Express Partage Facebook Button";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:79:"http://wordpress.org/extend/plugins/express-partage-facebook-button/#post-52164";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 17 Apr 2013 11:02:37 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52164@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:104:"Here is a short description of the plugin.  This should be no more than 150 characters.  No markup here.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"hosni";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:28:"ABD Dashboard Widget Manager";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:76:"http://wordpress.org/extend/plugins/abd-dashboard-widget-manager/#post-51595";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 05 Apr 2013 04:04:46 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"51595@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:150:"This plugin gives you an easy way to customize your WordPress administrator dashboard. Simply select which admin widgets you&#039;d like to show and f";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"abdwebdesign";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:18:"WP Restaurant Menu";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:66:"http://wordpress.org/extend/plugins/wp-restaurant-menu/#post-52118";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 16 Apr 2013 18:01:01 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52118@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:104:"Using the restaurant menu plugin you can create menus for food, drink or products on any Wordpress page.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Picobarn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:19:"Custom Field Finder";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:67:"http://wordpress.org/extend/plugins/custom-field-finder/#post-52216";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 18 Apr 2013 11:03:08 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52216@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:136:"Allows you to easily find the custom fields (including hidden custom fields) and their values for a post, page or custom post type post.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Joost de Valk";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:14:"Simnor Widgets";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:62:"http://wordpress.org/extend/plugins/simnor-widgets/#post-52168";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 17 Apr 2013 13:28:58 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52168@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:130:"Simnor Widgets a selection of widgets to use on your site including twitter, dribbble, latest posts, social links and author list.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:6:"simnor";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:17:"Request Call Back";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:65:"http://wordpress.org/extend/plugins/request-call-back/#post-52145";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 16 Apr 2013 23:39:23 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52145@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:148:"Adds a simple, configurable request call back button to your site. Visitors can provide their name and number via lightbox or embedded request form.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"Scott Salisbury";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:12:"Klipspringer";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:60:"http://wordpress.org/extend/plugins/klipspringer/#post-51974";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 13 Apr 2013 06:05:39 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"51974@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:146:"A slide-down widgetized area for your WordPress website which can be used for anything from shopping carts to a contact form to displaying tweets.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:7:"stacigh";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:10;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:18:"Personal Chat room";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:66:"http://wordpress.org/extend/plugins/personal-chat-room/#post-52153";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 17 Apr 2013 04:02:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52153@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:128:"Personal chat room adds a button to chat live from your website, for that your customers have to just join with this application";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:9:"lordlinus";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:11;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:28:"Link Maggu Monetization Tool";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:76:"http://wordpress.org/extend/plugins/link-maggu-monetization-tool/#post-52163";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 17 Apr 2013 10:51:11 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52163@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:150:"This plugin will help you monetize your website through affiliates and advertisers. LinkMaggu Plugin is based on popular external link BWP External Li";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"webmaggu";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:12;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"E-mailing Subscription";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:65:"http://wordpress.org/extend/plugins/email-suscripcion/#post-52112";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 16 Apr 2013 16:24:26 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52112@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:58:"A simple WordPress plugin for e-mailing subscription list.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:9:"seballero";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:13;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:21:"WP Category Permalink";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:69:"http://wordpress.org/extend/plugins/wp-category-permalink/#post-52155";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 17 Apr 2013 06:57:26 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52155@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:99:"Allows manual selection of a &#039;main&#039; category for each post for better permalinks and SEO.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:10:"Jordy Meow";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:14;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:25:"3dady real-time web stats";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:73:"http://wordpress.org/extend/plugins/3dady-real-time-web-stats/#post-52194";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 17 Apr 2013 21:16:25 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:42:"52194@http://wordpress.org/extend/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:46:"Hit Counter Sidebar widget/real-time web stats";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"3dady";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}s:27:"http://www.w3.org/2005/Atom";a:1:{s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:3:{s:4:"href";s:48:"http://wordpress.org/extend/plugins/rss/view/new";s:3:"rel";s:4:"self";s:4:"type";s:19:"application/rss+xml";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";a:7:{s:6:"server";s:5:"nginx";s:4:"date";s:29:"Thu, 18 Apr 2013 19:19:44 GMT";s:12:"content-type";s:23:"text/xml; charset=UTF-8";s:10:"connection";s:5:"close";s:4:"vary";s:15:"Accept-Encoding";s:13:"last-modified";s:29:"Wed, 17 Apr 2013 15:38:54 GMT";s:4:"x-nc";s:11:"HIT luv 138";}s:5:"build";s:14:"20121202214312";}', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (248, '_transient_timeout_feed_mod_57bc725ad6568758915363af670fd8bc', '1366355984', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (249, '_transient_feed_mod_57bc725ad6568758915363af670fd8bc', '1366312784', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (250, '_transient_timeout_plugin_slugs', '1366399184', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (251, '_transient_plugin_slugs', 'a:5:{i:0;s:30:"advanced-custom-fields/acf.php";i:1;s:19:"akismet/akismet.php";i:2;s:26:"backupwordpress/plugin.php";i:3;s:43:"custom-post-type-ui/custom-post-type-ui.php";i:4;s:9:"hello.php";}', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (252, '_transient_timeout_dash_de3249c4736ad3bd2cd29147c4a0d43e', '1366355984', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (253, '_transient_dash_de3249c4736ad3bd2cd29147c4a0d43e', '<h4>Most Popular</h4>
<h5><a href=\'http://wordpress.org/extend/plugins/better-wp-security/\'>Better WP Security</a></h5>&nbsp;<span>(<a href=\'plugin-install.php?tab=plugin-information&amp;plugin=better-wp-security&amp;_wpnonce=91d1a4fee0&amp;TB_iframe=true&amp;width=600&amp;height=800\' class=\'thickbox\' title=\'Better WP Security\'>Install</a>)</span>
<p>The easiest, most effective way to secure WordPress. Improve the security of any WordPress site in seconds.</p>
<h4>Newest Plugins</h4>
<h5><a href=\'http://wordpress.org/extend/plugins/wp-expire-passwords/\'>WP Expire Passwords</a></h5>&nbsp;<span>(<a href=\'plugin-install.php?tab=plugin-information&amp;plugin=wp-expire-passwords&amp;_wpnonce=3519bc51a5&amp;TB_iframe=true&amp;width=600&amp;height=800\' class=\'thickbox\' title=\'WP Expire Passwords\'>Install</a>)</span>
<p>This plugin allows you to set passwords to expire every X amount of days and to expire all user passwords.</p>
', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (254, '_site_transient_timeout_wporg_theme_feature_list', '1366324403', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (255, '_site_transient_wporg_theme_feature_list', 'a:5:{s:6:"Colors";a:15:{i:0;s:5:"black";i:1;s:4:"blue";i:2;s:5:"brown";i:3;s:4:"gray";i:4;s:5:"green";i:5;s:6:"orange";i:6;s:4:"pink";i:7;s:6:"purple";i:8;s:3:"red";i:9;s:6:"silver";i:10;s:3:"tan";i:11;s:5:"white";i:12;s:6:"yellow";i:13;s:4:"dark";i:14;s:5:"light";}s:7:"Columns";a:6:{i:0;s:10:"one-column";i:1;s:11:"two-columns";i:2;s:13:"three-columns";i:3;s:12:"four-columns";i:4;s:12:"left-sidebar";i:5;s:13:"right-sidebar";}s:5:"Width";a:2:{i:0;s:11:"fixed-width";i:1;s:14:"flexible-width";}s:8:"Features";a:19:{i:0;s:8:"blavatar";i:1;s:10:"buddypress";i:2;s:17:"custom-background";i:3;s:13:"custom-colors";i:4;s:13:"custom-header";i:5;s:11:"custom-menu";i:6;s:12:"editor-style";i:7;s:21:"featured-image-header";i:8;s:15:"featured-images";i:9;s:15:"flexible-header";i:10;s:20:"front-page-post-form";i:11;s:19:"full-width-template";i:12;s:12:"microformats";i:13;s:12:"post-formats";i:14;s:20:"rtl-language-support";i:15;s:11:"sticky-post";i:16;s:13:"theme-options";i:17;s:17:"threaded-comments";i:18;s:17:"translation-ready";}s:7:"Subject";a:3:{i:0;s:7:"holiday";i:1;s:13:"photoblogging";i:2;s:8:"seasonal";}}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (256, 'rewrite_rules', 'a:101:{s:47:"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:52:"index.php?category_name=$matches[1]&feed=$matches[2]";s:42:"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$";s:52:"index.php?category_name=$matches[1]&feed=$matches[2]";s:35:"category/(.+?)/page/?([0-9]{1,})/?$";s:53:"index.php?category_name=$matches[1]&paged=$matches[2]";s:17:"category/(.+?)/?$";s:35:"index.php?category_name=$matches[1]";s:44:"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?tag=$matches[1]&feed=$matches[2]";s:39:"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?tag=$matches[1]&feed=$matches[2]";s:32:"tag/([^/]+)/page/?([0-9]{1,})/?$";s:43:"index.php?tag=$matches[1]&paged=$matches[2]";s:14:"tag/([^/]+)/?$";s:25:"index.php?tag=$matches[1]";s:45:"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?post_format=$matches[1]&feed=$matches[2]";s:40:"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?post_format=$matches[1]&feed=$matches[2]";s:33:"type/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?post_format=$matches[1]&paged=$matches[2]";s:15:"type/([^/]+)/?$";s:33:"index.php?post_format=$matches[1]";s:32:"work/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:42:"work/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:62:"work/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:57:"work/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:57:"work/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:25:"work/([^/]+)/trackback/?$";s:31:"index.php?work=$matches[1]&tb=1";s:45:"work/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?work=$matches[1]&feed=$matches[2]";s:40:"work/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?work=$matches[1]&feed=$matches[2]";s:33:"work/([^/]+)/page/?([0-9]{1,})/?$";s:44:"index.php?work=$matches[1]&paged=$matches[2]";s:40:"work/([^/]+)/comment-page-([0-9]{1,})/?$";s:44:"index.php?work=$matches[1]&cpage=$matches[2]";s:25:"work/([^/]+)(/[0-9]+)?/?$";s:43:"index.php?work=$matches[1]&page=$matches[2]";s:21:"work/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:31:"work/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:51:"work/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:46:"work/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:46:"work/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:40:"testimonials/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:50:"testimonials/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:70:"testimonials/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:65:"testimonials/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:65:"testimonials/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:33:"testimonials/([^/]+)/trackback/?$";s:39:"index.php?testimonials=$matches[1]&tb=1";s:53:"testimonials/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:51:"index.php?testimonials=$matches[1]&feed=$matches[2]";s:48:"testimonials/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:51:"index.php?testimonials=$matches[1]&feed=$matches[2]";s:41:"testimonials/([^/]+)/page/?([0-9]{1,})/?$";s:52:"index.php?testimonials=$matches[1]&paged=$matches[2]";s:48:"testimonials/([^/]+)/comment-page-([0-9]{1,})/?$";s:52:"index.php?testimonials=$matches[1]&cpage=$matches[2]";s:33:"testimonials/([^/]+)(/[0-9]+)?/?$";s:51:"index.php?testimonials=$matches[1]&page=$matches[2]";s:29:"testimonials/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:39:"testimonials/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:59:"testimonials/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:54:"testimonials/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:54:"testimonials/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:48:".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$";s:18:"index.php?feed=old";s:20:".*wp-app\\.php(/.*)?$";s:19:"index.php?error=403";s:18:".*wp-register.php$";s:23:"index.php?register=true";s:32:"feed/(feed|rdf|rss|rss2|atom)/?$";s:27:"index.php?&feed=$matches[1]";s:27:"(feed|rdf|rss|rss2|atom)/?$";s:27:"index.php?&feed=$matches[1]";s:20:"page/?([0-9]{1,})/?$";s:28:"index.php?&paged=$matches[1]";s:27:"comment-page-([0-9]{1,})/?$";s:38:"index.php?&page_id=6&cpage=$matches[1]";s:41:"comments/feed/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?&feed=$matches[1]&withcomments=1";s:36:"comments/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?&feed=$matches[1]&withcomments=1";s:29:"comments/page/?([0-9]{1,})/?$";s:28:"index.php?&paged=$matches[1]";s:44:"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:40:"index.php?s=$matches[1]&feed=$matches[2]";s:39:"search/(.+)/(feed|rdf|rss|rss2|atom)/?$";s:40:"index.php?s=$matches[1]&feed=$matches[2]";s:32:"search/(.+)/page/?([0-9]{1,})/?$";s:41:"index.php?s=$matches[1]&paged=$matches[2]";s:14:"search/(.+)/?$";s:23:"index.php?s=$matches[1]";s:47:"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?author_name=$matches[1]&feed=$matches[2]";s:42:"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?author_name=$matches[1]&feed=$matches[2]";s:35:"author/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?author_name=$matches[1]&paged=$matches[2]";s:17:"author/([^/]+)/?$";s:33:"index.php?author_name=$matches[1]";s:69:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$";s:80:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]";s:64:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$";s:80:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]";s:57:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$";s:81:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]";s:39:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$";s:63:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]";s:56:"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$";s:64:"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]";s:51:"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$";s:64:"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]";s:44:"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$";s:65:"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]";s:26:"([0-9]{4})/([0-9]{1,2})/?$";s:47:"index.php?year=$matches[1]&monthnum=$matches[2]";s:43:"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?year=$matches[1]&feed=$matches[2]";s:38:"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?year=$matches[1]&feed=$matches[2]";s:31:"([0-9]{4})/page/?([0-9]{1,})/?$";s:44:"index.php?year=$matches[1]&paged=$matches[2]";s:13:"([0-9]{4})/?$";s:26:"index.php?year=$matches[1]";s:27:".?.+?/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:37:".?.+?/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:57:".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:20:"(.?.+?)/trackback/?$";s:35:"index.php?pagename=$matches[1]&tb=1";s:40:"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?pagename=$matches[1]&feed=$matches[2]";s:35:"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?pagename=$matches[1]&feed=$matches[2]";s:28:"(.?.+?)/page/?([0-9]{1,})/?$";s:48:"index.php?pagename=$matches[1]&paged=$matches[2]";s:35:"(.?.+?)/comment-page-([0-9]{1,})/?$";s:48:"index.php?pagename=$matches[1]&cpage=$matches[2]";s:20:"(.?.+?)(/[0-9]+)?/?$";s:47:"index.php?pagename=$matches[1]&page=$matches[2]";s:27:"[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:37:"[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:57:"[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:"[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:"[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:20:"([^/]+)/trackback/?$";s:31:"index.php?name=$matches[1]&tb=1";s:40:"([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?name=$matches[1]&feed=$matches[2]";s:35:"([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?name=$matches[1]&feed=$matches[2]";s:28:"([^/]+)/page/?([0-9]{1,})/?$";s:44:"index.php?name=$matches[1]&paged=$matches[2]";s:35:"([^/]+)/comment-page-([0-9]{1,})/?$";s:44:"index.php?name=$matches[1]&cpage=$matches[2]";s:20:"([^/]+)(/[0-9]+)?/?$";s:43:"index.php?name=$matches[1]&page=$matches[2]";s:16:"[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:26:"[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:46:"[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:41:"[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:41:"[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (257, '_site_transient_update_plugins', 'O:8:"stdClass":1:{s:12:"last_checked";i:1366313599;}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (258, 'nav_menu_options', 'a:2:{i:0;b:0;s:8:"auto_add";a:0:{}}', 'yes') ; 
INSERT INTO `wpWPP_options` VALUES (259, '_transient_timeout_hmbkp_plugin_data', '1366401392', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (260, '_transient_hmbkp_plugin_data', 'O:8:"stdClass":18:{s:4:"name";s:15:"BackUpWordPress";s:4:"slug";s:15:"backupwordpress";s:7:"version";s:5:"2.2.4";s:6:"author";s:47:"<a href="http://hmn.md/">Human Made Limited</a>";s:14:"author_profile";s:37:"http://profiles.wordpress.org/willmot";s:12:"contributors";a:6:{s:9:"humanmade";s:39:"http://profiles.wordpress.org/humanmade";s:8:"joehoyle";s:38:"http://profiles.wordpress.org/joehoyle";s:7:"mattheu";s:37:"http://profiles.wordpress.org/mattheu";s:9:"tcrsavage";s:39:"http://profiles.wordpress.org/tcrsavage";s:7:"willmot";s:37:"http://profiles.wordpress.org/willmot";s:8:"cuvelier";s:0:"";}s:8:"requires";s:5:"3.3.3";s:6:"tested";s:5:"3.5.1";s:13:"compatibility";a:1:{s:5:"3.5.1";a:4:{s:5:"2.1.3";a:3:{i:0;i:86;i:1;i:7;i:2;i:6;}s:3:"2.2";a:3:{i:0;i:100;i:1;i:1;i:2;i:1;}s:5:"2.2.1";a:3:{i:0;i:100;i:1;i:10;i:2;i:10;}s:5:"2.2.4";a:3:{i:0;i:75;i:1;i:4;i:2;i:3;}}}s:6:"rating";d:88;s:11:"num_ratings";i:358;s:10:"downloaded";i:549832;s:12:"last_updated";s:10:"2013-03-26";s:5:"added";s:10:"2007-09-02";s:8:"homepage";s:30:"http://hmn.md/backupwordpress/";s:8:"sections";a:5:{s:11:"description";s:1284:"<p>BackUpWordPress will back up your entire site including your database and all your files on a schedule that suits you.</p>

<h4>Features</h4>

<ul>
<li>Manage multiple schedules.</li>
<li>Super simple to use, no setup required.</li>
<li>Uses <code>zip</code> and <code>mysqldump</code> for faster back ups if they are available.</li>
<li>Works in low memory, "shared host" environments.</li>
<li>Option to have each backup file emailed to you.</li>
<li>Works on Linux &#38; Windows Server.</li>
<li>Exclude files and folders from your back ups.</li>
<li>Good support should you need help.</li>
<li>Translations for Spanish, German, Chinese, Romanian, Russian, Serbian, Lithuanian, Italian, Czech, Dutch, French, Basque.</li>
</ul>

<h4>Help develop this plugin</h4>

<p>The BackUpWordPress plugin is hosted GitHub, if you want to help out with development or testing then head over to <a href="https://github.com/humanmade/backupwordpress/" rel="nofollow">https://github.com/humanmade/backupwordpress/</a>.</p>

<h4>Translations</h4>

<p>We\'d also love help translating the plugin into more languages, if you can help then please contact <a href="mailto:support@hmn.md">support@hmn.md</a> or visit <a href="http://translate.hmn.md/" rel="nofollow">http://translate.hmn.md/</a>.</p>";s:12:"installation";s:460:"<ol>
<li>Install BackUpWordPress either via the WordPress.org plugin directory, or by uploading the files to your server.</li>
<li>Activate the plugin.</li>
<li>Sit back and relax safe in the knowledge that your whole site will be backed up every day.</li>
</ol>

<p>The plugin will try to use the <code>mysqldump</code> and <code>zip</code> commands via shell if they are available, using these will greatly improve the time it takes to back up your site.</p>";s:11:"screenshots";s:765:"<ol>
	<li>
		<img class=\'screenshot\' src=\'http://s-plugins.wordpress.org/backupwordpress/assets/screenshot-1.png?rev=602026\' alt=\'backupwordpress screenshot 1\' />
		<p>Manage multiple schedules.</p>
	</li>
	<li>
		<img class=\'screenshot\' src=\'http://s-plugins.wordpress.org/backupwordpress/assets/screenshot-2.png?rev=602026\' alt=\'backupwordpress screenshot 2\' />
		<p>Choose your schedule, backup type, number of backups to keep and whether to recieve a notification email.</p>
	</li>
	<li>
		<img class=\'screenshot\' src=\'http://s-plugins.wordpress.org/backupwordpress/assets/screenshot-3.png?rev=602026\' alt=\'backupwordpress screenshot 3\' />
		<p>Easily manage exclude rules and see exactly which files are included and excluded from your backup.</p>
	</li>
</ol>";s:9:"changelog";s:24214:"<h4>2.2.4</h4>

<ul>
<li>Fix a fatal error on PHP 5.2, sorry! (again.)</li>
</ul>

<h4>2.2.3</h4>

<ul>
<li>Fix a parse error, sorry!</li>
</ul>

<h4>2.2.2</h4>

<ul>
<li>Fix a fatal error when uninstalling.</li>
<li>Updated translations for Brazilian, French, Danish, Spanish, Czech, Slovakian, Polish, Italian, German, Latvian, Hebrew, Chinese &#38; Dutch.</li>
<li>Fix a possible notice when using the plugin on a server without internet access.</li>
<li>Don\'t show the wp-cron error message when <code>WP_USE_ALTERNATE_CRON</code> is defined as true.</li>
<li>Ability to override the max attachment size for email notifications using the new <code>HMBKP_MAX_ATTACHMENT_SIZE</code> constant.</li>
<li>Nonce some ajax request.</li>
<li>Silence warnings created if <code>is_executable</code>, <code>escapeshellcmd</code> or <code>escapeshellarg</code> are disabled.</li>
<li>Handle situations where the mysql port is set to something wierd.</li>
<li>Fallback to <code>mysql_connect</code> on system that disable <code>mysql_pconnect</code>.</li>
<li>You can now force the <code>--single-transaction</code> param when using <code>mysqldump</code> by defining <code>HMBKP_MYSQLDUMP_SINGLE_TRANSACTION</code>. </li>
<li>Unit tests for <code>HM_Backup::is_safe_mode_available()</code>.</li>
<li>Silence possible PHP Warnings when unlinking files.</li>
</ul>

<h4>2.2.1</h4>

<ul>
<li>Stop storing a list of unreadable files in the backup warnings as it\'s too memory intensive.</li>
<li>Revert the custom <code>RecursiveDirectoryIterator</code> as it caused an infinite loop on some servers.</li>
<li>Show all errors and warnings in the popup shown when a manual backup completes.</li>
<li>Write the .backup_error and .backup_warning files everytime an error or warning happens instead of waiting until the end of the backups process.</li>
<li>Fix a couple of <code>PHP E_STRICT</code> notices.</li>
<li>Catch more errors during the manual backup process and expose them to the user.</li>
</ul>

<h4>2.2</h4>

<ul>
<li>Don\'t repeatedly try to create the backups directory in the <code>uploads</code> if <code>uploads</code> isn\'t writable.</li>
<li>Show the correct path in the warning message when the backups path can\'t be created.</li>
<li>Include any user defined auth keys and salts when generating the HMBKP_SECRET_KEY.</li>
<li>Stop relying on the built in WordPress schedules as other plugins can mess with them.</li>
<li>Delete old backups everytime the backups page is viewed in an attempt to ensure old backups are always cleaned up.</li>
<li>Improve modals on small screens and mobile devices.</li>
<li>Use the retina spinner on retina screens.</li>
<li>Update buttons to the new 3.5 style.</li>
<li>Fix a possible fatal error caused when a symlink points to a location that is outside an <code>open_basedir</code> restriction.</li>
<li>Fix an issue that could cause backups using PclZip with a custom backups path to fail.</li>
<li>Security hardening by improving escaping, sanitizitation and validation.</li>
<li>Increase the timeout on the ajax cron check, should fix issues with cron errors showing on slow sites.</li>
<li>Only clear the cached backup filesize if the backup type changes.</li>
<li>Add unit tests for all the schedule recurrences.</li>
<li>Fix an issue which could cause weekly and monthly schedules to fail.</li>
<li>Add an <code>uninstall.php</code> file which removes all BackUpWordPress data and options.</li>
<li>Catch a possible fatal error in <code>RecursiveDirectoryIterator::hasChildren</code>.</li>
<li>Fix an issue that could cause mysqldump errors to be ignored thus causing the backup process to use an incomplete mysqldump file.</li>
</ul>

<h4>2.1.3</h4>

<ul>
<li>Fix a regression in <code>2.1.2</code> that broke previewing and adding new exclude rules.</li>
</ul>

<h4>2.1.2</h4>

<ul>
<li>Fix an issue that could stop the settings panel from closing on save on servers which return <code>\'0\'</code> for ajax requests.</li>
<li>Fix an issue that could cause the backup root to be set to <code>/</code> on sites with <code>site_url</code> and <code>home</code> set to different domains.</li>
<li>The mysqldump fallback function will now be used if <code>mysqldump</code> produces an empty file.</li>
<li>Fix a possible PHP <code>NOTICE</code> on Apache servers.</li>
</ul>

<h4>2.1.1</h4>

<ul>
<li>Fix a possible fatal error when a backup schedule is instantiated outside of wp-admin.</li>
<li>Don\'t use functions from misc.php as loading it too early can cause fatal errors.</li>
<li>Don\'t hardcode an English string in the JS, use the translated string instead.</li>
<li>Properly skip dot files, should fix fatal errors on systems with <code>open_basedir</code> restrictions.</li>
<li>Don\'t call <code>apache_mod_loaded</code> as it caused wierd DNS issue on some sites, use <code>global $is_apache</code> instead.</li>
<li>Fix a possible double full stop at the end of the schedule sentence.</li>
<li>Minor code cleanup.</li>
</ul>

<h4>2.1</h4>

<ul>
<li>Stop blocking people with <code>safe_mode = On</code> from using the plugin, instead just show a warning.</li>
<li>Fix possible fatal error when setting schedule to monthly.</li>
<li>Fix issues with download backup not working on some shared hosts.</li>
<li>Fix issuses with download backup not working on sites with strange characters in the site name.</li>
<li>Fix a bug could cause the update actions to fire on initial activation.</li>
<li>Improved reliability when changing backup paths, now with Unit Tests.</li>
<li>Generate the lists of excluded, included and unreadable files in a more memory efficient way, no more fatal errors on sites with lots of files.</li>
<li>Bring back .htaccess protection of the backups directory on <code>Apache</code> servers with <code>mod_rewrite</code> enabled.</li>
<li>Prepend a random string to the backups directory to make it harder to brute force guess.</li>
<li>Fall back to storing the backups directoy in <code>uploads</code> if <code>WP_CONTENT_DIR</code> isn\'t writable.</li>
<li>Attempt to catch <code>E_ERROR</code> level errors (Fatal errors) that happen during the backup process and offer to email them to support.</li>
<li>Provide more granular status messages during the backup process.</li>
<li>Show a spinner next to the schedule link when a backup is running on a schedule which you are not currently viewing.</li>
<li>Improve the feedback when removing an exclude rule.</li>
<li>Fix an issue that could cause an exclude rule to be marked as default when it in-fact isn\'t, thus not letting it be deleted.</li>
<li>Add a line encouraging people to rate the plugin if they like it.</li>
<li>Change the support line to point to the FAQ before recommending they contact support.</li>
<li>Fix the link to the "How to Restore" post in the FAQ.</li>
<li>Some string changes for translators, 18 changed strings.</li>
</ul>

<h4>2.0.6</h4>

<ul>
<li>Fix possible warning on plugin activation if the sites cron option is empty.</li>
<li>Don\'t show the version warning in the help for Constants as that comes from the current version.</li>
</ul>

<h4>2.0.5</h4>

<ul>
<li>Re-setup the cron schedules if they get deleted somehow.</li>
<li>Delete all BackUpWordPress cron entries when the plugin is deactivated.</li>
<li>Introduce the <code>HMBKP_SCHEDULE_TIME</code> constant to allow control over the time schedules run.</li>
<li>Make sure the schedule times and times of previous backups are shown in local time.</li>
<li>Fix a bug that could cause the legacy backup schedule to be created on every update, not just when going from 1.x to 2.x.</li>
<li>Improve the usefulness of the <code>wp-cron.php</code> response code check.</li>
<li>Use the built in <code>site_format</code> function for human readable filesizes instead of defining our own function.</li>
</ul>

<h4>2.0.4</h4>

<ul>
<li>Revert the change to the way the plugin url and path were calculated as it caused regressions on some systems.</li>
</ul>

<h4>2.0.3</h4>

<ul>
<li>Fix issues with scheduled backups not firing in some cases.</li>
<li>Better compatibility when the WP Remote plugin is active alongside BackUpWordPress.</li>
<li>Catch and display more WP Cron errors.</li>
<li>BackUpWordPress now fails to activate on WordPress 3.3.2 and below.</li>
<li>Other minor fixes and improvements.</li>
</ul>

<h4>2.0.2</h4>

<ul>
<li>Only send backup failed emails if the backup actually failed.</li>
<li>Turn off the generic "memory limit probably hit" message as it was showing for too many people.</li>
<li>Fix a possible notice when the backup running filename is blank.</li>
<li>Include the <code>wp_error</code> response in the cron check.</li>
</ul>

<h4>2.0.1</h4>

<ul>
<li>Fix fatal error on PHP 5.2.</li>
</ul>

<h4>2.0</h4>

<ul>
<li>Ability to have multiple schedules with separate settings &#38; excludes per schedule.</li>
<li>Ability to manage exclude rules and see exactly which files are included and excluded.</li>
<li>Fix an issue with sites with an <code>open_basedir</code> restriction.</li>
<li>Backups should now be much more reliable in low memory environments.</li>
<li>Lots of other minor improvements and bug fixes.</li>
</ul>

<h4>1.6.9</h4>

<ul>
<li>Updated and improved translations across the board - props @elektronikLexikon.</li>
<li>German translation - props @elektronikLexikon.</li>
<li>New Basque translation - props Unai ZC.</li>
<li>New Dutch translation - Anno De Vries.</li>
<li>New Italian translation.</li>
<li>Better support for when WordPress is installed in a sub directory - props @mattheu</li>
</ul>

<h4>1.6.8</h4>

<ul>
<li>French translation props Christophe - <a href="http://catarina.fr" rel="nofollow">http://catarina.fr</a>.</li>
<li>Updated Spanish Translation props DD666 - <a href="https://github.com/radinamatic" rel="nofollow">https://github.com/radinamatic</a>.</li>
<li>Serbian translation props StefanRistic - <a href="https://github.com/StefanRistic" rel="nofollow">https://github.com/StefanRistic</a>.</li>
<li>Lithuanian translation props Vincent G - <a href="http://www.Host1Free.com" rel="nofollow">http://www.Host1Free.com</a>.</li>
<li>Romanian translation.</li>
<li>Fix conflict with WP Remote.</li>
<li>Fix a minor issue where invalid email address\'s were still stored.</li>
<li>The root path that is backed up can now be controlled by defining <code>HMBKP_ROOT</code>.</li>
</ul>

<h4>1.6.7</h4>

<ul>
<li>Fix issue with backups being listed in reverse chronological order.</li>
<li>Fix issue with newest backup being deleted when you hit your max backups limit.</li>
<li>It\'s now possible to have backups sent to multiple email address\'s by entering them as a comma separated list.</li>
<li>Fix a bug which broke the ability to override the <code>mysqldump</code> path with <code>HMBKP_MYSQLDUMP_PATH</code>.</li>
<li>Use <code>echo</code> rather than <code>pwd</code> when testing <code>shell_exec</code> as it\'s supported cross platform.</li>
<li>Updated Spanish translation.</li>
<li>Fix a minor spelling mistake.</li>
<li>Speed up the manage backups page by caching the FAQ data for 24 hours.</li>
</ul>

<h4>1.6.6</h4>

<ul>
<li>Fix backup path issue with case sensitive filesystems.</li>
</ul>

<h4>1.6.5</h4>

<ul>
<li>Fix an issue with emailing backups that could cause the backup file to not be attached.</li>
<li>Fix an issue that could cause the backup to be marked as running for ever if emailing the backup <code>FATAL</code> error\'d.</li>
<li>Never show the running backup in the list of backups.</li>
<li>Show an error backup email failed to send.</li>
<li>Fix possible notice when deleting a backup file which doesn\'t exist.</li>
<li>Fix possible notice on older versions of <code>PHP</code> which don\'t define <code>E_DEPRECATED</code>.</li>
<li>Make <code>HMBKP_SECURE_KEY</code> override-able.</li>
<li>BackUpWordPress should now work when <code>ABSPATH</code> is <code>/</code>.</li>
</ul>

<h4>1.6.4</h4>

<ul>
<li>Don\'t show warning message as they cause to much panic.</li>
<li>Move previous methods errors to warnings in fallback methods.</li>
<li>Wrap <code>.htaccess</code> rewrite rules in if <code>mod_rewrite</code> check.</li>
<li>Add link to new restore help article to FAQ.</li>
<li>Fix issue that could cause "not using latest stable version" message to show when you were in-fact using the latest version.</li>
<li>Bug fix in <code>zip command</code> check that could cause an incorrect <code>zip</code> path to be used.</li>
<li>Detect and pass <code>MySQL</code> port to <code>mysqldump</code>.</li>
</ul>

<h4>1.6.3</h4>

<ul>
<li>Don\'t fail archive verification for errors in previous archive methods.</li>
<li>Improved detection of the <code>zip</code> and <code>mysqldump</code> commands.</li>
<li>Fix issues when <code>ABSPATH</code> is <code>/</code>.</li>
<li>Remove reliance on <code>SECURE_AUTH_KEY</code> as it\'s often not defined.</li>
<li>Use <code>warning()</code> not <code>error()</code> for issues reported by <code>zip</code>, <code>ZipArchive</code> &#38; <code>PclZip</code>.</li>
<li>Fix download zip on Windows when <code>ABSPATH</code> contains a trailing forward slash.</li>
<li>Send backup email after backup completes so that fatal errors in email code don\'t stop the backup from completing.</li>
<li>Add missing / to <code>PCLZIP_TEMPORARY_DIR</code> define.</li>
<li>Catch and display errors during <code>mysqldump</code>.</li>
</ul>

<h4>1.6.2</h4>

<ul>
<li>Track <code>PHP</code> errors as backup warnings not errors.</li>
<li>Only show warning message for <code>PHP</code> errors in BackUpWordPress files.</li>
<li>Ability to dismiss the error / warning messages.</li>
<li>Disable use of <code>PclZip</code> for full archive checking for now as it causes memory issues on some large sites.</li>
<li>Don\'t delete "number of backups" setting on update.</li>
<li>Better handling of multibyte characters in archive and database dump filenames.</li>
<li>Mark backup as running and increase callback timeout to <code>500</code> when firing backup via ajax.</li>
<li>Don\'t send backup email if backup failed.</li>
<li>Filter out duplicate exclude rules.</li>
</ul>

<h4>1.6.1</h4>

<ul>
<li>Fix fatal error on PHP =&#60; 5.3</li>
</ul>

<h4>1.6</h4>

<ul>
<li>Fixes issue with backups dir being included in backups on some Windows Servers.</li>
<li>Consistent handling of symlinks across all archive methods (they are followed).</li>
<li>Use .htaccess rewrite cond authentication to allow for secure http downloads of backup files.</li>
<li>Track errors and warnings that happen during backup and expose them through admin.</li>
<li>Fire manual backups using ajax instead of wp-cron, <code>HMBKP_DISABLE_MANUAL_BACKUP_CRON</code> is no longer needed and has been removed.</li>
<li>Ability to cancel a running backup.</li>
<li>Zip files are now integrity checked after every backup.</li>
<li>More robust handling of failed / corrupt zips, backup process now fallsback through the various zip methods until one works.</li>
<li>Use <code>mysql_query</code> instead of the depreciated <code>mysql_list_tables</code>.</li>
</ul>

<h4>1.5.2</h4>

<ul>
<li>Better handling of unreadable files in ZipArchive and the backup size calculation.</li>
<li>Support for wp-cli, usage: <code>wp backup [--files_only] [--database_only] [--path&#60;dir&#62;] [--root&#60;dir&#62;] [--zip_command_path=&#60;path&#62;] [--mysqldump_command_path=&#60;path&#62;]</code></li>
</ul>

<h4>1.5.1</h4>

<ul>
<li>Better detection of <code>zip</code> command.</li>
<li>Don\'t delete user settings on update / deactivate.</li>
<li>Use <code>ZipArchive</code> if <code>zip</code> is not available, still falls back to <code>PclZip</code> if neither <code>zip</code> nor <code>ZipArchive</code> are installed.</li>
<li>Better exclude rule parsing, fixes lots of edge cases, excludes now pass all 52 unit tests.</li>
<li>Improved the speed of the backup size calculation.</li>
</ul>

<h4>1.5</h4>

<ul>
<li>Re-written core backup engine should be more robust especially in edge case scenarios.</li>
<li>48 unit tests for the core backup engine, yay for unit tests.</li>
<li>Remove some extraneous status information from the admin interface.</li>
<li>Rename Advanced Options to Settings</li>
<li>New <code>Constant</code> <code>HMBKP_CAPABILITY</code> to allow the default <code>add_menu_page</code> capability to be changed.</li>
<li>Suppress possible filemtime warnings in some edge cases.</li>
<li>3.3 compatability.</li>
<li>Set proper charset of MySQL backup, props valericus.</li>
<li>Fix some inconsistencies between the estimated backup size and actual backup size when excluding files.</li>
</ul>

<h4>1.4.1</h4>

<ul>
<li>1.4 was incorrectly marked as beta.</li>
</ul>

<h4>1.4</h4>

<ul>
<li>Most options can now be set on the backups page, all options can still be set by defining them as <code>Constants</code>.</li>
<li>Russian translation, props valericus.</li>
<li>All dates are now translatable.</li>
<li>Fixed some strings which weren\'t translatable.</li>
<li>New Constant <code>HMBKP_DISABLE_MANUAL_BACKUP_CRON</code> which enable you to disable the use of <code>wp_cron</code> for manual backups.</li>
<li>Manual backups now work if <code>DISABLE_WP_CRON</code> is defined as <code>true</code>.</li>
</ul>

<h4>1.3.2</h4>

<ul>
<li>Spanish translation</li>
<li>Bump PHP version check to 5.2.4</li>
<li>Fallback to PHP mysqldump if shell_exec fails for any reason.</li>
<li>Silently ignore unreadable files / folders</li>
<li>Make sure binary data is properly exported when doing a mysqldump</li>
<li>Use 303 instead of 302 when redirecting in the admin.</li>
<li>Don\'t <code>set_time_limit</code> inside a loop</li>
<li>Use WordPress 3.2 style buttons</li>
<li>Don\'t pass an empty password to mysqldump</li>
</ul>

<h4>1.3.1</h4>

<ul>
<li>Check for PHP version. Deactivate plugin if running on PHP version 4.</li>
</ul>

<h4>1.3</h4>

<ul>
<li>Re-written back up engine, no longer copies everything to a tmp folder before zipping which should improve speed and reliability.</li>
<li>Support for excluding files and folders, define <code>HMBKP_EXCLUDE</code> with a comma separated list of files and folders to exclude, supports wildcards <code>*</code>, path fragments and absolute paths.</li>
<li>Full support for moving the backups directory, if you define a new backups directory then your existing backups will be moved to it.</li>
<li>Work around issues caused by low MySQL <code>wait_timeout</code> setting.</li>
<li>Add FAQ to readme.txt.</li>
<li>Pull FAQ into the contextual help tab on the backups page.</li>
<li>Block activation on old versions of WordPress.</li>
<li>Stop guessing compressed backup file size, instead just show size of site uncompressed.</li>
<li>Fix bug in <code>safe_mode</code> detection which could cause <code>Off</code> to act like <code>On</code>.</li>
<li>Better name for the database dump file.</li>
<li>Better name for the backup files.</li>
<li>Improve styling for advanced options.</li>
<li>Show examples for all advanced options.</li>
<li>Language improvements.</li>
<li>Layout tweaks.</li>
</ul>

<h4>1.2</h4>

<ul>
<li>Show live backup status in the back up now button when a back up is running.</li>
<li>Show free disk space after total used by backups.</li>
<li>Several langauge changes.</li>
<li>Work around the 1 cron every 60 seconds limit.</li>
<li>Store backup status in a 2 hour transient as a last ditch attempt to work around the "stuck on backup running" issue.</li>
<li>Show a warning and disable backups when PHP is in Safe Mode, may try to work round issues and re-enable in the future.</li>
<li>Highlight defined <code>Constants</code>.</li>
<li>Show defaults for all <code>Constants</code>.</li>
<li>Show a warning if both <code>HMBKP_FILES_ONLY</code> and <code>HMBKP_DATABASE_ONLY</code> are defined at the same time.</li>
<li>Make sure options added in 1.1.4 are cleared on de-activate.</li>
<li>Support <code>mysqldump on</code> Windows if it\'s available.</li>
<li>New option to have each backup emailed to you on completion. Props @matheu for the contribution.</li>
<li>Improved windows server support.</li>
</ul>

<h4>1.1.4</h4>

<ul>
<li>Fix a rare issue where database backups could fail when using the mysqldump PHP fallback if <code>mysql.max_links</code> is set to 2 or less.</li>
<li>Don\'t suppress <code>mysql_connect</code> errors in the mysqldump PHP fallback.</li>
<li>One time highlight of the most recent completed backup when viewing the manage backups page after a successful backup.</li>
<li>Fix a spelling error in the <code>shell_exec</code> disabled message.</li>
<li>Store the BackUpWordPress version as a <code>Constant</code> rather than a <code>Variable</code>.</li>
<li>Don\'t <code>(float)</code> the BackUpWordPress version number, fixes issues with minor versions numbers being truncated.</li>
<li>Minor PHPDoc improvements.</li>
</ul>

<h4>1.1.3</h4>

<ul>
<li>Attempt to re-connect if database connection hits a timeout while a backup is running, should fix issues with the "Back Up Now" button continuing to spin even though the backup is completed.</li>
<li>When using <code>PCLZIP</code> as the zip fallback don\'t store the files with absolute paths. Should fix issues unzipping the file archives using "Compressed (zipped) Folders" on Windows XP.</li>
</ul>

<h4>1.1.2</h4>

<ul>
<li>Fix a bug that stopped <code>HMBKP_DISABLE_AUTOMATIC_BACKUP</code> from working.</li>
</ul>

<h4>1.1.1</h4>

<ul>
<li>Fix a possible <code>max_execution_timeout</code> fatal error when attempting to calculate the path to <code>mysqldump</code>.</li>
<li>Clear the running backup status and reset the calculated filesize on update.</li>
<li>Show a link to the manage backups page in the plugin description.</li>
<li>Other general fixes.</li>
</ul>

<h4>1.1</h4>

<ul>
<li>Remove the logging facility as it provided little benefit and complicated the code, your existing logs will be deleted on update.</li>
<li>Expose the various <code>Constants</code> that can be defined to change advanced settings.</li>
<li>Added the ability to disable the automatic backups completely <code>define( \'HMBKP_DISABLE_AUTOMATIC_BACKUP\', true );</code>.</li>
<li>Added the ability to switch to file only or database only backups <code>define( \'HMBKP_FILES_ONLY\', true );</code> Or <code>define( \'HMBKP_DATABASE_ONLY\', true );</code>.</li>
<li>Added the ability to define how many old backups should be kept <code>define( \'HMBKP_MAX_BACKUPS\', 20 );</code></li>
<li>Added the ability to define the time that the daily backup should run <code>define( \'HMBKP_DAILY_SCHEDULE_TIME\', \'16:30\' );</code></li>
<li>Tweaks to the backups page layout.</li>
<li>General bug fixes and improvements.</li>
</ul>

<h4>1.0.5</h4>

<ul>
<li>Don\'t ajax load estimated backup size if it\'s already been calculated.</li>
<li>Fix time in backup complete log message.</li>
<li>Don\'t mark backup as running until cron has been called, will fix issues with backup showing as running even if cron never fired.</li>
<li>Show number of backups saved message.</li>
<li>Add a link to the backups page to the plugin action links.</li>
</ul>

<h4>1.0.4</h4>

<p>Don\'t throw PHP Warnings when <code>shell_exec</code> is disabled</p>

<h4>1.0.3</h4>

<p>Minor bug fix release.</p>

<ul>
<li>Suppress <code>filesize()</code> warnings when calculating backup size.</li>
<li>Plugin should now work when symlinked.</li>
<li>Remove all options on deactivate, you should now be able to deactivate then activate to fix issues with settings etc. becoming corrupt.</li>
<li>Call setup_defaults for users who update from backupwordpress 0.4.5 so they get new settings.</li>
<li>Don\'t ajax ping running backup status quite so often.</li>
</ul>

<h4>1.0.1 &#38; 1.0.2</h4>

<p>Fix some silly 1.0 bugs</p>

<h4>1.0</h4>

<p>1.0 represents a total rewrite &#38; rethink of the BackUpWordPress plugin with a focus on making it "Just Work". The management and development of the plugin has been taken over by <a href="http://hmn.md">Human Made Limited</a> the chaps behind <a href="https://wpremote.com">WP Remote</a></p>

<h4>Previous</h4>

<p>Version 0.4.5 and previous were developed by <a href="http://profiles.wordpress.org/users/wpdprx/">wpdprx</a></p>";s:3:"faq";s:4053:"<p><strong>Where does BackUpWordPress store the backup files?</strong></p>

<p>Backups are stored on your server in <code>/wp-content/backups</code>, you can change the directory.</p>

<p><strong>Important:</strong> By default BackUpWordPress backs up everything in your site root as well as your database, this includes any non WordPress folders that happen to be in your site root. This does means that your backup directory can get quite large.</p>

<p><strong>How do I restore my site from a backup?</strong></p>

<p>You need to download the latest backup file either by clicking download on the backups page or via <code>FTP</code>. <code>Unzip</code> the files and upload all the files to your server overwriting your site. You can then import the database using your hosts database management tool (likely <code>phpMyAdmin</code>).</p>

<p>See this post for more details <a href="http://hmn.md/backupwordpress-how-to-restore-from-backup-files/" rel="nofollow">http://hmn.md/backupwordpress-how-to-restore-from-backup-files/</a>.</p>

<p><strong>Does BackUpWordPress back up the backups directory?</strong></p>

<p>No.</p>

<p><strong>I\'m not receiving my backups by email</strong></p>

<p>Most servers have a filesize limit on email attachments, it\'s generally about 10mb. If your backup file is over that limit it won\'t be sent attached to the email, instead you should receive an email with a link to download the backup, if you aren\'t even receiving that then you likely have a mail issue on your server that you\'ll need to contact your host about.</p>

<p><strong>How many backups are stored by default?</strong></p>

<p>BackUpWordPress stores the last 10 backups by default.</p>

<p><strong>How long should a backup take?</strong></p>

<p>Unless your site is very large (many gigabytes) it should only take a few minutes to perform a back up, if your back up has been running for longer than an hour it\'s safe to assume that something has gone wrong, try de-activating and re-activating the plugin, if it keeps happening, contact support.</p>

<p><strong>What do I do if I get the wp-cron error message</strong></p>

<p>The issue is that your <code>wp-cron.php</code> is not returning a <code>200</code> response when hit with a http request originating from your own server, it could be several things, most of the time it\'s an issue with the server / site and not with BackUpWordPress.</p>

<p>Some things you can test are.</p>

<ul>
<li>Are scheduled posts working? (They use wp-cron too).</li>
<li>Are you hosted on Heart Internet? (wp-cron is known not to work with them).</li>
<li>If you click manual backup does it work?</li>
<li>Try adding <code>define( \'ALTERNATE_WP_CRON\', true ); to your</code>wp-config.php`, do automatic backups work?</li>
<li>Is your site private (I.E. is it behind some kind of authentication, maintenance plugin, .htaccess) if so wp-cron won\'t work until you remove it, if you are and you temporarily remove the authentication, do backups start working?</li>
</ul>

<p>If you have tried all these then feel free to contact support.</p>

<p><strong>How to get BackUpWordPress working in Heart Internet</strong></p>

<p>The script to be entered into the Heart Internet cPanel is: <code>/usr/bin/php5 /home/sites/yourdomain.com/public_html/wp-cron.php</code> (note the space between php5 and the location of the file). The file <code>wp-cron.php</code> <code>chmod</code> must be set to <code>711</code>.</p>

<p><strong>Further Support &#38; Feedback</strong></p>

<p>General support questions should be posted in the <a href="http://wordpress.org/tags/backupwordpress?forum_id=10">WordPress support forums, tagged with backupwordpress.</a></p>

<p>For development issues, feature requests or anybody wishing to help out with development checkout <a href="https://github.com/humanmade/backupwordpress/">BackUpWordPress on GitHub.</a></p>

<p>You can also tweet <a href="http://twitter.com/humanmadeltd">@humanmadeltd</a> or email <a href="mailto:support@hmn.md">support@hmn.md</a> for further help/support.</p>";}s:13:"download_link";s:63:"http://downloads.wordpress.org/plugin/backupwordpress.2.2.4.zip";s:4:"tags";a:10:{s:7:"archive";s:7:"archive";s:7:"back-up";s:7:"back up";s:6:"backup";s:6:"backup";s:7:"backups";s:7:"backups";s:8:"database";s:8:"database";s:2:"db";s:2:"db";s:5:"files";s:5:"files";s:9:"humanmade";s:9:"humanmade";s:6:"wp-cli";s:6:"wp-cli";s:3:"zip";s:3:"zip";}}', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (261, '_transient_timeout_hmbkp_schedule_default-2_filesize', '2732716388', 'no') ; 
INSERT INTO `wpWPP_options` VALUES (262, '_transient_hmbkp_schedule_default-2_filesize', '27810625', 'no') ;
#
# End of data contents of table wpWPP_options
# --------------------------------------------------------

# WordPress : http://localhost/allisongrayce.com MySQL database backup
#
# Generated: Thursday 18. April 2013 19:56 UTC
# Hostname: localhost
# Database: `wp_portfolio`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_commentmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_comments`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_links`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_options`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_postmeta`
# --------------------------------------------------------


#
# Delete any existing table `wpWPP_postmeta`
#

DROP TABLE IF EXISTS `wpWPP_postmeta`;


#
# Table structure of table `wpWPP_postmeta`
#

CREATE TABLE `wpWPP_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8 ;

#
# Data contents of table wpWPP_postmeta (195 records)
#
 
INSERT INTO `wpWPP_postmeta` VALUES (1, 2, '_wp_page_template', 'default') ; 
INSERT INTO `wpWPP_postmeta` VALUES (2, 2, '_edit_lock', '1360185459:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (7, 6, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (8, 6, '_wp_page_template', 'default') ; 
INSERT INTO `wpWPP_postmeta` VALUES (9, 6, '_edit_lock', '1366313458:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (10, 7, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (11, 7, '_edit_lock', '1360185635:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (12, 7, '_wp_page_template', 'default') ; 
INSERT INTO `wpWPP_postmeta` VALUES (13, 9, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (14, 9, '_wp_page_template', 'default') ; 
INSERT INTO `wpWPP_postmeta` VALUES (15, 9, '_edit_lock', '1360185648:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (16, 10, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (17, 10, '_wp_page_template', 'work.php') ; 
INSERT INTO `wpWPP_postmeta` VALUES (18, 10, '_edit_lock', '1366314214:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (19, 11, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (20, 11, '_wp_page_template', 'default') ; 
INSERT INTO `wpWPP_postmeta` VALUES (21, 11, '_edit_lock', '1366313869:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (22, 12, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (23, 12, '_edit_lock', '1360185754:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (25, 15, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (26, 15, '_edit_lock', '1360185769:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (28, 17, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (29, 17, '_edit_lock', '1360185786:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (30, 19, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (31, 19, 'field_1', 'a:10:{s:5:"label";s:15:"URL to Web Site";s:4:"name";s:3:"url";s:4:"type";s:4:"text";s:12:"instructions";s:32:"Enter in the url for the project";s:8:"required";s:1:"1";s:13:"default_value";s:7:"http://";s:10:"formatting";s:4:"none";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:3:{s:5:"field";s:4:"null";s:8:"operator";s:2:"==";s:5:"value";s:0:"";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:0;s:3:"key";s:7:"field_1";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (32, 19, 'allorany', 'all') ; 
INSERT INTO `wpWPP_postmeta` VALUES (34, 19, 'position', 'normal') ; 
INSERT INTO `wpWPP_postmeta` VALUES (35, 19, 'layout', 'no_box') ; 
INSERT INTO `wpWPP_postmeta` VALUES (36, 19, 'hide_on_screen', 'a:13:{i:0;s:11:"the_content";i:1;s:7:"excerpt";i:2;s:13:"custom_fields";i:3;s:10:"discussion";i:4;s:8:"comments";i:5;s:9:"revisions";i:6;s:4:"slug";i:7;s:6:"author";i:8;s:6:"format";i:9;s:14:"featured_image";i:10;s:10:"categories";i:11;s:4:"tags";i:12;s:15:"send-trackbacks";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (37, 19, '_edit_lock', '1366314524:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (38, 19, 'field_2', 'a:10:{s:5:"label";s:11:"Description";s:4:"name";s:11:"description";s:4:"type";s:8:"textarea";s:12:"instructions";s:37:"Enter in a description of the project";s:8:"required";s:1:"1";s:13:"default_value";s:0:"";s:10:"formatting";s:4:"none";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:3:{s:5:"field";s:4:"null";s:8:"operator";s:2:"==";s:5:"value";s:0:"";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:1;s:3:"key";s:7:"field_2";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (39, 19, 'field_3', 'a:9:{s:7:"choices";a:1:{s:3:"Yes";s:3:"Yes";}s:5:"label";s:26:"Display on Homepage Slider";s:4:"name";s:19:"display_on_homepage";s:4:"type";s:8:"checkbox";s:12:"instructions";s:62:"Check if you would like this project to appear on the homepage";s:8:"required";s:1:"0";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:3:{s:5:"field";s:4:"null";s:8:"operator";s:2:"==";s:5:"value";s:0:"";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:2;s:3:"key";s:7:"field_3";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (40, 19, 'field_4', 'a:10:{s:5:"label";s:21:"Homepage Slider Image";s:4:"name";s:21:"homepage_slider_image";s:4:"type";s:5:"image";s:12:"instructions";s:66:"Upload the image to appear for this project on the homepage slider";s:8:"required";s:1:"0";s:11:"save_format";s:3:"url";s:12:"preview_size";s:4:"full";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:3:{s:5:"field";s:7:"field_3";s:8:"operator";s:2:"==";s:5:"value";s:3:"Yes";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:3;s:3:"key";s:7:"field_4";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (41, 19, 'field_5', 'a:9:{s:5:"label";s:16:"Background Color";s:4:"name";s:16:"background_color";s:4:"type";s:12:"color_picker";s:12:"instructions";s:67:"Select the color to appear as the background color for this project";s:8:"required";s:1:"0";s:13:"default_value";s:0:"";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:3:{s:5:"field";s:7:"field_3";s:8:"operator";s:2:"==";s:5:"value";s:3:"Yes";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:4;s:3:"key";s:7:"field_5";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (42, 19, 'field_6', 'a:9:{s:5:"label";s:12:"Button Color";s:4:"name";s:12:"button_color";s:4:"type";s:12:"color_picker";s:12:"instructions";s:70:"Select the color to appear for the button associated with this project";s:8:"required";s:1:"1";s:13:"default_value";s:0:"";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:3:{s:5:"field";s:7:"field_3";s:8:"operator";s:2:"==";s:5:"value";s:3:"Yes";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:5;s:3:"key";s:7:"field_6";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (43, 19, 'field_7', 'a:11:{s:5:"label";s:20:"Related Testimonials";s:4:"name";s:20:"related_testimonials";s:4:"type";s:12:"relationship";s:12:"instructions";s:31:"Select any related testimonials";s:8:"required";s:1:"0";s:9:"post_type";a:1:{i:0;s:12:"testimonials";}s:8:"taxonomy";a:1:{i:0;s:3:"all";}s:3:"max";s:0:"";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:3:{s:5:"field";s:7:"field_3";s:8:"operator";s:2:"==";s:5:"value";s:3:"Yes";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:6;s:3:"key";s:7:"field_7";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (45, 20, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (46, 20, 'field_8', 'a:10:{s:5:"label";s:4:"Name";s:4:"name";s:4:"name";s:4:"type";s:4:"text";s:12:"instructions";s:0:"";s:8:"required";s:1:"1";s:13:"default_value";s:0:"";s:10:"formatting";s:4:"none";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:3:{s:5:"field";s:4:"null";s:8:"operator";s:2:"==";s:5:"value";s:0:"";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:0;s:3:"key";s:7:"field_8";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (47, 20, 'field_9', 'a:12:{s:5:"label";s:11:"Testimonial";s:4:"name";s:11:"testimonial";s:4:"type";s:7:"wysiwyg";s:12:"instructions";s:38:"Enter in the testimonial of the person";s:8:"required";s:1:"1";s:13:"default_value";s:0:"";s:7:"toolbar";s:5:"basic";s:12:"media_upload";s:2:"no";s:11:"the_content";s:3:"yes";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:3:{s:5:"field";s:4:"null";s:8:"operator";s:2:"==";s:5:"value";s:0:"";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:1;s:3:"key";s:7:"field_9";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (48, 20, 'allorany', 'all') ; 
INSERT INTO `wpWPP_postmeta` VALUES (50, 20, 'position', 'normal') ; 
INSERT INTO `wpWPP_postmeta` VALUES (51, 20, 'layout', 'no_box') ; 
INSERT INTO `wpWPP_postmeta` VALUES (52, 20, 'hide_on_screen', 'a:13:{i:0;s:11:"the_content";i:1;s:7:"excerpt";i:2;s:13:"custom_fields";i:3;s:10:"discussion";i:4;s:8:"comments";i:5;s:9:"revisions";i:6;s:4:"slug";i:7;s:6:"author";i:8;s:6:"format";i:9;s:14:"featured_image";i:10;s:10:"categories";i:11;s:4:"tags";i:12;s:15:"send-trackbacks";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (53, 20, '_edit_lock', '1360187468:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (54, 20, 'rule', 'a:4:{s:5:"param";s:9:"post_type";s:8:"operator";s:2:"==";s:5:"value";s:12:"testimonials";s:8:"order_no";i:0;}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (55, 19, 'rule', 'a:4:{s:5:"param";s:9:"post_type";s:8:"operator";s:2:"==";s:5:"value";s:4:"work";s:8:"order_no";i:0;}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (56, 25, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (57, 25, '_edit_lock', '1366312696:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (58, 26, '_wp_attached_file', '2013/02/shirts4mike-homepage-image.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (59, 26, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:856;s:6:"height";i:550;s:4:"file";s:38:"2013/02/shirts4mike-homepage-image.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:38:"shirts4mike-homepage-image-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:38:"shirts4mike-homepage-image-300x192.png";s:5:"width";i:300;s:6:"height";i:192;s:9:"mime-type";s:9:"image/png";}s:14:"post-thumbnail";a:4:{s:4:"file";s:38:"shirts4mike-homepage-image-624x400.png";s:5:"width";i:624;s:6:"height";i:400;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (60, 26, '_wp_attachment_image_alt', 'Graphic showing Shirts 4 Mike site on computer') ; 
INSERT INTO `wpWPP_postmeta` VALUES (61, 25, 'url', 'http://shirts4mike.com') ; 
INSERT INTO `wpWPP_postmeta` VALUES (62, 25, '_url', 'field_1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (63, 25, 'description', 'An ecommerce site for Treehouse friend, Mike the Frog, to sell the shirts he designs.') ; 
INSERT INTO `wpWPP_postmeta` VALUES (64, 25, '_description', 'field_2') ; 
INSERT INTO `wpWPP_postmeta` VALUES (65, 25, 'display_on_homepage', 'a:1:{i:0;s:3:"Yes";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (66, 25, '_display_on_homepage', 'field_3') ; 
INSERT INTO `wpWPP_postmeta` VALUES (67, 25, 'homepage_slider_image', '26') ; 
INSERT INTO `wpWPP_postmeta` VALUES (68, 25, '_homepage_slider_image', 'field_4') ; 
INSERT INTO `wpWPP_postmeta` VALUES (69, 25, 'background_color', '#778751') ; 
INSERT INTO `wpWPP_postmeta` VALUES (70, 25, '_background_color', 'field_5') ; 
INSERT INTO `wpWPP_postmeta` VALUES (71, 25, 'button_color', '#FF8400') ; 
INSERT INTO `wpWPP_postmeta` VALUES (72, 25, '_button_color', 'field_6') ; 
INSERT INTO `wpWPP_postmeta` VALUES (73, 25, 'related_testimonials', 'a:1:{i:0;s:2:"28";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (74, 25, '_related_testimonials', 'field_7') ; 
INSERT INTO `wpWPP_postmeta` VALUES (75, 28, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (76, 28, '_edit_lock', '1360187952:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (77, 28, 'name', 'Mike the Frog') ; 
INSERT INTO `wpWPP_postmeta` VALUES (78, 28, '_name', 'field_8') ; 
INSERT INTO `wpWPP_postmeta` VALUES (79, 28, 'testimonial', 'Allison did a great job designing this new site for me, yup yup!') ; 
INSERT INTO `wpWPP_postmeta` VALUES (80, 28, '_testimonial', 'field_9') ; 
INSERT INTO `wpWPP_postmeta` VALUES (81, 30, 'url', 'http://shirts4mike.com') ; 
INSERT INTO `wpWPP_postmeta` VALUES (82, 30, 'description', 'An ecommerce site for Treehouse friend, Mike the Frog, to sell the shirts he designs.') ; 
INSERT INTO `wpWPP_postmeta` VALUES (83, 30, 'display_on_homepage', 'a:1:{i:0;s:3:"Yes";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (84, 30, 'homepage_slider_image', '26') ; 
INSERT INTO `wpWPP_postmeta` VALUES (85, 30, 'background_color', '#778751') ; 
INSERT INTO `wpWPP_postmeta` VALUES (86, 30, 'button_color', '#FF8400') ; 
INSERT INTO `wpWPP_postmeta` VALUES (87, 30, 'related_testimonials', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (88, 33, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (89, 33, '_edit_lock', '1366313003:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (90, 34, '_wp_attached_file', '2013/04/drwattz-homepage-image.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (91, 34, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:856;s:6:"height";i:550;s:4:"file";s:34:"2013/04/drwattz-homepage-image.png";s:5:"sizes";a:2:{s:9:"thumbnail";a:4:{s:4:"file";s:34:"drwattz-homepage-image-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:34:"drwattz-homepage-image-300x192.png";s:5:"width";i:300;s:6:"height";i:192;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (92, 35, '_wp_attached_file', '2013/04/drwattz-one.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (93, 35, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1126;s:6:"height";i:617;s:4:"file";s:23:"2013/04/drwattz-one.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:23:"drwattz-one-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:23:"drwattz-one-300x164.png";s:5:"width";i:300;s:6:"height";i:164;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:24:"drwattz-one-1024x561.png";s:5:"width";i:1024;s:6:"height";i:561;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (94, 36, '_wp_attached_file', '2013/04/drwattz-three.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (95, 36, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1280;s:6:"height";i:779;s:4:"file";s:25:"2013/04/drwattz-three.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:25:"drwattz-three-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:25:"drwattz-three-300x182.png";s:5:"width";i:300;s:6:"height";i:182;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:26:"drwattz-three-1024x623.png";s:5:"width";i:1024;s:6:"height";i:623;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (96, 37, '_wp_attached_file', '2013/04/drwattz-two.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (97, 37, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1280;s:6:"height";i:1053;s:4:"file";s:23:"2013/04/drwattz-two.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:23:"drwattz-two-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:23:"drwattz-two-300x246.png";s:5:"width";i:300;s:6:"height";i:246;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:24:"drwattz-two-1024x842.png";s:5:"width";i:1024;s:6:"height";i:842;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (98, 38, '_wp_attached_file', '2013/04/shirts4mike-homepage-image.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (99, 38, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:856;s:6:"height";i:550;s:4:"file";s:38:"2013/04/shirts4mike-homepage-image.png";s:5:"sizes";a:2:{s:9:"thumbnail";a:4:{s:4:"file";s:38:"shirts4mike-homepage-image-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:38:"shirts4mike-homepage-image-300x192.png";s:5:"width";i:300;s:6:"height";i:192;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (100, 39, '_wp_attached_file', '2013/04/shirts4mike-one.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (101, 39, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1280;s:6:"height";i:720;s:4:"file";s:27:"2013/04/shirts4mike-one.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:27:"shirts4mike-one-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:27:"shirts4mike-one-300x168.png";s:5:"width";i:300;s:6:"height";i:168;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:28:"shirts4mike-one-1024x576.png";s:5:"width";i:1024;s:6:"height";i:576;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (102, 40, '_wp_attached_file', '2013/04/shirts4mike-two.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (103, 40, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1280;s:6:"height";i:720;s:4:"file";s:27:"2013/04/shirts4mike-two.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:27:"shirts4mike-two-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:27:"shirts4mike-two-300x168.png";s:5:"width";i:300;s:6:"height";i:168;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:28:"shirts4mike-two-1024x576.png";s:5:"width";i:1024;s:6:"height";i:576;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (104, 41, '_wp_attached_file', '2013/04/smells-like-bakin-homepage-image.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (105, 41, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:856;s:6:"height";i:550;s:4:"file";s:44:"2013/04/smells-like-bakin-homepage-image.png";s:5:"sizes";a:2:{s:9:"thumbnail";a:4:{s:4:"file";s:44:"smells-like-bakin-homepage-image-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:44:"smells-like-bakin-homepage-image-300x192.png";s:5:"width";i:300;s:6:"height";i:192;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (106, 42, '_wp_attached_file', '2013/04/smells-like-bakin-one.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (107, 42, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1280;s:6:"height";i:1375;s:4:"file";s:33:"2013/04/smells-like-bakin-one.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:33:"smells-like-bakin-one-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:33:"smells-like-bakin-one-279x300.png";s:5:"width";i:279;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:34:"smells-like-bakin-one-953x1024.png";s:5:"width";i:953;s:6:"height";i:1024;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (108, 43, '_wp_attached_file', '2013/04/stopvisualpollution-homepage-image.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (109, 43, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:856;s:6:"height";i:550;s:4:"file";s:46:"2013/04/stopvisualpollution-homepage-image.png";s:5:"sizes";a:2:{s:9:"thumbnail";a:4:{s:4:"file";s:46:"stopvisualpollution-homepage-image-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:46:"stopvisualpollution-homepage-image-300x192.png";s:5:"width";i:300;s:6:"height";i:192;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (110, 44, '_wp_attached_file', '2013/04/stopvisualpollution-one.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (111, 44, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1280;s:6:"height";i:720;s:4:"file";s:35:"2013/04/stopvisualpollution-one.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:35:"stopvisualpollution-one-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:35:"stopvisualpollution-one-300x168.png";s:5:"width";i:300;s:6:"height";i:168;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:36:"stopvisualpollution-one-1024x576.png";s:5:"width";i:1024;s:6:"height";i:576;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (112, 45, '_wp_attached_file', '2013/04/stopvisualpollution-three.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (113, 45, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1280;s:6:"height";i:972;s:4:"file";s:37:"2013/04/stopvisualpollution-three.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:37:"stopvisualpollution-three-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:37:"stopvisualpollution-three-300x227.png";s:5:"width";i:300;s:6:"height";i:227;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:38:"stopvisualpollution-three-1024x777.png";s:5:"width";i:1024;s:6:"height";i:777;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (114, 46, '_wp_attached_file', '2013/04/stopvisualpollution-two.png') ; 
INSERT INTO `wpWPP_postmeta` VALUES (115, 46, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1280;s:6:"height";i:720;s:4:"file";s:35:"2013/04/stopvisualpollution-two.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:35:"stopvisualpollution-two-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:35:"stopvisualpollution-two-300x168.png";s:5:"width";i:300;s:6:"height";i:168;s:9:"mime-type";s:9:"image/png";}s:5:"large";a:4:{s:4:"file";s:36:"stopvisualpollution-two-1024x576.png";s:5:"width";i:1024;s:6:"height";i:576;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (116, 41, '_wp_attachment_image_alt', 'Smells Like Bakin Slideshow Image') ; 
INSERT INTO `wpWPP_postmeta` VALUES (117, 33, 'url', 'http://www.smellslikebakin.com') ; 
INSERT INTO `wpWPP_postmeta` VALUES (118, 33, '_url', 'field_1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (119, 33, 'description', 'Website done for demonstrating how to build a simple site using HTML and CSS.') ; 
INSERT INTO `wpWPP_postmeta` VALUES (120, 33, '_description', 'field_2') ; 
INSERT INTO `wpWPP_postmeta` VALUES (121, 33, 'display_on_homepage', 'a:1:{i:0;s:3:"Yes";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (122, 33, '_display_on_homepage', 'field_3') ; 
INSERT INTO `wpWPP_postmeta` VALUES (123, 33, 'homepage_slider_image', '41') ; 
INSERT INTO `wpWPP_postmeta` VALUES (124, 33, '_homepage_slider_image', 'field_4') ; 
INSERT INTO `wpWPP_postmeta` VALUES (125, 33, 'background_color', '#459F8C') ; 
INSERT INTO `wpWPP_postmeta` VALUES (126, 33, '_background_color', 'field_5') ; 
INSERT INTO `wpWPP_postmeta` VALUES (127, 33, 'button_color', '#9F1D11') ; 
INSERT INTO `wpWPP_postmeta` VALUES (128, 33, '_button_color', 'field_6') ; 
INSERT INTO `wpWPP_postmeta` VALUES (129, 33, 'related_testimonials', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (130, 33, '_related_testimonials', 'field_7') ; 
INSERT INTO `wpWPP_postmeta` VALUES (131, 48, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (132, 48, '_edit_lock', '1366313069:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (133, 34, '_wp_attachment_image_alt', 'Dr Wattz. Blog Slideshow Image') ; 
INSERT INTO `wpWPP_postmeta` VALUES (134, 48, 'url', 'http://drwattz.com') ; 
INSERT INTO `wpWPP_postmeta` VALUES (135, 48, '_url', 'field_1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (136, 48, 'description', 'Web site for Treehouse friend and inventor, Dr. Plank Wattz.  The site contains a blog and photo gallery.') ; 
INSERT INTO `wpWPP_postmeta` VALUES (137, 48, '_description', 'field_2') ; 
INSERT INTO `wpWPP_postmeta` VALUES (138, 48, 'display_on_homepage', 'a:1:{i:0;s:3:"Yes";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (139, 48, '_display_on_homepage', 'field_3') ; 
INSERT INTO `wpWPP_postmeta` VALUES (140, 48, 'homepage_slider_image', '34') ; 
INSERT INTO `wpWPP_postmeta` VALUES (141, 48, '_homepage_slider_image', 'field_4') ; 
INSERT INTO `wpWPP_postmeta` VALUES (142, 48, 'background_color', '#95908E') ; 
INSERT INTO `wpWPP_postmeta` VALUES (143, 48, '_background_color', 'field_5') ; 
INSERT INTO `wpWPP_postmeta` VALUES (144, 48, 'button_color', '#000000') ; 
INSERT INTO `wpWPP_postmeta` VALUES (145, 48, '_button_color', 'field_6') ; 
INSERT INTO `wpWPP_postmeta` VALUES (146, 48, 'related_testimonials', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (147, 48, '_related_testimonials', 'field_7') ; 
INSERT INTO `wpWPP_postmeta` VALUES (148, 50, '_edit_last', '1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (149, 50, '_edit_lock', '1366313263:1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (150, 43, '_wp_attachment_image_alt', 'Stop Visual Pollution Slideshow Image') ; 
INSERT INTO `wpWPP_postmeta` VALUES (151, 50, 'url', 'http://stopvisualpollution.com/') ; 
INSERT INTO `wpWPP_postmeta` VALUES (152, 50, '_url', 'field_1') ; 
INSERT INTO `wpWPP_postmeta` VALUES (153, 50, 'description', 'A conference web site designed for the Express Your Creative series from Treehouse.') ; 
INSERT INTO `wpWPP_postmeta` VALUES (154, 50, '_description', 'field_2') ; 
INSERT INTO `wpWPP_postmeta` VALUES (155, 50, 'display_on_homepage', 'a:1:{i:0;s:3:"Yes";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (156, 50, '_display_on_homepage', 'field_3') ; 
INSERT INTO `wpWPP_postmeta` VALUES (157, 50, 'homepage_slider_image', '43') ; 
INSERT INTO `wpWPP_postmeta` VALUES (158, 50, '_homepage_slider_image', 'field_4') ; 
INSERT INTO `wpWPP_postmeta` VALUES (159, 50, 'background_color', '#E5411C') ; 
INSERT INTO `wpWPP_postmeta` VALUES (160, 50, '_background_color', 'field_5') ; 
INSERT INTO `wpWPP_postmeta` VALUES (161, 50, 'button_color', '#41301f') ; 
INSERT INTO `wpWPP_postmeta` VALUES (162, 50, '_button_color', 'field_6') ; 
INSERT INTO `wpWPP_postmeta` VALUES (163, 50, 'related_testimonials', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (164, 50, '_related_testimonials', 'field_7') ; 
INSERT INTO `wpWPP_postmeta` VALUES (165, 54, '_menu_item_type', 'post_type') ; 
INSERT INTO `wpWPP_postmeta` VALUES (166, 54, '_menu_item_menu_item_parent', '0') ; 
INSERT INTO `wpWPP_postmeta` VALUES (167, 54, '_menu_item_object_id', '6') ; 
INSERT INTO `wpWPP_postmeta` VALUES (168, 54, '_menu_item_object', 'page') ; 
INSERT INTO `wpWPP_postmeta` VALUES (169, 54, '_menu_item_target', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (170, 54, '_menu_item_classes', 'a:1:{i:0;s:0:"";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (171, 54, '_menu_item_xfn', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (172, 54, '_menu_item_url', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (174, 55, '_menu_item_type', 'post_type') ; 
INSERT INTO `wpWPP_postmeta` VALUES (175, 55, '_menu_item_menu_item_parent', '0') ; 
INSERT INTO `wpWPP_postmeta` VALUES (176, 55, '_menu_item_object_id', '7') ; 
INSERT INTO `wpWPP_postmeta` VALUES (177, 55, '_menu_item_object', 'page') ; 
INSERT INTO `wpWPP_postmeta` VALUES (178, 55, '_menu_item_target', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (179, 55, '_menu_item_classes', 'a:1:{i:0;s:0:"";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (180, 55, '_menu_item_xfn', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (181, 55, '_menu_item_url', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (183, 56, '_menu_item_type', 'post_type') ; 
INSERT INTO `wpWPP_postmeta` VALUES (184, 56, '_menu_item_menu_item_parent', '0') ; 
INSERT INTO `wpWPP_postmeta` VALUES (185, 56, '_menu_item_object_id', '9') ; 
INSERT INTO `wpWPP_postmeta` VALUES (186, 56, '_menu_item_object', 'page') ; 
INSERT INTO `wpWPP_postmeta` VALUES (187, 56, '_menu_item_target', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (188, 56, '_menu_item_classes', 'a:1:{i:0;s:0:"";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (189, 56, '_menu_item_xfn', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (190, 56, '_menu_item_url', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (192, 57, '_menu_item_type', 'post_type') ; 
INSERT INTO `wpWPP_postmeta` VALUES (193, 57, '_menu_item_menu_item_parent', '0') ; 
INSERT INTO `wpWPP_postmeta` VALUES (194, 57, '_menu_item_object_id', '11') ; 
INSERT INTO `wpWPP_postmeta` VALUES (195, 57, '_menu_item_object', 'page') ; 
INSERT INTO `wpWPP_postmeta` VALUES (196, 57, '_menu_item_target', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (197, 57, '_menu_item_classes', 'a:1:{i:0;s:0:"";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (198, 57, '_menu_item_xfn', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (199, 57, '_menu_item_url', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (201, 58, '_menu_item_type', 'post_type') ; 
INSERT INTO `wpWPP_postmeta` VALUES (202, 58, '_menu_item_menu_item_parent', '0') ; 
INSERT INTO `wpWPP_postmeta` VALUES (203, 58, '_menu_item_object_id', '10') ; 
INSERT INTO `wpWPP_postmeta` VALUES (204, 58, '_menu_item_object', 'page') ; 
INSERT INTO `wpWPP_postmeta` VALUES (205, 58, '_menu_item_target', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (206, 58, '_menu_item_classes', 'a:1:{i:0;s:0:"";}') ; 
INSERT INTO `wpWPP_postmeta` VALUES (207, 58, '_menu_item_xfn', '') ; 
INSERT INTO `wpWPP_postmeta` VALUES (208, 58, '_menu_item_url', '') ;
#
# End of data contents of table wpWPP_postmeta
# --------------------------------------------------------

# WordPress : http://localhost/allisongrayce.com MySQL database backup
#
# Generated: Thursday 18. April 2013 19:56 UTC
# Hostname: localhost
# Database: `wp_portfolio`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_commentmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_comments`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_links`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_options`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_postmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_posts`
# --------------------------------------------------------


#
# Delete any existing table `wpWPP_posts`
#

DROP TABLE IF EXISTS `wpWPP_posts`;


#
# Table structure of table `wpWPP_posts`
#

CREATE TABLE `wpWPP_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext NOT NULL,
  `post_title` text NOT NULL,
  `post_excerpt` text NOT NULL,
  `post_status` varchar(20) NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) NOT NULL DEFAULT 'open',
  `post_password` varchar(20) NOT NULL DEFAULT '',
  `post_name` varchar(200) NOT NULL DEFAULT '',
  `to_ping` text NOT NULL,
  `pinged` text NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 ;

#
# Data contents of table wpWPP_posts (51 records)
#
 
INSERT INTO `wpWPP_posts` VALUES (1, 1, '2013-02-06 21:19:22', '2013-02-06 21:19:22', 'Welcome to WordPress. This is your first post. Edit or delete it, then start blogging!', 'Hello world!', '', 'publish', 'open', 'open', '', 'hello-world', '', '', '2013-02-06 21:19:22', '2013-02-06 21:19:22', '', 0, 'http://localhost/allisongrayce.com/?p=1', 0, 'post', '', 1) ; 
INSERT INTO `wpWPP_posts` VALUES (2, 1, '2013-02-06 21:19:22', '2013-02-06 21:19:22', 'This is an example page. It\'s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:

<blockquote>Hi there! I\'m a bike messenger by day, aspiring actor by night, and this is my blog. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin\' caught in the rain.)</blockquote>

...or something like this:

<blockquote>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</blockquote>

As a new WordPress user, you should go to <a href="http://localhost/allisongrayce.com/wp-admin/">your dashboard</a> to delete this page and create new pages for your content. Have fun!', 'Sample Page', '', 'publish', 'open', 'open', '', 'sample-page', '', '', '2013-02-06 21:19:22', '2013-02-06 21:19:22', '', 0, 'http://localhost/allisongrayce.com/?page_id=2', 0, 'page', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (6, 1, '2013-02-06 21:22:14', '2013-02-06 21:22:14', 'Welcome to my site!', 'Home', '', 'publish', 'open', 'open', '', 'home', '', '', '2013-04-18 19:31:59', '2013-04-18 19:31:59', '', 0, 'http://localhost/allisongrayce.com/?page_id=6', 0, 'page', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (7, 1, '2013-02-06 21:22:27', '2013-02-06 21:22:27', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'About', '', 'publish', 'open', 'open', '', 'about', '', '', '2013-02-06 21:22:27', '2013-02-06 21:22:27', '', 0, 'http://localhost/allisongrayce.com/?page_id=7', 0, 'page', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (8, 1, '2013-02-06 21:22:22', '2013-02-06 21:22:22', '', 'About', '', 'inherit', 'open', 'open', '', '7-revision', '', '', '2013-02-06 21:22:22', '2013-02-06 21:22:22', '', 7, 'http://localhost/allisongrayce.com/?p=8', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (9, 1, '2013-02-06 21:22:40', '2013-02-06 21:22:40', '', 'Blog', '', 'publish', 'open', 'open', '', 'blog', '', '', '2013-02-06 21:22:40', '2013-02-06 21:22:40', '', 0, 'http://localhost/allisongrayce.com/?page_id=9', 0, 'page', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (10, 1, '2013-02-06 21:22:50', '2013-02-06 21:22:50', '', 'Work', '', 'publish', 'open', 'open', '', 'work', '', '', '2013-04-18 19:45:27', '2013-04-18 19:45:27', '', 0, 'http://localhost/allisongrayce.com/?page_id=10', 0, 'page', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (11, 1, '2013-02-06 21:23:20', '2013-02-06 21:23:20', '', 'Contact ', '', 'publish', 'open', 'closed', '', 'contact', '', '', '2013-04-18 19:37:49', '2013-04-18 19:37:49', '', 0, 'http://localhost/allisongrayce.com/?page_id=11', 0, 'page', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (12, 1, '2013-02-06 21:24:24', '2013-02-06 21:24:24', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'First Blog Post', '', 'publish', 'open', 'open', '', 'first-blog-post', '', '', '2013-02-06 21:24:24', '2013-02-06 21:24:24', '', 0, 'http://localhost/allisongrayce.com/?p=12', 0, 'post', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (13, 1, '2013-02-06 21:24:08', '2013-02-06 21:24:08', '', 'First Blog Post', '', 'inherit', 'open', 'open', '', '12-revision', '', '', '2013-02-06 21:24:08', '2013-02-06 21:24:08', '', 12, 'http://localhost/allisongrayce.com/?p=13', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (15, 1, '2013-02-06 21:24:43', '2013-02-06 21:24:43', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Second Blog Post', '', 'publish', 'open', 'open', '', 'second-blog-post', '', '', '2013-02-06 21:24:43', '2013-02-06 21:24:43', '', 0, 'http://localhost/allisongrayce.com/?p=15', 0, 'post', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (16, 1, '2013-02-06 21:24:41', '2013-02-06 21:24:41', '', 'Second Blog Post', '', 'inherit', 'open', 'open', '', '15-revision', '', '', '2013-02-06 21:24:41', '2013-02-06 21:24:41', '', 15, 'http://localhost/allisongrayce.com/?p=16', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (17, 1, '2013-02-06 21:24:54', '2013-02-06 21:24:54', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Third Blog Post', '', 'publish', 'open', 'open', '', 'third-blog-post', '', '', '2013-02-06 21:24:54', '2013-02-06 21:24:54', '', 0, 'http://localhost/allisongrayce.com/?p=17', 0, 'post', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (18, 1, '2013-02-06 21:24:50', '2013-02-06 21:24:50', '', 'Third Blog Post', '', 'inherit', 'open', 'open', '', '17-revision', '', '', '2013-02-06 21:24:50', '2013-02-06 21:24:50', '', 17, 'http://localhost/allisongrayce.com/?p=18', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (19, 1, '2013-02-06 21:39:20', '2013-02-06 21:39:20', '', 'Work', '', 'publish', 'closed', 'closed', '', 'acf_work', '', '', '2013-02-06 21:47:54', '2013-02-06 21:47:54', '', 0, 'http://localhost/allisongrayce.com/?post_type=acf&#038;p=19', 0, 'acf', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (20, 1, '2013-02-06 21:46:24', '2013-02-06 21:46:24', '', 'Testimonials', '', 'publish', 'closed', 'closed', '', 'acf_testimonials', '', '', '2013-02-06 21:47:41', '2013-02-06 21:47:41', '', 0, 'http://localhost/allisongrayce.com/?post_type=acf&#038;p=20', 0, 'acf', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (25, 1, '2013-02-06 21:59:40', '2013-02-06 21:59:40', '', 'Shirts 4 Mike', '', 'publish', 'open', 'open', '', 'shirts-4-mike', '', '', '2013-02-06 22:01:16', '2013-02-06 22:01:16', '', 0, 'http://localhost/allisongrayce.com/?post_type=work&#038;p=25', 0, 'work', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (26, 1, '2013-02-06 21:58:22', '2013-02-06 21:58:22', '', 'Shirt 4 Mike - Homepage Slider', '', 'inherit', 'open', 'open', '', 'shirts4mike-homepage-image', '', '', '2013-02-06 21:58:22', '2013-02-06 21:58:22', '', 25, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/02/shirts4mike-homepage-image.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (27, 1, '2013-02-06 21:57:38', '2013-02-06 21:57:38', '', 'Shirts 4 Mike', '', 'inherit', 'open', 'open', '', '25-revision', '', '', '2013-02-06 21:57:38', '2013-02-06 21:57:38', '', 25, 'http://localhost/allisongrayce.com/?p=27', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (28, 1, '2013-02-06 22:01:03', '2013-02-06 22:01:03', '', 'Mike The Frog', '', 'publish', 'open', 'open', '', 'mike-the-frog', '', '', '2013-02-06 22:01:03', '2013-02-06 22:01:03', '', 0, 'http://localhost/allisongrayce.com/?post_type=testimonials&#038;p=28', 0, 'testimonials', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (29, 1, '2013-02-06 22:00:00', '2013-02-06 22:00:00', '', 'Mike The Frog', '', 'inherit', 'open', 'open', '', '28-revision', '', '', '2013-02-06 22:00:00', '2013-02-06 22:00:00', '', 28, 'http://localhost/allisongrayce.com/?p=29', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (30, 1, '2013-02-06 21:59:40', '2013-02-06 21:59:40', '', 'Shirts 4 Mike', '', 'inherit', 'open', 'open', '', '25-revision-2', '', '', '2013-02-06 21:59:40', '2013-02-06 21:59:40', '', 25, 'http://localhost/allisongrayce.com/?p=30', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (32, 1, '2013-04-18 19:19:42', '0000-00-00 00:00:00', '', 'Auto Draft', '', 'auto-draft', 'open', 'open', '', '', '', '', '2013-04-18 19:19:42', '0000-00-00 00:00:00', '', 0, 'http://localhost/allisongrayce.com/?p=32', 0, 'post', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (33, 1, '2013-04-18 19:22:38', '2013-04-18 19:22:38', '', 'Smells Like Bakin\'', '', 'publish', 'open', 'open', '', 'smells-like-bakin', '', '', '2013-04-18 19:22:38', '2013-04-18 19:22:38', '', 0, 'http://localhost/allisongrayce.com/?post_type=work&#038;p=33', 0, 'work', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (34, 1, '2013-04-18 19:21:52', '2013-04-18 19:21:52', '', 'Dr Wattz. Blog Slideshow Image', '', 'inherit', 'open', 'open', '', 'drwattz-homepage-image', '', '', '2013-04-18 19:21:52', '2013-04-18 19:21:52', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/drwattz-homepage-image.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (35, 1, '2013-04-18 19:21:52', '2013-04-18 19:21:52', '', 'drwattz-one', '', 'inherit', 'open', 'open', '', 'drwattz-one', '', '', '2013-04-18 19:21:52', '2013-04-18 19:21:52', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/drwattz-one.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (36, 1, '2013-04-18 19:21:53', '2013-04-18 19:21:53', '', 'drwattz-three', '', 'inherit', 'open', 'open', '', 'drwattz-three', '', '', '2013-04-18 19:21:53', '2013-04-18 19:21:53', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/drwattz-three.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (37, 1, '2013-04-18 19:21:53', '2013-04-18 19:21:53', '', 'drwattz-two', '', 'inherit', 'open', 'open', '', 'drwattz-two', '', '', '2013-04-18 19:21:53', '2013-04-18 19:21:53', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/drwattz-two.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (38, 1, '2013-04-18 19:21:54', '2013-04-18 19:21:54', '', 'shirts4mike-homepage-image', '', 'inherit', 'open', 'open', '', 'shirts4mike-homepage-image-2', '', '', '2013-04-18 19:21:54', '2013-04-18 19:21:54', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/shirts4mike-homepage-image.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (39, 1, '2013-04-18 19:21:54', '2013-04-18 19:21:54', '', 'shirts4mike-one', '', 'inherit', 'open', 'open', '', 'shirts4mike-one', '', '', '2013-04-18 19:21:54', '2013-04-18 19:21:54', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/shirts4mike-one.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (40, 1, '2013-04-18 19:21:55', '2013-04-18 19:21:55', '', 'shirts4mike-two', '', 'inherit', 'open', 'open', '', 'shirts4mike-two', '', '', '2013-04-18 19:21:55', '2013-04-18 19:21:55', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/shirts4mike-two.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (41, 1, '2013-04-18 19:21:55', '2013-04-18 19:21:55', '', 'Smells Like Bakin Slideshow Image', '', 'inherit', 'open', 'open', '', 'smells-like-bakin-homepage-image', '', '', '2013-04-18 19:21:55', '2013-04-18 19:21:55', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/smells-like-bakin-homepage-image.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (42, 1, '2013-04-18 19:21:56', '2013-04-18 19:21:56', '', 'smells-like-bakin-one', '', 'inherit', 'open', 'open', '', 'smells-like-bakin-one', '', '', '2013-04-18 19:21:56', '2013-04-18 19:21:56', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/smells-like-bakin-one.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (43, 1, '2013-04-18 19:21:57', '2013-04-18 19:21:57', '', 'Stop Visual Pollution Slideshow Image', '', 'inherit', 'open', 'open', '', 'stopvisualpollution-homepage-image', '', '', '2013-04-18 19:21:57', '2013-04-18 19:21:57', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/stopvisualpollution-homepage-image.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (44, 1, '2013-04-18 19:21:57', '2013-04-18 19:21:57', '', 'stopvisualpollution-one', '', 'inherit', 'open', 'open', '', 'stopvisualpollution-one', '', '', '2013-04-18 19:21:57', '2013-04-18 19:21:57', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/stopvisualpollution-one.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (45, 1, '2013-04-18 19:21:58', '2013-04-18 19:21:58', '', 'stopvisualpollution-three', '', 'inherit', 'open', 'open', '', 'stopvisualpollution-three', '', '', '2013-04-18 19:21:58', '2013-04-18 19:21:58', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/stopvisualpollution-three.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (46, 1, '2013-04-18 19:21:58', '2013-04-18 19:21:58', '', 'stopvisualpollution-two', '', 'inherit', 'open', 'open', '', 'stopvisualpollution-two', '', '', '2013-04-18 19:21:58', '2013-04-18 19:21:58', '', 33, 'http://localhost/allisongrayce.com/wp-content/uploads/2013/04/stopvisualpollution-two.png', 0, 'attachment', 'image/png', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (47, 1, '2013-04-18 19:21:07', '2013-04-18 19:21:07', '', 'Smells Like Bakin\'', '', 'inherit', 'open', 'open', '', '33-revision', '', '', '2013-04-18 19:21:07', '2013-04-18 19:21:07', '', 33, 'http://localhost/allisongrayce.com/?p=47', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (48, 1, '2013-04-18 19:26:21', '2013-04-18 19:26:21', '', 'Dr. Wattz', '', 'publish', 'open', 'open', '', 'dr-wattz', '', '', '2013-04-18 19:26:21', '2013-04-18 19:26:21', '', 0, 'http://localhost/allisongrayce.com/?post_type=work&#038;p=48', 0, 'work', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (49, 1, '2013-04-18 19:25:28', '2013-04-18 19:25:28', '', 'Dr. Wattz', '', 'inherit', 'open', 'open', '', '48-revision', '', '', '2013-04-18 19:25:28', '2013-04-18 19:25:28', '', 48, 'http://localhost/allisongrayce.com/?p=49', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (50, 1, '2013-04-18 19:27:17', '2013-04-18 19:27:17', '', 'Stop Visual Pollution', '', 'publish', 'open', 'open', '', 'stop-visual-pollution', '', '', '2013-04-18 19:27:17', '2013-04-18 19:27:17', '', 0, 'http://localhost/allisongrayce.com/?post_type=work&#038;p=50', 0, 'work', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (51, 1, '2013-04-18 19:26:30', '2013-04-18 19:26:30', '', 'Stop Visual Pollution', '', 'inherit', 'open', 'open', '', '50-revision', '', '', '2013-04-18 19:26:30', '2013-04-18 19:26:30', '', 50, 'http://localhost/allisongrayce.com/?p=51', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (52, 1, '2013-04-18 19:28:21', '2013-04-18 19:28:21', '', 'Stop Visual Pollution', '', 'inherit', 'open', 'open', '', '50-autosave', '', '', '2013-04-18 19:28:21', '2013-04-18 19:28:21', '', 50, 'http://localhost/allisongrayce.com/?p=52', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (53, 1, '2013-02-06 21:22:14', '2013-02-06 21:22:14', '', 'Home', '', 'inherit', 'open', 'open', '', '6-revision', '', '', '2013-02-06 21:22:14', '2013-02-06 21:22:14', '', 6, 'http://localhost/allisongrayce.com/6-revision/', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (54, 1, '2013-04-18 19:37:39', '2013-04-18 19:37:39', ' ', '', '', 'publish', 'open', 'open', '', '54', '', '', '2013-04-18 19:37:39', '2013-04-18 19:37:39', '', 0, 'http://localhost/allisongrayce.com/?p=54', 1, 'nav_menu_item', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (55, 1, '2013-04-18 19:37:39', '2013-04-18 19:37:39', ' ', '', '', 'publish', 'open', 'open', '', '55', '', '', '2013-04-18 19:37:39', '2013-04-18 19:37:39', '', 0, 'http://localhost/allisongrayce.com/?p=55', 2, 'nav_menu_item', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (56, 1, '2013-04-18 19:37:39', '2013-04-18 19:37:39', ' ', '', '', 'publish', 'open', 'open', '', '56', '', '', '2013-04-18 19:37:39', '2013-04-18 19:37:39', '', 0, 'http://localhost/allisongrayce.com/?p=56', 3, 'nav_menu_item', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (57, 1, '2013-04-18 19:37:39', '2013-04-18 19:37:39', ' ', '', '', 'publish', 'open', 'open', '', '57', '', '', '2013-04-18 19:37:39', '2013-04-18 19:37:39', '', 0, 'http://localhost/allisongrayce.com/?p=57', 5, 'nav_menu_item', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (58, 1, '2013-04-18 19:37:39', '2013-04-18 19:37:39', ' ', '', '', 'publish', 'open', 'open', '', '58', '', '', '2013-04-18 19:37:39', '2013-04-18 19:37:39', '', 0, 'http://localhost/allisongrayce.com/?p=58', 4, 'nav_menu_item', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (59, 1, '2013-02-06 21:23:20', '2013-02-06 21:23:20', '', 'Contact Page', '', 'inherit', 'open', 'open', '', '11-revision', '', '', '2013-02-06 21:23:20', '2013-02-06 21:23:20', '', 11, 'http://localhost/allisongrayce.com/11-revision/', 0, 'revision', '', 0) ; 
INSERT INTO `wpWPP_posts` VALUES (60, 1, '2013-02-06 21:22:50', '2013-02-06 21:22:50', '', 'Work', '', 'inherit', 'open', 'open', '', '10-revision', '', '', '2013-02-06 21:22:50', '2013-02-06 21:22:50', '', 10, 'http://localhost/allisongrayce.com/10-revision/', 0, 'revision', '', 0) ;
#
# End of data contents of table wpWPP_posts
# --------------------------------------------------------

# WordPress : http://localhost/allisongrayce.com MySQL database backup
#
# Generated: Thursday 18. April 2013 19:56 UTC
# Hostname: localhost
# Database: `wp_portfolio`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_commentmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_comments`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_links`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_options`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_postmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_posts`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_term_relationships`
# --------------------------------------------------------


#
# Delete any existing table `wpWPP_term_relationships`
#

DROP TABLE IF EXISTS `wpWPP_term_relationships`;


#
# Table structure of table `wpWPP_term_relationships`
#

CREATE TABLE `wpWPP_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

#
# Data contents of table wpWPP_term_relationships (9 records)
#
 
INSERT INTO `wpWPP_term_relationships` VALUES (1, 1, 0) ; 
INSERT INTO `wpWPP_term_relationships` VALUES (12, 2, 0) ; 
INSERT INTO `wpWPP_term_relationships` VALUES (15, 1, 0) ; 
INSERT INTO `wpWPP_term_relationships` VALUES (17, 2, 0) ; 
INSERT INTO `wpWPP_term_relationships` VALUES (54, 3, 0) ; 
INSERT INTO `wpWPP_term_relationships` VALUES (55, 3, 0) ; 
INSERT INTO `wpWPP_term_relationships` VALUES (56, 3, 0) ; 
INSERT INTO `wpWPP_term_relationships` VALUES (57, 3, 0) ; 
INSERT INTO `wpWPP_term_relationships` VALUES (58, 3, 0) ;
#
# End of data contents of table wpWPP_term_relationships
# --------------------------------------------------------

# WordPress : http://localhost/allisongrayce.com MySQL database backup
#
# Generated: Thursday 18. April 2013 19:56 UTC
# Hostname: localhost
# Database: `wp_portfolio`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_commentmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_comments`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_links`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_options`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_postmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_posts`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_term_relationships`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_term_taxonomy`
# --------------------------------------------------------


#
# Delete any existing table `wpWPP_term_taxonomy`
#

DROP TABLE IF EXISTS `wpWPP_term_taxonomy`;


#
# Table structure of table `wpWPP_term_taxonomy`
#

CREATE TABLE `wpWPP_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ;

#
# Data contents of table wpWPP_term_taxonomy (3 records)
#
 
INSERT INTO `wpWPP_term_taxonomy` VALUES (1, 1, 'category', '', 0, 2) ; 
INSERT INTO `wpWPP_term_taxonomy` VALUES (2, 2, 'category', '', 0, 2) ; 
INSERT INTO `wpWPP_term_taxonomy` VALUES (3, 3, 'nav_menu', '', 0, 5) ;
#
# End of data contents of table wpWPP_term_taxonomy
# --------------------------------------------------------

# WordPress : http://localhost/allisongrayce.com MySQL database backup
#
# Generated: Thursday 18. April 2013 19:56 UTC
# Hostname: localhost
# Database: `wp_portfolio`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_commentmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_comments`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_links`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_options`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_postmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_posts`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_term_relationships`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_term_taxonomy`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_terms`
# --------------------------------------------------------


#
# Delete any existing table `wpWPP_terms`
#

DROP TABLE IF EXISTS `wpWPP_terms`;


#
# Table structure of table `wpWPP_terms`
#

CREATE TABLE `wpWPP_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `slug` varchar(200) NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ;

#
# Data contents of table wpWPP_terms (3 records)
#
 
INSERT INTO `wpWPP_terms` VALUES (1, 'Opinions', 'opinions', 0) ; 
INSERT INTO `wpWPP_terms` VALUES (2, 'Design', 'design', 0) ; 
INSERT INTO `wpWPP_terms` VALUES (3, 'Main Menu', 'main-menu', 0) ;
#
# End of data contents of table wpWPP_terms
# --------------------------------------------------------

# WordPress : http://localhost/allisongrayce.com MySQL database backup
#
# Generated: Thursday 18. April 2013 19:56 UTC
# Hostname: localhost
# Database: `wp_portfolio`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_commentmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_comments`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_links`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_options`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_postmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_posts`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_term_relationships`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_term_taxonomy`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_terms`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_usermeta`
# --------------------------------------------------------


#
# Delete any existing table `wpWPP_usermeta`
#

DROP TABLE IF EXISTS `wpWPP_usermeta`;


#
# Table structure of table `wpWPP_usermeta`
#

CREATE TABLE `wpWPP_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ;

#
# Data contents of table wpWPP_usermeta (22 records)
#
 
INSERT INTO `wpWPP_usermeta` VALUES (1, 1, 'first_name', '') ; 
INSERT INTO `wpWPP_usermeta` VALUES (2, 1, 'last_name', '') ; 
INSERT INTO `wpWPP_usermeta` VALUES (3, 1, 'nickname', 'treehouse') ; 
INSERT INTO `wpWPP_usermeta` VALUES (4, 1, 'description', '') ; 
INSERT INTO `wpWPP_usermeta` VALUES (5, 1, 'rich_editing', 'true') ; 
INSERT INTO `wpWPP_usermeta` VALUES (6, 1, 'comment_shortcuts', 'false') ; 
INSERT INTO `wpWPP_usermeta` VALUES (7, 1, 'admin_color', 'fresh') ; 
INSERT INTO `wpWPP_usermeta` VALUES (8, 1, 'use_ssl', '0') ; 
INSERT INTO `wpWPP_usermeta` VALUES (9, 1, 'show_admin_bar_front', 'true') ; 
INSERT INTO `wpWPP_usermeta` VALUES (10, 1, 'wpWPP_capabilities', 'a:1:{s:13:"administrator";b:1;}') ; 
INSERT INTO `wpWPP_usermeta` VALUES (11, 1, 'wpWPP_user_level', '10') ; 
INSERT INTO `wpWPP_usermeta` VALUES (12, 1, 'dismissed_wp_pointers', 'wp330_toolbar,wp330_saving_widgets,wp340_choose_image_from_library,wp340_customize_current_theme_link,wp350_media') ; 
INSERT INTO `wpWPP_usermeta` VALUES (13, 1, 'show_welcome_panel', '0') ; 
INSERT INTO `wpWPP_usermeta` VALUES (14, 1, 'wpWPP_dashboard_quick_press_last_post_id', '32') ; 
INSERT INTO `wpWPP_usermeta` VALUES (15, 1, 'wpWPP_user-settings', 'libraryContent=browse&imgsize=large&urlbutton=none') ; 
INSERT INTO `wpWPP_usermeta` VALUES (16, 1, 'wpWPP_user-settings-time', '1366312777') ; 
INSERT INTO `wpWPP_usermeta` VALUES (17, 1, 'meta-box-order_dashboard', 'a:4:{s:6:"normal";s:88:"dashboard_right_now,dashboard_recent_comments,dashboard_incoming_links,dashboard_plugins";s:4:"side";s:83:"dashboard_quick_press,dashboard_recent_drafts,dashboard_primary,dashboard_secondary";s:7:"column3";s:0:"";s:7:"column4";s:0:"";}') ; 
INSERT INTO `wpWPP_usermeta` VALUES (18, 1, 'screen_layout_dashboard', '2') ; 
INSERT INTO `wpWPP_usermeta` VALUES (19, 1, 'closedpostboxes_work', 'a:0:{}') ; 
INSERT INTO `wpWPP_usermeta` VALUES (20, 1, 'metaboxhidden_work', 'a:8:{i:0;s:13:"pageparentdiv";i:1;s:6:"acf_20";i:2;s:11:"postexcerpt";i:3;s:13:"trackbacksdiv";i:4;s:10:"postcustom";i:5;s:16:"commentstatusdiv";i:6;s:7:"slugdiv";i:7;s:9:"authordiv";}') ; 
INSERT INTO `wpWPP_usermeta` VALUES (21, 1, 'managenav-menuscolumnshidden', 'a:4:{i:0;s:11:"link-target";i:1;s:11:"css-classes";i:2;s:3:"xfn";i:3;s:11:"description";}') ; 
INSERT INTO `wpWPP_usermeta` VALUES (22, 1, 'metaboxhidden_nav-menus', 'a:4:{i:0;s:8:"add-post";i:1;s:8:"add-work";i:2;s:16:"add-testimonials";i:3;s:12:"add-post_tag";}') ;
#
# End of data contents of table wpWPP_usermeta
# --------------------------------------------------------

# WordPress : http://localhost/allisongrayce.com MySQL database backup
#
# Generated: Thursday 18. April 2013 19:56 UTC
# Hostname: localhost
# Database: `wp_portfolio`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_commentmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_comments`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_links`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_options`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_postmeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_posts`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_term_relationships`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_term_taxonomy`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_terms`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_usermeta`
# --------------------------------------------------------
# --------------------------------------------------------
# Table: `wpWPP_users`
# --------------------------------------------------------


#
# Delete any existing table `wpWPP_users`
#

DROP TABLE IF EXISTS `wpWPP_users`;


#
# Table structure of table `wpWPP_users`
#

CREATE TABLE `wpWPP_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '',
  `user_pass` varchar(64) NOT NULL DEFAULT '',
  `user_nicename` varchar(50) NOT NULL DEFAULT '',
  `user_email` varchar(100) NOT NULL DEFAULT '',
  `user_url` varchar(100) NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ;

#
# Data contents of table wpWPP_users (1 records)
#
 
INSERT INTO `wpWPP_users` VALUES (1, 'treehouse', 'e56e22e5b8acf5b9d47f7d77ad6d1b51', 'treehouse', 'zac@teamtreehouse.com', '', '2013-02-06 21:19:22', '', 0, 'treehouse') ;

#
# End of data contents of table wpWPP_users
# --------------------------------------------------------

