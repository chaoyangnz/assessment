-- MySQL dump 10.13  Distrib 5.5.27, for Win32 (x86)
--
-- Host: localhost    Database: assessment_dev
-- ------------------------------------------------------
-- Server version	5.5.27

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
-- Table structure for table `choices`
--

DROP TABLE IF EXISTS `choices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `choices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `weight` varchar(255) DEFAULT NULL,
  `is_answer` tinyint(1) DEFAULT NULL,
  `node_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `choices`
--

LOCK TABLES `choices` WRITE;
/*!40000 ALTER TABLE `choices` DISABLE KEYS */;
INSERT INTO `choices` VALUES (1,'しょうご',NULL,NULL,2),(2,'しょうごう',NULL,1,2),(3,'そうご',NULL,NULL,2),(4,'そうごう',NULL,NULL,2),(5,'からくて',NULL,1,3),(6,'くさくて',NULL,NULL,3),(7,'にがくて',NULL,NULL,3),(8,'しぶくて',NULL,NULL,3),(9,'けいしき',NULL,1,4),(10,'けしき',NULL,NULL,4),(11,'けいいろ',NULL,NULL,4),(12,'けいろ',NULL,NULL,4),(13,'ととのえて',NULL,NULL,5),(14,'たくわえて',NULL,NULL,5),(15,'かかえて',NULL,1,5),(16,'そなえて',NULL,NULL,5),(17,'ぼうえん',NULL,1,6),(18,'ぼうさい',NULL,NULL,6),(19,'ほうえん',NULL,NULL,6),(20,'ほうさい',NULL,NULL,6),(21,'札義',NULL,NULL,8),(22,'札儀',NULL,NULL,8),(23,'礼義',NULL,1,8),(24,'礼儀',NULL,NULL,8),(25,'出成',NULL,1,9),(26,'出世',NULL,NULL,9),(27,'昇成',NULL,NULL,9),(28,'昇世',NULL,NULL,9),(29,'アパートの情報誌を買いに行く',NULL,NULL,11),(30,'不動産屋に行く',NULL,NULL,11),(31,'きぼうのじょうけんを書きだす',NULL,NULL,11),(32,'住みたいまちを歩く',NULL,NULL,11);
/*!40000 ALTER TABLE `choices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invitations`
--

DROP TABLE IF EXISTS `invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `used_by` int(11) DEFAULT NULL,
  `used_at` datetime DEFAULT NULL,
  `organizer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invitations`
--

LOCK TABLES `invitations` WRITE;
/*!40000 ALTER TABLE `invitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nodes`
--

DROP TABLE IF EXISTS `nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL DEFAULT 'question',
  `media` varchar(255) NOT NULL DEFAULT 'text',
  `content` varchar(255) NOT NULL,
  `depth` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `pattern` varchar(255) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `grade` int(11) DEFAULT NULL,
  `paper_id` int(11) NOT NULL,
  `node_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nodes`
--

LOCK TABLES `nodes` WRITE;
/*!40000 ALTER TABLE `nodes` DISABLE KEYS */;
INSERT INTO `nodes` VALUES (1,'material','text','問題１	＿＿＿の言葉の読み方として最もよいものを、１・２・３・４から一つ選びなさ',1,1,NULL,NULL,NULL,2,NULL),(2,'question','text','これからも様々な国との相互理解を深めていこうと思う。',2,1,'single-choice','3',2,2,1),(3,'question','text','この料理は辛くて食べられない。',2,2,'single-choice','1',2,2,1),(4,'question','text','晴れている日は、この山頂からすばらしい景色が見える。',2,3,'single-choice','2',2,2,1),(5,'question','text','このお金は、何かあったときに備えて残しておこう。',2,4,'single-choice','4',2,2,1),(6,'question','text','今から、防災訓練を行います。',2,5,'single-choice','2',2,2,1),(7,'material','text','問題２	＿＿＿の言葉を漢字で書くとき、最もよいものを１・２・３・４から一つ選びなさい。',1,2,NULL,NULL,NULL,2,NULL),(8,'question','text','彼はとてもれいぎ正しいです。',2,6,'single-choice','4',2,2,7),(9,'question','text','彼は苦労を重ねて、社長にまでしゅっせした。',2,7,'single-choice','2',2,2,7),(10,'material','text','問題１では、まず質問を聞いてください。それから話を聞いて、問題用紙の１から４の中から、最もよいものを一つ選んでください。　',1,1,NULL,NULL,NULL,3,NULL),(11,'question','audio','/uploads/upload/file/1/5f493698fc06c120c9319b5c284b0ecc.mp3',2,1,'single-choice','4',2,3,10);
/*!40000 ALTER TABLE `nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `address` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `linkman` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_organizations_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations`
--

LOCK TABLES `organizations` WRITE;
/*!40000 ALTER TABLE `organizations` DISABLE KEYS */;
INSERT INTO `organizations` VALUES (1,'商贸通有限公司','上海','13585621135','杨超','2013-03-14 01:07:07','2013-03-14 08:27:17');
/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `papers`
--

DROP TABLE IF EXISTS `papers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `papers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL DEFAULT 'general',
  `name` varchar(255) NOT NULL,
  `notice` varchar(255) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `has_parts` tinyint(1) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `paper_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `papers`
--

LOCK TABLES `papers` WRITE;
/*!40000 ALTER TABLE `papers` DISABLE KEYS */;
INSERT INTO `papers` VALUES (1,'general','2010年7月日语N2','',400,145,NULL,'2013-03-14 05:09:04',1,'Japanese','assess','draft',NULL),(2,'partial','文字·词汇','',100,35,NULL,'2013-03-14 05:10:43',0,NULL,NULL,NULL,1),(3,'partial','听解','',100,40,NULL,'2013-03-14 05:11:42',0,NULL,NULL,NULL,1),(4,'partial','读解·语法','',200,70,NULL,'2013-03-14 05:42:05',0,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `papers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20130301014659'),('20130301014947'),('20130301015045'),('20130301020241'),('20130304052307'),('20130311065857'),('20130313074015');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mode` varchar(255) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `ended_at` datetime DEFAULT NULL,
  `finish_reason` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `paper_id` int(11) DEFAULT NULL,
  `part_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_details`
--

DROP TABLE IF EXISTS `test_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mark_flag` tinyint(1) DEFAULT NULL,
  `test_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `choice_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_details`
--

LOCK TABLES `test_details` WRITE;
/*!40000 ALTER TABLE `test_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uploads`
--

DROP TABLE IF EXISTS `uploads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uploads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `original_name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uploads`
--

LOCK TABLES `uploads` WRITE;
/*!40000 ALTER TABLE `uploads` DISABLE KEYS */;
INSERT INTO `uploads` VALUES (1,'5f493698fc06c120c9319b5c284b0ecc.mp3','audio','N2-1.mp3','2013-03-14 07:23:10','2013-03-14 07:23:10');
/*!40000 ALTER TABLE `uploads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `invitation_token` varchar(60) DEFAULT NULL,
  `invitation_sent_at` datetime DEFAULT NULL,
  `invitation_accepted_at` datetime DEFAULT NULL,
  `invitation_limit` int(11) DEFAULT '0',
  `invited_by_id` int(11) DEFAULT NULL,
  `invited_by_type` varchar(255) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jock.yang@gmail.com','$2a$10$.6jLuQYgZKGCl507DLaMnenIIoyu3/31gTjOZIvs98iKcLqPr2hJe',NULL,NULL,NULL,9,'2013-03-14 08:09:37','2013-03-14 07:13:57','127.0.0.1','127.0.0.1','2013-03-14 00:59:39','2013-03-14 08:09:37','root','jock',NULL,NULL,NULL,0,NULL,NULL,NULL),(2,'yangc@hadue.com','$2a$10$r.K6vQyGXGPdkCMl9c8YH.JJhk8u.QRmaAUsk0K16v3hBZ2Tlj8H2',NULL,NULL,NULL,3,'2013-03-14 02:39:30','2013-03-14 01:46:15','127.0.0.1','127.0.0.1','2013-03-14 01:07:07','2013-03-14 02:39:30','admin','yangc',NULL,NULL,NULL,0,NULL,NULL,1),(3,'lihao@hadue.com','',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'2013-03-14 01:07:58','2013-03-14 01:16:46','member',NULL,'AqeDxxAeqB6RVkw9GAka','2013-03-14 01:16:46',NULL,0,NULL,NULL,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-03-14 17:06:33
