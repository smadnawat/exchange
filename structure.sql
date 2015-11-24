-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: exchange_app
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `active_admin_comments`
--

DROP TABLE IF EXISTS `active_admin_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_admin_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namespace` varchar(255) DEFAULT NULL,
  `body` text,
  `resource_id` varchar(255) NOT NULL,
  `resource_type` varchar(255) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `author_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_active_admin_comments_on_namespace` (`namespace`),
  KEY `index_active_admin_comments_on_author_type_and_author_id` (`author_type`,`author_id`),
  KEY `index_active_admin_comments_on_resource_type_and_resource_id` (`resource_type`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_admin_users_on_email` (`email`),
  UNIQUE KEY `index_admin_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `biography` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=3276 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `banner_name` varchar(255) DEFAULT NULL,
  `author_name` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `clicks` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_blocks_on_group_id` (`group_id`),
  CONSTRAINT `fk_rails_77c11e1e8f` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `author` varchar(255) NOT NULL,
  `author_id` int(11) NOT NULL,
  `author_bio` mediumtext NOT NULL,
  `authors` varchar(255) NOT NULL,
  `title_slug` varchar(255) NOT NULL,
  `author_slug` varchar(255) NOT NULL,
  `isbn13` varchar(255) NOT NULL,
  `isbn10` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `format` varchar(255) NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `pubdate` varchar(255) NOT NULL,
  `edition` varchar(255) NOT NULL,
  `subjects` varchar(255) NOT NULL,
  `lexile` varchar(255) NOT NULL,
  `pages` varchar(255) NOT NULL,
  `dimensions` varchar(255) NOT NULL,
  `overview` mediumtext NOT NULL,
  `excerpt` mediumtext NOT NULL,
  `synopsis` text NOT NULL,
  `toc` mediumtext NOT NULL,
  `editorial_reviews` mediumtext NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn13` (`isbn13`),
  KEY `title_slug` (`title_slug`),
  KEY `author_slug` (`author_slug`),
  KEY `isbn10` (`isbn10`),
  KEY `author_id` (`author_id`),
  KEY `index_book_on_subjects` (`subjects`),
  KEY `subjects` (`subjects`) USING BTREE,
  KEY `title` (`title`(10)) USING BTREE,
  KEY `author` (`author`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=18392991 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book2subjects`
--

DROP TABLE IF EXISTS `book2subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book2subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book` int(11) NOT NULL,
  `sub_subject` int(11) NOT NULL,
  `sub_sub_subject` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `book` (`book`,`sub_subject`,`sub_sub_subject`),
  KEY `sub_subject` (`sub_subject`,`sub_sub_subject`),
  KEY `sub_sub_subject` (`sub_sub_subject`)
) ENGINE=MyISAM AUTO_INCREMENT=5472808 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_old`
--

DROP TABLE IF EXISTS `book_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_old` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `author` varchar(255) NOT NULL,
  `author_id` int(11) NOT NULL,
  `author_bio` mediumtext NOT NULL,
  `authors` varchar(255) NOT NULL,
  `title_slug` varchar(255) NOT NULL,
  `author_slug` varchar(255) NOT NULL,
  `isbn13` varchar(255) NOT NULL,
  `isbn10` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `format` varchar(255) NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `pubdate` varchar(255) NOT NULL,
  `edition` varchar(255) NOT NULL,
  `subjects` varchar(255) NOT NULL,
  `lexile` varchar(255) NOT NULL,
  `pages` varchar(255) NOT NULL,
  `dimensions` varchar(255) NOT NULL,
  `overview` mediumtext NOT NULL,
  `excerpt` mediumtext NOT NULL,
  `synopsis` text NOT NULL,
  `toc` mediumtext NOT NULL,
  `editorial_reviews` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn13` (`isbn13`),
  KEY `title_slug` (`title_slug`),
  KEY `author_slug` (`author_slug`),
  KEY `isbn10` (`isbn10`),
  KEY `author_id` (`author_id`),
  KEY `subjects` (`subjects`) USING BTREE,
  KEY `title` (`title`(10)) USING BTREE,
  KEY `author` (`author`) USING BTREE,
  KEY `index_book_old_on_subjects` (`subjects`)
) ENGINE=MyISAM AUTO_INCREMENT=18392991 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text COLLATE utf8_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `genre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `upload_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `latitude` float NOT NULL DEFAULT '0',
  `longitude` float NOT NULL DEFAULT '0',
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `upload_date` datetime DEFAULT NULL,
  `upload_date_for_admin` date DEFAULT NULL,
  `isbn13` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `about_us` text COLLATE utf8_unicode_ci,
  `country_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=331 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_us`
--

DROP TABLE IF EXISTS `contact_us`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_us` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `author_code` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_devices_on_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `fk_rails_410b63ef65` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=977 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `get_book_id` int(11) DEFAULT NULL,
  `give_book_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `get_preference` int(11) DEFAULT NULL,
  `give_preference` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invitations`
--

DROP TABLE IF EXISTS `invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `invitation_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attendee` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `book_to_get` int(11) DEFAULT NULL,
  `book_to_give` int(11) DEFAULT NULL,
  `invitation_status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_invitations_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_7eae413fe6` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text,
  `sender_id` int(11) DEFAULT NULL,
  `media` varchar(255) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_send` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_messages_on_group_id` (`group_id`),
  CONSTRAINT `fk_rails_841b0ae6ac` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=675 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices`
--

DROP TABLE IF EXISTS `notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `action_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reciever_id` int(11) DEFAULT NULL,
  `pending` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `invitation_id` int(11) DEFAULT NULL,
  `book_to_give` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_notices_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_984b9c27bc` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) DEFAULT NULL,
  `content` text,
  `location` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `all` varchar(255) DEFAULT NULL,
  `sub_locations` varchar(255) DEFAULT '{}',
  `sub_authors` varchar(255) DEFAULT '{}',
  `sub_genres` varchar(255) DEFAULT '{}',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `privacy_policies`
--

DROP TABLE IF EXISTS `privacy_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privacy_policies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `insights` float DEFAULT NULL,
  `contributor` float DEFAULT NULL,
  `social` float DEFAULT NULL,
  `overallexperience` float DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `ratable_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ratings_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_a7dfeb9f5f` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reading_preferences`
--

DROP TABLE IF EXISTS `reading_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reading_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text COLLATE utf8_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `genre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `book_deactivated` tinyint(1) DEFAULT '0',
  `author_deactivated` tinyint(1) DEFAULT '0',
  `genre_deactivated` tinyint(1) DEFAULT '0',
  `isbn13` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delete_author` tinyint(1) DEFAULT '0',
  `delete_genre` tinyint(1) DEFAULT '0',
  `by_scanning` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_reading_preferences_on_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `fk_rails_3c3c94ad8f` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=880 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scanning_subjects`
--

DROP TABLE IF EXISTS `scanning_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scanning_subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sub_sub_subject`
--

DROP TABLE IF EXISTS `sub_sub_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_sub_subject` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `sub_subject` smallint(6) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sub_subject` (`sub_subject`,`slug`),
  KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=9771 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sub_subject`
--

DROP TABLE IF EXISTS `sub_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_subject` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `subject` smallint(6) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject` (`subject`,`slug`),
  KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=851 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `terms_and_conditions`
--

DROP TABLE IF EXISTS `terms_and_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terms_and_conditions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user_groups_on_user_id` (`user_id`),
  KEY `index_user_groups_on_group_id` (`group_id`),
  CONSTRAINT `fk_rails_6d478d2f65` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  CONSTRAINT `fk_rails_c298be7f8b` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_digest` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author_prefernce` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `genre_preference` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_signup` date DEFAULT NULL,
  `picture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `latitude` float NOT NULL DEFAULT '0',
  `longitude` float NOT NULL DEFAULT '0',
  `provider` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `u_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `device_used` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `about_me` text COLLATE utf8_unicode_ci,
  `is_block` tinyint(1) DEFAULT '0',
  `weekly_date` date DEFAULT NULL,
  `notification_status` tinyint(1) DEFAULT '1',
  `sign_in_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mat_books_count` int(11) DEFAULT '0',
  `mat_author_count` int(11) DEFAULT '0',
  `mat_genre_count` int(11) DEFAULT '0',
  `within_five_km` int(11) DEFAULT '0',
  `date_within_five_km` date DEFAULT NULL,
  `mat_email_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_subscribe` tinyint(1) DEFAULT '1',
  `unsubscription_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-06 12:20:32
INSERT INTO schema_migrations (version) VALUES ('20150529062602');

INSERT INTO schema_migrations (version) VALUES ('20150529063228');

INSERT INTO schema_migrations (version) VALUES ('20150529063246');

INSERT INTO schema_migrations (version) VALUES ('20150529071234');

INSERT INTO schema_migrations (version) VALUES ('20150529071948');

INSERT INTO schema_migrations (version) VALUES ('20150529072750');

INSERT INTO schema_migrations (version) VALUES ('20150529092047');

INSERT INTO schema_migrations (version) VALUES ('20150529092105');

INSERT INTO schema_migrations (version) VALUES ('20150601044006');

INSERT INTO schema_migrations (version) VALUES ('20150601044011');

INSERT INTO schema_migrations (version) VALUES ('20150601050550');

INSERT INTO schema_migrations (version) VALUES ('20150601052441');

INSERT INTO schema_migrations (version) VALUES ('20150601055248');

INSERT INTO schema_migrations (version) VALUES ('20150602063117');

INSERT INTO schema_migrations (version) VALUES ('20150602102246');

INSERT INTO schema_migrations (version) VALUES ('20150602102343');

INSERT INTO schema_migrations (version) VALUES ('20150602123910');

INSERT INTO schema_migrations (version) VALUES ('20150604133518');

INSERT INTO schema_migrations (version) VALUES ('20150604133620');

INSERT INTO schema_migrations (version) VALUES ('20150604133723');

INSERT INTO schema_migrations (version) VALUES ('20150604133754');

INSERT INTO schema_migrations (version) VALUES ('20150604145753');

INSERT INTO schema_migrations (version) VALUES ('20150611044826');

INSERT INTO schema_migrations (version) VALUES ('20150615061252');

INSERT INTO schema_migrations (version) VALUES ('20150615061801');

INSERT INTO schema_migrations (version) VALUES ('20150616111456');

INSERT INTO schema_migrations (version) VALUES ('20150616121407');

INSERT INTO schema_migrations (version) VALUES ('20150617084749');

INSERT INTO schema_migrations (version) VALUES ('20150617085009');

INSERT INTO schema_migrations (version) VALUES ('20150617085100');

INSERT INTO schema_migrations (version) VALUES ('20150617101258');

INSERT INTO schema_migrations (version) VALUES ('20150619070632');

INSERT INTO schema_migrations (version) VALUES ('20150619070728');

INSERT INTO schema_migrations (version) VALUES ('20150622083757');

INSERT INTO schema_migrations (version) VALUES ('20150622090801');

INSERT INTO schema_migrations (version) VALUES ('20150622091031');

INSERT INTO schema_migrations (version) VALUES ('20150622091437');

INSERT INTO schema_migrations (version) VALUES ('20150622092511');

INSERT INTO schema_migrations (version) VALUES ('20150622092701');

INSERT INTO schema_migrations (version) VALUES ('20150624063441');

INSERT INTO schema_migrations (version) VALUES ('20150624145748');

INSERT INTO schema_migrations (version) VALUES ('20150625051243');

INSERT INTO schema_migrations (version) VALUES ('20150626135123');

INSERT INTO schema_migrations (version) VALUES ('20150629115352');

INSERT INTO schema_migrations (version) VALUES ('20150629115939');

INSERT INTO schema_migrations (version) VALUES ('20150629121250');

INSERT INTO schema_migrations (version) VALUES ('20150629122804');

INSERT INTO schema_migrations (version) VALUES ('20150629123647');

INSERT INTO schema_migrations (version) VALUES ('20150629123809');

INSERT INTO schema_migrations (version) VALUES ('20150630043932');

INSERT INTO schema_migrations (version) VALUES ('20150630110438');

INSERT INTO schema_migrations (version) VALUES ('20150701062339');

INSERT INTO schema_migrations (version) VALUES ('20150702115750');

INSERT INTO schema_migrations (version) VALUES ('20150702120052');

INSERT INTO schema_migrations (version) VALUES ('20150704091309');

INSERT INTO schema_migrations (version) VALUES ('20150704114509');

INSERT INTO schema_migrations (version) VALUES ('20150707053121');

INSERT INTO schema_migrations (version) VALUES ('20150707142400');

INSERT INTO schema_migrations (version) VALUES ('20150708130359');

INSERT INTO schema_migrations (version) VALUES ('20150710053116');

INSERT INTO schema_migrations (version) VALUES ('20150716053416');

INSERT INTO schema_migrations (version) VALUES ('20150717100347');

INSERT INTO schema_migrations (version) VALUES ('20150723055947');

INSERT INTO schema_migrations (version) VALUES ('20150723060013');

INSERT INTO schema_migrations (version) VALUES ('20150723060029');

INSERT INTO schema_migrations (version) VALUES ('20150723085814');

INSERT INTO schema_migrations (version) VALUES ('20150724044225');

INSERT INTO schema_migrations (version) VALUES ('20150724065855');

INSERT INTO schema_migrations (version) VALUES ('20150727100349');

INSERT INTO schema_migrations (version) VALUES ('20150728051132');

INSERT INTO schema_migrations (version) VALUES ('20150728073748');

INSERT INTO schema_migrations (version) VALUES ('20150728073840');

INSERT INTO schema_migrations (version) VALUES ('20150728083808');

INSERT INTO schema_migrations (version) VALUES ('20150728083847');

INSERT INTO schema_migrations (version) VALUES ('20150728115208');

INSERT INTO schema_migrations (version) VALUES ('20150804053358');

INSERT INTO schema_migrations (version) VALUES ('20150804095711');

INSERT INTO schema_migrations (version) VALUES ('20150818130530');

INSERT INTO schema_migrations (version) VALUES ('20150902092502');

INSERT INTO schema_migrations (version) VALUES ('20150904093420');

INSERT INTO schema_migrations (version) VALUES ('20150905064458');

INSERT INTO schema_migrations (version) VALUES ('20150908130029');

INSERT INTO schema_migrations (version) VALUES ('20150908143318');

INSERT INTO schema_migrations (version) VALUES ('20150918095656');

INSERT INTO schema_migrations (version) VALUES ('20150921071455');

INSERT INTO schema_migrations (version) VALUES ('20151006134217');


