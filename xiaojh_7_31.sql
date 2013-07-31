-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.22


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema xiaojh
--

CREATE DATABASE IF NOT EXISTS xiaojh;
USE xiaojh;

--
-- Definition of table `activity`
--

DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tittle` varchar(200) NOT NULL,
  `text` text NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `video_url` varchar(250) DEFAULT NULL,
  `title_img_path` varchar(250) NOT NULL,
  `place` varchar(200) NOT NULL,
  `hold_club_id` int(11) DEFAULT NULL COMMENT '两个主办方外键只能有一个 看要不要用trigger',
  `hold_merchant_id` int(11) DEFAULT NULL,
  `organizer` varchar(500) NOT NULL,
  `heat` int(11) NOT NULL DEFAULT '0' COMMENT '热度 用trigger',
  `budget` varchar(100) NOT NULL,
  `status` varchar(45) NOT NULL COMMENT '申请,正在进行,结束',
  `talking_id` int(11) NOT NULL,
  `participant_count` int(11) NOT NULL DEFAULT '0' COMMENT '参加人数 触发器控制',
  PRIMARY KEY (`id`),
  KEY `fk_activity_club1` (`hold_club_id`),
  KEY `fk_activity_merchant1` (`hold_merchant_id`),
  KEY `fk_activity_talking1` (`talking_id`),
  CONSTRAINT `fk_activity_club1` FOREIGN KEY (`hold_club_id`) REFERENCES `club` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_merchant1` FOREIGN KEY (`hold_merchant_id`) REFERENCES `merchant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_talking1` FOREIGN KEY (`talking_id`) REFERENCES `talking` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `activity`
--

/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` (`id`,`tittle`,`text`,`datetime`,`video_url`,`title_img_path`,`place`,`hold_club_id`,`hold_merchant_id`,`organizer`,`heat`,`budget`,`status`,`talking_id`,`participant_count`) VALUES 
 (1,'第一个活动','第一个活动','2013-07-29 11:41:20','','/xiaojh/upload/images/20130729/114120070.jpg','',1,NULL,'',0,'','APPLY',1,0),
 (2,'第一个活动','第一个活动','2013-07-29 11:42:19','','/xiaojh/upload/images/20130729/114219762.jpg','',1,NULL,'',0,'','APPLY',1,0),
 (3,'第一个活动','第一个活动','2013-07-29 11:42:27','','/xiaojh/upload/images/20130729/114227708.jpg','',1,NULL,'',0,'','APPLY',1,0);
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;


--
-- Definition of table `activity_participant`
--

DROP TABLE IF EXISTS `activity_participant`;
CREATE TABLE `activity_participant` (
  `activity_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`activity_id`,`user_id`),
  KEY `fk_activity_has_user_user1` (`user_id`),
  KEY `fk_activity_has_user_activity1` (`activity_id`),
  CONSTRAINT `fk_activity_has_user_activity1` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_has_user_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `activity_participant`
--

/*!40000 ALTER TABLE `activity_participant` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_participant` ENABLE KEYS */;


--
-- Definition of trigger `add_participant_count`
--

DROP TRIGGER /*!50030 IF EXISTS */ `add_participant_count`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `add_participant_count` AFTER INSERT ON `activity_participant` FOR EACH ROW begin
    update activity set participant_count=participant_count + 1 where id=new.activity_id;
end $$

DELIMITER ;

--
-- Definition of table `activity_post`
--

DROP TABLE IF EXISTS `activity_post`;
CREATE TABLE `activity_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `praise_count` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `online_activity_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_post_user1` (`user_id`),
  KEY `fk_activity_post_online_activity1` (`online_activity_id`),
  CONSTRAINT `fk_activity_post_online_activity1` FOREIGN KEY (`online_activity_id`) REFERENCES `online_activity` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_user10` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `activity_post`
--

/*!40000 ALTER TABLE `activity_post` DISABLE KEYS */;
INSERT INTO `activity_post` (`id`,`text`,`datetime`,`praise_count`,`user_id`,`online_activity_id`,`title`) VALUES 
 (1,'test','2013-07-27 16:23:54',0,1,1,'test');
/*!40000 ALTER TABLE `activity_post` ENABLE KEYS */;


--
-- Definition of table `activity_post_comment`
--

DROP TABLE IF EXISTS `activity_post_comment`;
CREATE TABLE `activity_post_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `text` varchar(300) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activity_post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_post_comment_user1` (`user_id`),
  KEY `fk_activity_post_comment_activity_post1` (`activity_post_id`),
  CONSTRAINT `fk_activity_post_comment_activity_post1` FOREIGN KEY (`activity_post_id`) REFERENCES `activity_post` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_comment_user10` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `activity_post_comment`
--

/*!40000 ALTER TABLE `activity_post_comment` DISABLE KEYS */;
INSERT INTO `activity_post_comment` (`id`,`datetime`,`text`,`user_id`,`activity_post_id`) VALUES 
 (1,'2013-07-27 16:56:05','asdf',1,1),
 (2,'2013-07-27 16:56:11','asdf',1,1),
 (3,'2013-07-27 16:56:17','35',1,1),
 (4,'2013-07-27 16:56:19','2345',1,1),
 (5,'2013-07-27 16:56:22','234',1,1),
 (6,'2013-07-27 16:56:24','22',1,1),
 (7,'2013-07-27 16:56:26','444',1,1),
 (8,'2013-07-27 16:56:31','2222',1,1);
/*!40000 ALTER TABLE `activity_post_comment` ENABLE KEYS */;


--
-- Definition of table `advertisement`
--

DROP TABLE IF EXISTS `advertisement`;
CREATE TABLE `advertisement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img_path` varchar(250) NOT NULL,
  `type` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `text` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `advertisement`
--

/*!40000 ALTER TABLE `advertisement` DISABLE KEYS */;
/*!40000 ALTER TABLE `advertisement` ENABLE KEYS */;


--
-- Definition of table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(200) NOT NULL,
  `text` varchar(300) NOT NULL,
  `club_id` int(11) DEFAULT NULL COMMENT '有为社团通知,没有为全局通知',
  PRIMARY KEY (`id`),
  KEY `fk_announcement_club1` (`club_id`),
  CONSTRAINT `fk_announcement_club1` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `announcement`
--

/*!40000 ALTER TABLE `announcement` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcement` ENABLE KEYS */;


--
-- Definition of trigger `user_announcement`
--

DROP TRIGGER /*!50030 IF EXISTS */ `user_announcement`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `user_announcement` AFTER INSERT ON `announcement` FOR EACH ROW begin
    if new.club_id is null then
        update user set announcement_count=announcement_count + 1;
    else
        update user set announcement_count=announcement_count + 1 where id in (select user_id from club_member where club_id=new.club_id);
    end if;
end $$

DELIMITER ;

--
-- Definition of table `club`
--

DROP TABLE IF EXISTS `club`;
CREATE TABLE `club` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `introduction` text NOT NULL,
  `name` varchar(100) NOT NULL,
  `logo_path` varchar(250) NOT NULL,
  `liveness` int(11) NOT NULL DEFAULT '0' COMMENT '活跃度',
  `proprieter_user_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  `type` varchar(45) NOT NULL COMMENT '类型,全部写死(音乐类,体育类等)',
  `status` varchar(45) NOT NULL COMMENT '是否通过审核等',
  `member_number` int(11) NOT NULL DEFAULT '0' COMMENT '社团人数,触发器没弄',
  `brief_introduction` varchar(200) NOT NULL,
  `popularity` int(11) NOT NULL DEFAULT '0' COMMENT '知名度',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_club_user1` (`proprieter_user_id`),
  KEY `fk_club_school1` (`school_id`),
  KEY `fk_club_user2` (`user_id`),
  CONSTRAINT `fk_club_school1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_user1` FOREIGN KEY (`proprieter_user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_user2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `club`
--

/*!40000 ALTER TABLE `club` DISABLE KEYS */;
INSERT INTO `club` (`id`,`introduction`,`name`,`logo_path`,`liveness`,`proprieter_user_id`,`school_id`,`type`,`status`,`member_number`,`brief_introduction`,`popularity`,`user_id`) VALUES 
 (1,'音乐社团，为音乐而生~~~~~~~~~~~~~~','音乐社团','upload/clubLogo/school_1_音乐社团.jpg',0,1,1,'MUSIC','PASSED',0,'音乐社团欢迎你',0,11),
 (2,'技术问题只是时间问题','sato团队','upload/clubLogo/school_1_sato团队.png',0,3,1,'MUSIC','PASSED',1,'快乐、自由、技术',0,12);
/*!40000 ALTER TABLE `club` ENABLE KEYS */;


--
-- Definition of table `club_focus_club`
--

DROP TABLE IF EXISTS `club_focus_club`;
CREATE TABLE `club_focus_club` (
  `source_club_id` int(11) NOT NULL,
  `target_club_id` int(11) NOT NULL,
  PRIMARY KEY (`source_club_id`,`target_club_id`),
  KEY `fk_club_has_club_club2` (`target_club_id`),
  KEY `fk_club_has_club_club1` (`source_club_id`),
  CONSTRAINT `fk_club_has_club_club1` FOREIGN KEY (`source_club_id`) REFERENCES `club` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_has_club_club2` FOREIGN KEY (`target_club_id`) REFERENCES `club` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `club_focus_club`
--

/*!40000 ALTER TABLE `club_focus_club` DISABLE KEYS */;
INSERT INTO `club_focus_club` (`source_club_id`,`target_club_id`) VALUES 
 (1,2);
/*!40000 ALTER TABLE `club_focus_club` ENABLE KEYS */;


--
-- Definition of table `club_focus_merchant`
--

DROP TABLE IF EXISTS `club_focus_merchant`;
CREATE TABLE `club_focus_merchant` (
  `club_id` int(11) NOT NULL,
  `merchant_id` int(11) NOT NULL,
  PRIMARY KEY (`club_id`,`merchant_id`),
  KEY `fk_club_has_merchant_merchant1` (`merchant_id`),
  KEY `fk_club_has_merchant_club1` (`club_id`),
  CONSTRAINT `fk_club_has_merchant_club1` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_has_merchant_merchant1` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `club_focus_merchant`
--

/*!40000 ALTER TABLE `club_focus_merchant` DISABLE KEYS */;
INSERT INTO `club_focus_merchant` (`club_id`,`merchant_id`) VALUES 
 (1,1);
/*!40000 ALTER TABLE `club_focus_merchant` ENABLE KEYS */;


--
-- Definition of table `club_member`
--

DROP TABLE IF EXISTS `club_member`;
CREATE TABLE `club_member` (
  `club_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `source` varchar(45) NOT NULL COMMENT '表示谁向谁申请 枚举类型 (社团,用户)',
  `status` varchar(45) NOT NULL COMMENT '这个请求的情况(未操作,通过,拒绝)',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role` varchar(45) NOT NULL COMMENT '枚举(普通社员,社团管理员,社长)',
  PRIMARY KEY (`club_id`,`user_id`),
  KEY `fk_club_has_user_user1` (`user_id`),
  KEY `fk_club_has_user_club1` (`club_id`),
  CONSTRAINT `fk_club_has_user_club1` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_has_user_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `club_member`
--

/*!40000 ALTER TABLE `club_member` DISABLE KEYS */;
INSERT INTO `club_member` (`club_id`,`user_id`,`source`,`status`,`datetime`,`role`) VALUES 
 (1,1,'USER_TO_CLUB','PASSED','2013-07-24 10:02:27','PROPRIETER'),
 (2,3,'USER_TO_CLUB','PASSED','2013-07-26 10:25:54','PROPRIETER');
/*!40000 ALTER TABLE `club_member` ENABLE KEYS */;


--
-- Definition of table `club_news`
--

DROP TABLE IF EXISTS `club_news`;
CREATE TABLE `club_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tittle` varchar(200) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `text` text NOT NULL,
  `title_img_path` varchar(250) NOT NULL,
  `video_url` varchar(250) DEFAULT NULL,
  `club_id` int(11) NOT NULL,
  `talking_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_trends_club1` (`club_id`),
  KEY `fk_club_news_talking1` (`talking_id`),
  CONSTRAINT `fk_club_news_talking1` FOREIGN KEY (`talking_id`) REFERENCES `talking` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trends_club1` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `club_news`
--

/*!40000 ALTER TABLE `club_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `club_news` ENABLE KEYS */;


--
-- Definition of table `club_post`
--

DROP TABLE IF EXISTS `club_post`;
CREATE TABLE `club_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `praise_count` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `club_id` int(11) NOT NULL,
  `tittle` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_post_user1` (`user_id`),
  KEY `fk_post_club1` (`club_id`),
  CONSTRAINT `fk_post_club1` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `club_post`
--

/*!40000 ALTER TABLE `club_post` DISABLE KEYS */;
INSERT INTO `club_post` (`id`,`text`,`datetime`,`praise_count`,`user_id`,`club_id`,`tittle`) VALUES 
 (7,'test','2013-07-24 15:29:29',0,1,1,'test'),
 (8,'test&lt;input type=\"text\"/&gt;','2013-07-24 15:31:44',0,1,1,'test picture<in'),
 (9,'<p>\r\n	test&lt;input type=\"text\"/&gt;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>','2013-07-24 15:31:53',0,1,1,'test picture<in'),
 (10,'<img src=\"/xiaojh/UpLoadfile/image/20130724/20130724153211_471.jpg\" alt=\"\" />\r\n<p>\r\n	test&lt;input type=\"text\"/&gt;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>','2013-07-24 15:32:20',0,1,1,'test picture<in'),
 (11,'rt','2013-07-24 17:02:24',0,1,1,'帖子列表出现！！');
/*!40000 ALTER TABLE `club_post` ENABLE KEYS */;


--
-- Definition of table `club_post_comment`
--

DROP TABLE IF EXISTS `club_post_comment`;
CREATE TABLE `club_post_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `text` varchar(300) NOT NULL,
  `club_post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_post_comment_post1` (`club_post_id`),
  KEY `fk_post_comment_user1` (`user_id`),
  CONSTRAINT `fk_post_comment_post1` FOREIGN KEY (`club_post_id`) REFERENCES `club_post` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_comment_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `club_post_comment`
--

/*!40000 ALTER TABLE `club_post_comment` DISABLE KEYS */;
INSERT INTO `club_post_comment` (`id`,`datetime`,`text`,`club_post_id`,`user_id`) VALUES 
 (4,'2013-07-25 11:48:16','asdfhjkl',11,1),
 (5,'2013-07-25 11:52:30','回复2',11,1),
 (7,'2013-07-25 14:39:17','回复4',11,1),
 (11,'2013-07-25 14:48:28','回复8',11,1),
 (12,'2013-07-25 14:56:56','回复9',11,1),
 (14,'2013-07-25 15:04:20','回复11',11,1),
 (15,'2013-07-25 15:47:58','回复2',11,1);
/*!40000 ALTER TABLE `club_post_comment` ENABLE KEYS */;


--
-- Definition of table `merchant`
--

DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `password` varchar(45) NOT NULL,
  `template` varchar(300) DEFAULT NULL COMMENT '自定义模块字段',
  `status` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL COMMENT '国企、私企、外企',
  `business` varchar(45) NOT NULL COMMENT '电子、餐饮、酒店、教育、会展、传媒、家政、电器、超市、婚庆、医疗、互联网、房地产、金融、物流、保险、服装、家具、其他',
  `purpose` varchar(45) NOT NULL COMMENT '校园赞助、兼职、商品买卖、品牌推广、创业投资、其他   可多选',
  `address` varchar(300) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `connector_name` varchar(45) NOT NULL COMMENT '联系人',
  `connector_phone` varchar(45) NOT NULL,
  `connector_qq` varchar(45) NOT NULL,
  `connector_email` varchar(45) NOT NULL,
  `liveness` int(11) NOT NULL DEFAULT '0' COMMENT '活跃度',
  `popularity` int(11) NOT NULL DEFAULT '0' COMMENT '知名度',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_merchant_user1` (`user_id`),
  CONSTRAINT `fk_merchant_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `merchant`
--

/*!40000 ALTER TABLE `merchant` DISABLE KEYS */;
INSERT INTO `merchant` (`id`,`name`,`password`,`template`,`status`,`type`,`business`,`purpose`,`address`,`phone`,`connector_name`,`connector_phone`,`connector_qq`,`connector_email`,`liveness`,`popularity`,`user_id`) VALUES 
 (1,'neusoft','dd34716876364a02d0195e2fb9ae2d1b',NULL,'PASSED','STATE_OWNED','ELECTRON','校园赞助','天津','23456455','郭林茂','15858528563','15687481562','153841635@qq.com',0,0,13),
 (2,'google','dd34716876364a02d0195e2fb9ae2d1b',NULL,'PASSED','STATE_OWNED','ELECTRON','校园赞助','北京','125498393','高笠峰','15683198538','53186153688','sklxz@qq.com',0,0,14);
/*!40000 ALTER TABLE `merchant` ENABLE KEYS */;


--
-- Definition of table `merchant_focus_club`
--

DROP TABLE IF EXISTS `merchant_focus_club`;
CREATE TABLE `merchant_focus_club` (
  `merchant_id` int(11) NOT NULL,
  `club_id` int(11) NOT NULL,
  PRIMARY KEY (`merchant_id`,`club_id`),
  KEY `fk_merchant_has_club_club1` (`club_id`),
  KEY `fk_merchant_has_club_merchant1` (`merchant_id`),
  CONSTRAINT `fk_merchant_has_club_club1` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_merchant_has_club_merchant1` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `merchant_focus_club`
--

/*!40000 ALTER TABLE `merchant_focus_club` DISABLE KEYS */;
INSERT INTO `merchant_focus_club` (`merchant_id`,`club_id`) VALUES 
 (1,1);
/*!40000 ALTER TABLE `merchant_focus_club` ENABLE KEYS */;


--
-- Definition of table `merchant_focus_merchant`
--

DROP TABLE IF EXISTS `merchant_focus_merchant`;
CREATE TABLE `merchant_focus_merchant` (
  `merchant_id` int(11) NOT NULL,
  `merchant_id1` int(11) NOT NULL,
  PRIMARY KEY (`merchant_id`,`merchant_id1`),
  KEY `fk_merchant_has_merchant_merchant2` (`merchant_id1`),
  KEY `fk_merchant_has_merchant_merchant1` (`merchant_id`),
  CONSTRAINT `fk_merchant_has_merchant_merchant1` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_merchant_has_merchant_merchant2` FOREIGN KEY (`merchant_id1`) REFERENCES `merchant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `merchant_focus_merchant`
--

/*!40000 ALTER TABLE `merchant_focus_merchant` DISABLE KEYS */;
INSERT INTO `merchant_focus_merchant` (`merchant_id`,`merchant_id1`) VALUES 
 (1,2);
/*!40000 ALTER TABLE `merchant_focus_merchant` ENABLE KEYS */;


--
-- Definition of table `merchant_news`
--

DROP TABLE IF EXISTS `merchant_news`;
CREATE TABLE `merchant_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tittle` varchar(200) NOT NULL,
  `text` text NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `url` varchar(500) DEFAULT NULL,
  `url_type` varchar(45) DEFAULT NULL,
  `merchant_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_merchant_news_merchant1` (`merchant_id`),
  CONSTRAINT `fk_merchant_news_merchant1` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `merchant_news`
--

/*!40000 ALTER TABLE `merchant_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchant_news` ENABLE KEYS */;


--
-- Definition of table `online_activity`
--

DROP TABLE IF EXISTS `online_activity`;
CREATE TABLE `online_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tittle` varchar(200) NOT NULL,
  `text` text NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `video_url` varchar(250) DEFAULT NULL,
  `title_img_path` varchar(250) NOT NULL,
  `heat` int(11) NOT NULL DEFAULT '0' COMMENT '热度 用trigger',
  `status` varchar(45) NOT NULL COMMENT '申请,正在进行,结束',
  `talking_id` int(11) NOT NULL,
  `hold_user_id` int(11) NOT NULL,
  `participant_count` int(11) NOT NULL DEFAULT '0' COMMENT '参加人数',
  `praise_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_activity_talking1` (`talking_id`),
  KEY `fk_online_activity_user1` (`hold_user_id`),
  CONSTRAINT `fk_activity_talking10` FOREIGN KEY (`talking_id`) REFERENCES `talking` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_online_activity_user1` FOREIGN KEY (`hold_user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `online_activity`
--

/*!40000 ALTER TABLE `online_activity` DISABLE KEYS */;
INSERT INTO `online_activity` (`id`,`tittle`,`text`,`datetime`,`video_url`,`title_img_path`,`heat`,`status`,`talking_id`,`hold_user_id`,`participant_count`,`praise_count`) VALUES 
 (1,'晒晒你用过的头像','RT','2013-07-27 10:26:38','','http://ww4.sinaimg.cn/bmiddle/9b17754bjw1e70khurzodj20k10dimzf.jpg',0,'UNDERWAY',6,13,0,0);
/*!40000 ALTER TABLE `online_activity` ENABLE KEYS */;


--
-- Definition of table `personal_letter`
--

DROP TABLE IF EXISTS `personal_letter`;
CREATE TABLE `personal_letter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(300) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `source_user_id` int(11) NOT NULL,
  `target_user_id` int(11) NOT NULL,
  `status` varchar(45) NOT NULL COMMENT '状态,判断是否已读删除等',
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_personal_letter_user1` (`source_user_id`),
  KEY `fk_personal_letter_user2` (`target_user_id`),
  CONSTRAINT `fk_personal_letter_user1` FOREIGN KEY (`source_user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_letter_user2` FOREIGN KEY (`target_user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `personal_letter`
--

/*!40000 ALTER TABLE `personal_letter` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_letter` ENABLE KEYS */;


--
-- Definition of trigger `user_letter`
--

DROP TRIGGER /*!50030 IF EXISTS */ `user_letter`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `user_letter` AFTER INSERT ON `personal_letter` FOR EACH ROW begin
    update user set receive_letter_count=receive_letter_count + 1 where id=new.target_user_id;
end $$

DELIMITER ;

--
-- Definition of table `picture`
--

DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(250) NOT NULL,
  `user_id` int(11) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_picture_user` (`user_id`),
  CONSTRAINT `fk_picture_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `picture`
--

/*!40000 ALTER TABLE `picture` DISABLE KEYS */;
/*!40000 ALTER TABLE `picture` ENABLE KEYS */;


--
-- Definition of table `school`
--

DROP TABLE IF EXISTS `school`;
CREATE TABLE `school` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `logo_path` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `school`
--

/*!40000 ALTER TABLE `school` DISABLE KEYS */;
INSERT INTO `school` (`id`,`name`,`logo_path`) VALUES 
 (1,'test','test');
/*!40000 ALTER TABLE `school` ENABLE KEYS */;


--
-- Definition of table `share_details`
--

DROP TABLE IF EXISTS `share_details`;
CREATE TABLE `share_details` (
  `talking_id` int(11) NOT NULL COMMENT '级联删除先依赖hibernate 不行再弄删除的trigger',
  `share_count` int(11) NOT NULL DEFAULT '0',
  `praise_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`talking_id`),
  CONSTRAINT `fk_share_talking1` FOREIGN KEY (`talking_id`) REFERENCES `talking` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `share_details`
--

/*!40000 ALTER TABLE `share_details` DISABLE KEYS */;
INSERT INTO `share_details` (`talking_id`,`share_count`,`praise_count`) VALUES 
 (1,0,0),
 (2,0,0),
 (3,0,0),
 (4,0,0),
 (5,0,0),
 (6,0,0);
/*!40000 ALTER TABLE `share_details` ENABLE KEYS */;


--
-- Definition of table `talking`
--

DROP TABLE IF EXISTS `talking`;
CREATE TABLE `talking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(300) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `url` varchar(500) DEFAULT NULL,
  `url_type` varchar(45) DEFAULT NULL COMMENT '枚举(图片,视屏)',
  `share_talking_id` int(11) DEFAULT NULL,
  `status` varchar(45) NOT NULL COMMENT '不分享,删除等',
  PRIMARY KEY (`id`),
  KEY `fk_talking_user1` (`user_id`),
  KEY `fk_talking_talking1` (`share_talking_id`),
  CONSTRAINT `fk_talking_talking1` FOREIGN KEY (`share_talking_id`) REFERENCES `talking` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_talking_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `talking`
--

/*!40000 ALTER TABLE `talking` DISABLE KEYS */;
INSERT INTO `talking` (`id`,`text`,`datetime`,`user_id`,`url`,`url_type`,`share_talking_id`,`status`) VALUES 
 (1,'test','2013-07-24 09:51:13',1,'',NULL,NULL,'SHARE'),
 (2,'王林','2013-07-24 09:55:11',1,'<embed src=\"http://player.youku.com/player.php/sid/XNTg2Nzk0Mjky/v.swf\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>','VIDEO',NULL,'SHARE'),
 (3,'<input type=\"text\" value=\"qwerty\" />','2013-07-24 10:44:49',1,'',NULL,NULL,'SHARE'),
 (4,'<div style=\"width:700px;height:700px;float:right;\" ></div>','2013-07-24 10:47:57',1,'',NULL,NULL,'SHARE'),
 (5,'<div style=\"width:700px;height:700px;float:right;background:#ff0000;\" >\r\n<div>adfaf</div>\r\n</div>','2013-07-24 10:49:32',1,'',NULL,NULL,'SHARE'),
 (6,'晒晒你用过的头像','2013-07-27 10:26:37',13,'http://ww4.sinaimg.cn/bmiddle/9b17754bjw1e70khurzodj20k10dimzf.jpg','PICTURE',NULL,'SHARE');
/*!40000 ALTER TABLE `talking` ENABLE KEYS */;


--
-- Definition of trigger `share_count`
--

DROP TRIGGER /*!50030 IF EXISTS */ `share_count`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `share_count` AFTER INSERT ON `talking` FOR EACH ROW begin
    if new.share_talking_id is not null then
        update share_details set share_count=share_count + 1 where talking_id=new.share_talking_id;
    else
        insert into share_details(talking_id) values(new.id);
    end if;
end $$

DELIMITER ;

--
-- Definition of table `talking_comment`
--

DROP TABLE IF EXISTS `talking_comment`;
CREATE TABLE `talking_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `text` varchar(300) NOT NULL,
  `user_id` int(11) NOT NULL,
  `talking_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comment_user1` (`user_id`),
  KEY `fk_talking_comment_talking1` (`talking_id`),
  CONSTRAINT `fk_comment_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_talking_comment_talking1` FOREIGN KEY (`talking_id`) REFERENCES `talking` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `talking_comment`
--

/*!40000 ALTER TABLE `talking_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `talking_comment` ENABLE KEYS */;


--
-- Definition of table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `signature` varchar(300) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '类似于qq的个性签名(状态)',
  `school_id` int(11) NOT NULL,
  `announcement_count` int(11) NOT NULL DEFAULT '0' COMMENT '通知数量 在通知那用触发器弄',
  `email` varchar(45) NOT NULL,
  `sex` varchar(45) NOT NULL,
  `real_name` varchar(45) DEFAULT NULL,
  `subject` varchar(45) DEFAULT NULL COMMENT '院系',
  `profession` varchar(45) DEFAULT NULL,
  `grade` int(11) NOT NULL COMMENT '填的入学年份',
  `birthday` date DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `qq` varchar(45) DEFAULT NULL,
  `portrait_path` varchar(250) DEFAULT NULL COMMENT '头像',
  `liveness` int(11) NOT NULL DEFAULT '0' COMMENT '活跃度',
  `popularity` int(11) NOT NULL DEFAULT '0' COMMENT '知名度',
  `receive_letter_count` int(11) NOT NULL DEFAULT '0',
  `status` varchar(45) NOT NULL,
  `code` varchar(200) DEFAULT NULL COMMENT '验证和修改密码时的码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `fk_user_school1` (`school_id`),
  CONSTRAINT `fk_user_school1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`,`name`,`password`,`signature`,`school_id`,`announcement_count`,`email`,`sex`,`real_name`,`subject`,`profession`,`grade`,`birthday`,`phone`,`qq`,`portrait_path`,`liveness`,`popularity`,`receive_letter_count`,`status`,`code`) VALUES 
 (1,'test0','feea6340d7192d5e5b3095dc7d1b683e','',1,0,'test@126.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,'upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (2,'test1','4c21e12c3f9c4e073b37ca8aaeab0caa','',1,0,'test@126.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,'upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (3,'test2','39f7eae572f7921a9514d17cc1b5dcf4','',1,0,'test@126.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,'upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (4,'test3','f92aa39244bcb62f1644ae307bc19fa1','',1,0,'test@126.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,'upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (5,'test4','71c4351cc3fe6352d479fbe535a50662','',1,0,'test@126.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,'upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (6,'test5','5581bc72a326ad5d44603c37754f1504','',1,0,'test@126.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,'upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (7,'test6','2b6f9fdb7683b69ceeafce79a5448a01','',1,0,'test@126.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,'upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (8,'test7','dba249bb33168257786caf1b3a57d9f1','',1,0,'test@126.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,'upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (9,'test8','fef4dbe1d16ae934da5a5197fbd84b37','',1,0,'test@126.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,'upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (10,'test9','0aa5a1be2b3d8281964b618b2086818e','',1,0,'test@126.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,'upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (11,'音乐社团','音乐社团','',1,0,'音乐社团','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'SYSTEM',NULL),
 (12,'1_sato团队','sato团队','',1,0,'sato团队','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'SYSTEM',NULL),
 (13,'东软集团','东软集团','',1,0,'东软集团','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'SYSTEM',NULL),
 (14,'google','test','',1,0,'google','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'SYSTEM',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


--
-- Definition of table `user_focus_club`
--

DROP TABLE IF EXISTS `user_focus_club`;
CREATE TABLE `user_focus_club` (
  `user_id` int(11) NOT NULL,
  `club_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`club_id`),
  KEY `fk_user_has_club_club1` (`club_id`),
  KEY `fk_user_has_club_user1` (`user_id`),
  CONSTRAINT `fk_user_has_club_club1` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_club_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_focus_club`
--

/*!40000 ALTER TABLE `user_focus_club` DISABLE KEYS */;
INSERT INTO `user_focus_club` (`user_id`,`club_id`) VALUES 
 (1,1),
 (1,2);
/*!40000 ALTER TABLE `user_focus_club` ENABLE KEYS */;


--
-- Definition of table `user_focus_merchant`
--

DROP TABLE IF EXISTS `user_focus_merchant`;
CREATE TABLE `user_focus_merchant` (
  `user_id` int(11) NOT NULL,
  `merchant_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`merchant_id`),
  KEY `fk_user_has_merchant_merchant1` (`merchant_id`),
  KEY `fk_user_has_merchant_user1` (`user_id`),
  CONSTRAINT `fk_user_has_merchant_merchant1` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_merchant_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_focus_merchant`
--

/*!40000 ALTER TABLE `user_focus_merchant` DISABLE KEYS */;
INSERT INTO `user_focus_merchant` (`user_id`,`merchant_id`) VALUES 
 (1,1);
/*!40000 ALTER TABLE `user_focus_merchant` ENABLE KEYS */;


--
-- Definition of table `user_focus_user`
--

DROP TABLE IF EXISTS `user_focus_user`;
CREATE TABLE `user_focus_user` (
  `source_user_id` int(11) NOT NULL,
  `target_user_id` int(11) NOT NULL,
  PRIMARY KEY (`source_user_id`,`target_user_id`),
  KEY `fk_user_has_user_user2` (`target_user_id`),
  KEY `fk_user_has_user_user1` (`source_user_id`),
  CONSTRAINT `fk_user_has_user_user1` FOREIGN KEY (`source_user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2` FOREIGN KEY (`target_user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_focus_user`
--

/*!40000 ALTER TABLE `user_focus_user` DISABLE KEYS */;
INSERT INTO `user_focus_user` (`source_user_id`,`target_user_id`) VALUES 
 (1,2),
 (1,3),
 (1,4),
 (1,5),
 (1,7),
 (1,9);
/*!40000 ALTER TABLE `user_focus_user` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
