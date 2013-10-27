-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.6.13-enterprise-commercial-advanced


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
  `video_url` varchar(500) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `activity`
--

/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` (`id`,`tittle`,`text`,`datetime`,`video_url`,`title_img_path`,`place`,`hold_club_id`,`hold_merchant_id`,`organizer`,`heat`,`budget`,`status`,`talking_id`,`participant_count`) VALUES 
 (1,'商家活动一','商家活动一商家活动一','2013-08-05 11:57:11','<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>','http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','天津工业大学',2,1,'商家1社团2',44,'200','UNDERWAY',6,56),
 (2,'商家活动二','商家活动二商家活动二商家活动二商家活动二商家活动二','2013-08-05 11:57:11','<embed src=\"http://www.tudou.com/l/mvZlZmwpB2Y/&resourceId=0_05_05_99&iid=173717345&bid=05/v.swf\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" wmode=\"opaque\" width=\"480\" height=\"400\"></embed>','http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','天津',2,1,'商家1社团2',75,'556','UNDERWAY',7,78),
 (3,'商家活动三','商家活动三商家活动三商家活动三商家活动三商家活动三商家活动三','2013-08-05 11:57:11','<embed src=\"http://player.youku.com/player.php/sid/XMzIzNDk5MjAw/v.swf\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>','http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','天津',2,1,'商家1社团2',55,'555','UNDERWAY',8,67),
 (4,'商家活动四','商家活动四商家活动四商家活动四商家活动四商家活动四商家活动四','2013-08-05 11:57:11','http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','天津天津',2,1,'商家1社团2',65,'545','UNDERWAY',9,67),
 (5,'社团活动1','社团活动1社团活动1社团活动1社团活动1社团活动1社团活动1','2013-08-05 11:57:11','<embed src=\"http://player.youku.com/player.php/sid/XMzIzNDk5MjAw/v.swf\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>','http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','65767',1,2,'社团1商家2',66,'545','UNDERWAY',10,67),
 (6,'社团活动2','社团活动2社团活动2社团活动2社团活动2','2013-08-05 11:57:11','<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>','http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','4657',1,2,'社团1商家2',777,'545','UNDERWAY',11,55),
 (7,'社团活动3','社团活动3社团活动3社团活动3社团活动3社团活动3','2013-08-05 11:57:11','<embed src=\"http://www.tudou.com/l/mvZlZmwpB2Y/&resourceId=0_05_05_99&iid=173717345&bid=05/v.swf\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" wmode=\"opaque\" width=\"480\" height=\"400\"></embed>','http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','rgfff',1,2,'社团1商家2',777,'545','UNDERWAY',12,87),
 (8,'社团活动4','社团活动4社团活动4社团活动4社团活动4社团活动4','2013-08-05 11:57:11','http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','54646',1,2,'社团1商家2',444,'444','UNDERWAY',13,54);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `activity_post`
--

/*!40000 ALTER TABLE `activity_post` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `activity_post_comment`
--

/*!40000 ALTER TABLE `activity_post_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_post_comment` ENABLE KEYS */;


--
-- Definition of table `advertisement`
--

DROP TABLE IF EXISTS `advertisement`;
CREATE TABLE `advertisement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `height` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `advertisement`
--

/*!40000 ALTER TABLE `advertisement` DISABLE KEYS */;
INSERT INTO `advertisement` (`id`,`type`,`name`,`height`,`width`) VALUES 
 (1,'JS','活动页广告1',200,800),
 (2,'IMG','活动页广告2',100,230);
/*!40000 ALTER TABLE `advertisement` ENABLE KEYS */;


--
-- Definition of table `advertisement_content`
--

DROP TABLE IF EXISTS `advertisement_content`;
CREATE TABLE `advertisement_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `advertisement_id` int(11) NOT NULL,
  `content_path` varchar(255) NOT NULL,
  `description` varchar(64) DEFAULT NULL,
  `code` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_content_advertisement` (`advertisement_id`),
  CONSTRAINT `fk_content_advertisement` FOREIGN KEY (`advertisement_id`) REFERENCES `advertisement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `advertisement_content`
--

/*!40000 ALTER TABLE `advertisement_content` DISABLE KEYS */;
INSERT INTO `advertisement_content` (`id`,`advertisement_id`,`content_path`,`description`,`code`) VALUES 
 (1,1,'/upload/ads/20130805/153532856.jpg','活动广告1','http://www.baidu.com/'),
 (2,1,'/upload/ads/20130805/153603187.png','活动广告2','http://www.ifeng.com/'),
 (3,1,'/upload/ads/20130805/153630819.jpg','活动广告3','http://www.taobao.com/'),
 (4,2,'/upload/ads/20130805/153826469.jpg','活动广告','http://www.baidu.com/');
/*!40000 ALTER TABLE `advertisement_content` ENABLE KEYS */;


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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `announcement`
--

/*!40000 ALTER TABLE `announcement` DISABLE KEYS */;
INSERT INTO `announcement` (`id`,`datetime`,`title`,`text`,`club_id`) VALUES 
 (1,'2013-08-31 15:48:44','test','test',1),
 (2,'2013-08-31 16:55:23','test2','test2',1),
 (3,'2013-08-31 17:07:18','test3','test3',NULL),
 (4,'2013-08-31 17:09:21','test4','test4',NULL),
 (5,'2013-08-31 17:09:27','test5','test5',NULL),
 (6,'2013-08-31 17:09:30','test','test',NULL),
 (7,'2013-08-31 17:09:36','test7','test7',NULL),
 (8,'2013-08-31 17:09:40','test8','test',NULL),
 (9,'2013-08-31 17:13:02','test9','test9',NULL),
 (10,'2013-09-10 18:35:18','test10','test10',NULL),
 (11,'2013-09-10 18:48:44','test','test',NULL),
 (12,'2013-09-10 18:51:45','test','test',1),
 (13,'2013-09-17 22:14:37','asdf','asdf',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `club`
--

/*!40000 ALTER TABLE `club` DISABLE KEYS */;
INSERT INTO `club` (`id`,`introduction`,`name`,`logo_path`,`liveness`,`proprieter_user_id`,`school_id`,`type`,`status`,`member_number`,`brief_introduction`,`popularity`,`user_id`) VALUES 
 (1,'测试社团1','测试社团1','upload/portrait/auto_photo.png',0,2,1,'SPORT','PASSED',2,'社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介社团简介',88889,21),
 (2,'测试社团2','测试社团2','upload/portrait/auto_photo.png',0,2,2,'SPORT','PASSED',5,'社团简介',888888,22),
 (3,'测试社团3','测试社团3','upload/portrait/auto_photo.png',0,3,1,'SPORT','PASSED',6,'社团简介',8988,23),
 (4,'测试社团4','测试社团4','upload/portrait/auto_photo.png',0,4,1,'SPORT','PASSED',9,'社团简介',63,24),
 (5,'测试社团5','测试社团5','upload/portrait/auto_photo.png',0,5,2,'SPORT','PASSED',9,'社团简介',25,25),
 (6,'测试社团6','测试社团6','upload/portrait/auto_photo.png',0,6,2,'MUSIC','PASSED',5,'社团简介',10,26),
 (7,'测试社团7','测试社团7','upload/portrait/auto_photo.png',0,7,2,'MUSIC','PASSED',5,'社团简介',1,27),
 (8,'测试社团8','测试社团8','upload/portrait/auto_photo.png',0,8,1,'MUSIC','PASSED',5,'社团简介',35,28),
 (9,'测试社团9','测试社团9','upload/portrait/auto_photo.png',0,9,3,'MUSIC','PASSED',6,'社团简介',85,29),
 (10,'测试社团10','测试社团10','upload/portrait/auto_photo.png',0,10,3,'LITERATURE','PASSED',95,'社团简介',46,30),
 (11,'测试社团11','测试社团11','upload/portrait/auto_photo.png',0,2,3,'LITERATURE','PASSED',45,'社团简介',52,21),
 (12,'测试社团12','测试社团12','upload/portrait/auto_photo.png',0,3,3,'IT','PASSED',5,'社团简介',35,22),
 (13,'测试社团13','测试社团13','upload/portrait/auto_photo.png',0,4,4,'IT','PASSED',4,'社团简介',39,23),
 (14,'测试社团14','测试社团14','upload/portrait/auto_photo.png',0,5,4,'IT','PASSED',5,'社团简介',75,24),
 (15,'测试社团15','测试社团15','upload/portrait/auto_photo.png',0,6,4,'IT','PASSED',5,'社团简介',62,25),
 (16,'测试社团16','测试社团16','upload/portrait/auto_photo.png',0,7,4,'IT','PASSED',4,'社团简介',999,26),
 (17,'测试社团17','测试社团17','upload/portrait/auto_photo.png',0,8,5,'IT','PASSED',8,'社团简介',54,27),
 (18,'测试社团18','测试社团18','upload/portrait/auto_photo.png',0,9,5,'IT','PASSED',7,'社团简介',61,28),
 (19,'测试社团19','测试社团19','upload/portrait/auto_photo.png',0,10,5,'IT','PASSED',9,'社团简介',18,29),
 (20,'测试社团20','测试社团20','upload/portrait/auto_photo.png',0,2,1,'IT','PASSED',6,'社团简介',39,30),
 (22,'测试社团22','测试社团22','upload/portrait/auto_photo.png',0,3,1,'SPORT','PASSED',54,'社团简介',56,21),
 (23,'测试社团23','测试社团23','upload/portrait/auto_photo.png',0,4,1,'SPORT','PASSED',5,'社团简介',78,22),
 (24,'测试社团24','测试社团24','upload/portrait/auto_photo.png',0,5,2,'SPORT','PASSED',85,'社团简介',98,23),
 (25,'测试社团25','测试社团25','upload/portrait/auto_photo.png',0,6,4,'SPORT','PASSED',78,'社团简介',78,24),
 (26,'测试社团26','测试社团26','upload/portrait/auto_photo.png',0,7,4,'SPORT','PASSED',12,'社团简介',98,25),
 (27,'你大娘','变态社','upload/clubLogo/school_1_d1c7a7f7e1bcf8196b55aa3eea873890.jpg',0,41,1,'MUSIC','PASSED',1,'你大爷',0,44),
 (28,'测试','测试','upload/clubLogo/school_1_a8d6fb5a5735c294e9fb41ba8ae98eaf.jpg',0,41,1,'MUSIC','NO_CHECK',0,'测试',0,45);
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
 (2,1),
 (3,1),
 (1,2),
 (3,2),
 (1,3),
 (2,3);
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
 (1,1),
 (2,1),
 (1,2),
 (2,2);
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
 (1,2,'CLUB_TO_USER','PASSED','2013-08-31 15:48:13','PROPRIETER'),
 (27,41,'USER_TO_CLUB','PASSED','2013-09-22 09:23:05','PROPRIETER');
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
  `video_url` varchar(500) DEFAULT NULL,
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
  `title` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_post_user1` (`user_id`),
  KEY `fk_post_club1` (`club_id`),
  CONSTRAINT `fk_post_club1` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `club_post`
--

/*!40000 ALTER TABLE `club_post` DISABLE KEYS */;
INSERT INTO `club_post` (`id`,`text`,`datetime`,`praise_count`,`user_id`,`club_id`,`title`) VALUES 
 (1,'Test','2013-10-01 22:19:27',0,2,1,'Test'),
 (2,'<img src=\"/xiaojh/UpLoadfile/image/20131001/20131001222104_520.jpg\" alt=\"\" />测试发帖','2013-10-01 22:21:19',0,2,1,'Test1'),
 (3,'<img src=\"/xiaojh/UpLoadfile/image/20131003/20131003230544_252.jpg\" alt=\"\" />','2013-10-03 23:05:47',0,2,1,'test');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `club_post_comment`
--

/*!40000 ALTER TABLE `club_post_comment` DISABLE KEYS */;
INSERT INTO `club_post_comment` (`id`,`datetime`,`text`,`club_post_id`,`user_id`) VALUES 
 (1,'2013-10-01 22:19:38','fuck',1,2),
 (2,'2013-10-01 22:19:45','fuck again',1,2);
/*!40000 ALTER TABLE `club_post_comment` ENABLE KEYS */;


--
-- Definition of table `keyword`
--

DROP TABLE IF EXISTS `keyword`;
CREATE TABLE `keyword` (
  `keyword` varchar(100) NOT NULL,
  PRIMARY KEY (`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `keyword`
--

/*!40000 ALTER TABLE `keyword` DISABLE KEYS */;
INSERT INTO `keyword` (`keyword`) VALUES 
 ('你妈'),
 ('日');
/*!40000 ALTER TABLE `keyword` ENABLE KEYS */;


--
-- Definition of table `mail_validate`
--

DROP TABLE IF EXISTS `mail_validate`;
CREATE TABLE `mail_validate` (
  `code` varchar(250) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`code`),
  KEY `fk_mail_validate_user1_idx` (`user_id`),
  CONSTRAINT `fk_mail_validate_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mail_validate`
--

/*!40000 ALTER TABLE `mail_validate` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_validate` ENABLE KEYS */;


--
-- Definition of table `merchant`
--

DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
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
  `merchantName` varchar(100) NOT NULL,
  `logo_path` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_merchant_user1` (`user_id`),
  CONSTRAINT `fk_merchant_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `merchant`
--

/*!40000 ALTER TABLE `merchant` DISABLE KEYS */;
INSERT INTO `merchant` (`id`,`name`,`password`,`template`,`status`,`type`,`business`,`purpose`,`address`,`phone`,`connector_name`,`connector_phone`,`connector_qq`,`connector_email`,`liveness`,`popularity`,`user_id`,`merchantName`,`logo_path`) VALUES 
 (1,'merchant1','feea6340d7192d5e5b3095dc7d1b683e','55','PASSED','STATE_OWNED','ELECTRON','\'1\'','Test','Test','Test','Test','Test','66',6,64888,11,'5446','upload/merchantLogo/33371a89eb6185816af2e29aa2154490.jpg'),
 (2,'merchant2','feea6340d7192d5e5b3095dc7d1b683e','5','PASSED','STATE_OWNED','ELECTRON','\'1\'','6','66','66','66','666','66',66,468888,12,'576','upload/portrait/auto_photo.png'),
 (3,'merchant3','feea6340d7192d5e5b3095dc7d1b683e','5','PASSED','STATE_OWNED','ELECTRON','\'1\'','666','666','66','666666','66','66',66,54,13,'89887','upload/portrait/auto_photo.png'),
 (4,'merchant4','feea6340d7192d5e5b3095dc7d1b683e','5','PASSED','STATE_OWNED','ELECTRON','\'1\'','666','666','666','66','66','66666',6,6,14,'6878','upload/portrait/auto_photo.png'),
 (5,'merchant5','feea6340d7192d5e5b3095dc7d1b683e','5','PASSED','STATE_OWNED','ELECTRON','\'1\'','66','666','666','666','66','66',66,46,15,'9909','upload/portrait/auto_photo.png'),
 (6,'merchant6','feea6340d7192d5e5b3095dc7d1b683e','5','PASSED','STATE_OWNED','ELECTRON','\'1\'','6666','666','666','666','66','6666',6,46,16,'6878','upload/portrait/auto_photo.png'),
 (7,'merchant7','feea6340d7192d5e5b3095dc7d1b683e','5','PASSED','STATE_OWNED','ELECTRON','\'1\'','666','666','666','666','6','666',6,46,17,'676','upload/portrait/auto_photo.png'),
 (8,'merchant8','feea6340d7192d5e5b3095dc7d1b683e','5','PASSED','STATE_OWNED','ELECTRON','\'1\'','666','666','666','666','666','66',6,46,18,'876','upload/portrait/auto_photo.png'),
 (9,'merchant9','feea6340d7192d5e5b3095dc7d1b683e','5','PASSED','STATE_OWNED','ELECTRON','\'1\'','666','666','666','666','6666','666',6,74,19,'57ddte','upload/portrait/auto_photo.png'),
 (10,'merchant10','feea6340d7192d5e5b3095dc7d1b683e','5','PASSED','STATE_OWNED','ELECTRON','\'1\'','66','666','66','66666','666','66',6,24,20,'e54','upload/portrait/auto_photo.png'),
 (11,'test','dd34716876364a02d0195e2fb9ae2d1b',NULL,'PASSED','STATE_OWNED','ELECTRON','\'1\'','犀利','111111','犀利','犀利','527519996','527519996@qq.com',0,0,41,'test','upload/merchantLogo/dd34716876364a02d0195e2fb9ae2d1b.jpg');
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
 (1,1),
 (2,1),
 (1,2),
 (2,2),
 (2,3),
 (2,4),
 (2,5),
 (2,6),
 (2,7),
 (2,8),
 (2,9),
 (2,10),
 (2,11),
 (2,12),
 (2,13),
 (2,14),
 (2,16),
 (2,17),
 (2,18),
 (2,20),
 (2,24),
 (2,25),
 (2,27);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `merchant_news`
--

/*!40000 ALTER TABLE `merchant_news` DISABLE KEYS */;
INSERT INTO `merchant_news` (`id`,`tittle`,`text`,`datetime`,`url`,`url_type`,`merchant_id`) VALUES 
 (1,'Test','Test','2013-10-02 12:53:24','/xiaojh/upload/merchantNewsMedia/20131002/125326400.jpg','PICTURE',1);
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
  `video_url` varchar(500) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `online_activity`
--

/*!40000 ALTER TABLE `online_activity` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `personal_letter`
--

/*!40000 ALTER TABLE `personal_letter` DISABLE KEYS */;
INSERT INTO `personal_letter` (`id`,`text`,`datetime`,`source_user_id`,`target_user_id`,`status`,`title`) VALUES 
 (1,'擦!','2013-10-01 20:33:26',41,2,'NO_READ',''),
 (2,'我擦','2013-10-01 20:33:38',41,2,'NO_READ',''),
 (3,'我日','2013-10-01 20:37:22',41,2,'NO_READ',''),
 (4,'test','2013-10-05 17:50:05',4,2,'NO_READ',''),
 (5,'test','2013-10-05 17:50:18',4,2,'HAD_READ',''),
 (6,'test','2013-10-05 18:03:23',4,2,'NO_READ',''),
 (7,'test','2013-10-05 18:03:25',4,2,'NO_READ',''),
 (8,'test','2013-10-05 18:03:25',4,2,'NO_READ',''),
 (9,'test','2013-10-05 18:03:25',4,2,'NO_READ',''),
 (10,'test','2013-10-05 18:03:25',4,2,'NO_READ',''),
 (11,'test','2013-10-05 18:03:25',4,2,'NO_READ',''),
 (12,'test','2013-10-05 18:03:26',4,2,'NO_READ',''),
 (13,'test','2013-10-05 18:03:26',4,2,'NO_READ',''),
 (14,'test','2013-10-05 18:03:26',4,2,'NO_READ',''),
 (15,'test','2013-10-05 18:03:26',4,2,'NO_READ',''),
 (16,'test','2013-10-05 18:03:26',4,2,'NO_READ',''),
 (17,'test','2013-10-05 18:03:27',4,2,'NO_READ',''),
 (18,'test','2013-10-05 18:03:27',4,2,'NO_READ',''),
 (19,'test','2013-10-05 18:03:27',4,2,'NO_READ',''),
 (20,'test','2013-10-05 18:03:27',4,2,'NO_READ',''),
 (21,'test','2013-10-05 18:03:27',4,2,'NO_READ',''),
 (22,'test','2013-10-05 18:03:28',4,2,'NO_READ',''),
 (23,'test','2013-10-05 18:03:28',4,2,'NO_READ',''),
 (24,'test','2013-10-05 18:03:28',4,2,'NO_READ',''),
 (25,'test','2013-10-05 18:03:28',4,2,'NO_READ',''),
 (26,'test','2013-10-05 18:03:29',4,2,'NO_READ',''),
 (27,'test','2013-10-05 18:03:29',4,2,'NO_READ',''),
 (28,'test','2013-10-05 18:03:29',4,2,'NO_READ',''),
 (29,'test','2013-10-05 18:03:29',4,2,'NO_READ',''),
 (30,'test','2013-10-05 18:03:29',4,2,'NO_READ',''),
 (31,'test','2013-10-05 18:03:29',4,2,'NO_READ',''),
 (32,'test','2013-10-05 18:03:30',4,2,'NO_READ',''),
 (33,'test','2013-10-05 18:03:30',4,2,'NO_READ',''),
 (34,'test','2013-10-05 18:03:30',4,2,'NO_READ',''),
 (35,'test','2013-10-05 18:03:30',4,2,'NO_READ',''),
 (36,'test','2013-10-05 18:03:30',4,2,'NO_READ',''),
 (37,'test','2013-10-05 18:03:30',4,2,'NO_READ',''),
 (38,'test','2013-10-05 18:03:31',4,2,'NO_READ',''),
 (39,'test','2013-10-05 18:03:31',4,2,'NO_READ',''),
 (40,'test','2013-10-05 18:03:31',4,2,'NO_READ',''),
 (41,'test','2013-10-05 18:03:31',4,2,'NO_READ',''),
 (42,'test','2013-10-05 18:03:32',4,2,'NO_READ',''),
 (43,'test','2013-10-05 18:03:32',4,2,'NO_READ',''),
 (44,'test','2013-10-05 18:03:32',4,2,'NO_READ',''),
 (45,'test','2013-10-05 18:03:32',4,2,'NO_READ',''),
 (46,'test','2013-10-05 18:03:33',4,2,'NO_READ',''),
 (47,'test','2013-10-05 18:03:33',4,2,'NO_READ',''),
 (48,'test','2013-10-05 18:03:33',4,2,'NO_READ',''),
 (49,'test','2013-10-05 18:03:33',4,2,'NO_READ',''),
 (50,'test','2013-10-05 18:03:34',4,2,'NO_READ',''),
 (51,'test','2013-10-05 18:03:34',4,2,'NO_READ',''),
 (52,'test','2013-10-05 18:03:34',4,2,'NO_READ',''),
 (53,'test','2013-10-05 18:03:34',4,2,'NO_READ',''),
 (54,'test','2013-10-05 18:03:34',4,2,'NO_READ',''),
 (55,'test','2013-10-05 18:03:34',4,2,'NO_READ',''),
 (56,'test','2013-10-05 18:03:35',4,2,'NO_READ',''),
 (57,'test','2013-10-05 18:03:35',4,2,'NO_READ',''),
 (58,'test','2013-10-05 18:03:35',4,2,'NO_READ',''),
 (59,'test','2013-10-05 18:03:36',4,2,'NO_READ',''),
 (60,'test','2013-10-05 18:03:36',4,2,'NO_READ',''),
 (61,'test','2013-10-05 18:03:36',4,2,'NO_READ',''),
 (62,'test','2013-10-05 18:03:36',4,2,'NO_READ',''),
 (63,'test','2013-10-05 18:03:36',4,2,'NO_READ',''),
 (64,'test','2013-10-05 18:03:36',4,2,'NO_READ',''),
 (65,'test','2013-10-05 18:03:37',4,2,'NO_READ',''),
 (66,'test','2013-10-05 18:03:37',4,2,'NO_READ',''),
 (67,'test','2013-10-05 18:03:37',4,2,'NO_READ',''),
 (68,'test','2013-10-05 18:03:37',4,2,'NO_READ',''),
 (69,'test','2013-10-05 18:03:37',4,2,'NO_READ',''),
 (70,'test','2013-10-05 18:03:38',4,2,'NO_READ',''),
 (71,'test','2013-10-05 18:03:38',4,2,'NO_READ',''),
 (72,'test','2013-10-05 18:03:38',4,2,'NO_READ',''),
 (73,'test','2013-10-05 18:03:38',4,2,'NO_READ',''),
 (74,'test','2013-10-05 18:03:38',4,2,'NO_READ',''),
 (75,'test','2013-10-05 18:03:39',4,2,'NO_READ',''),
 (76,'test','2013-10-05 18:03:39',4,2,'NO_READ',''),
 (77,'test','2013-10-05 18:03:39',4,2,'NO_READ',''),
 (78,'test','2013-10-05 18:03:40',4,2,'NO_READ',''),
 (79,'test','2013-10-05 18:03:40',4,2,'NO_READ',''),
 (80,'test','2013-10-05 18:03:40',4,2,'NO_READ',''),
 (81,'test','2013-10-05 18:03:40',4,2,'NO_READ',''),
 (82,'test','2013-10-05 18:03:40',4,2,'NO_READ',''),
 (83,'test','2013-10-05 18:03:40',4,2,'NO_READ',''),
 (84,'test','2013-10-05 18:03:40',4,2,'NO_READ',''),
 (85,'test','2013-10-05 18:03:41',4,2,'NO_READ',''),
 (86,'test','2013-10-05 18:03:41',4,2,'NO_READ',''),
 (87,'test','2013-10-05 18:03:42',4,2,'NO_READ',''),
 (88,'test','2013-10-05 18:03:42',4,2,'NO_READ',''),
 (89,'test','2013-10-05 18:03:42',4,2,'NO_READ',''),
 (90,'test','2013-10-05 18:03:42',4,2,'NO_READ',''),
 (91,'test','2013-10-05 18:03:42',4,2,'NO_READ',''),
 (92,'test','2013-10-05 18:03:42',4,2,'NO_READ',''),
 (93,'test','2013-10-05 18:03:42',4,2,'NO_READ',''),
 (94,'test','2013-10-05 18:03:43',4,2,'HAD_READ',''),
 (95,'test','2013-10-05 18:03:43',4,2,'HAD_READ',''),
 (96,'test','2013-10-05 18:03:43',4,2,'HAD_READ',''),
 (97,'test','2013-10-05 18:03:43',4,2,'NO_READ',''),
 (98,'test','2013-10-05 18:03:43',4,2,'NO_READ','');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `picture`
--

/*!40000 ALTER TABLE `picture` DISABLE KEYS */;
INSERT INTO `picture` (`id`,`path`,`user_id`,`datetime`,`name`) VALUES 
 (4,'/upload/images/20131001/st_145818192.jpg',4,'2013-10-01 14:58:22','20130614030057870'),
 (5,'/upload/images/20131001/st_212712374.jpg',41,'2013-10-01 21:27:13','2'),
 (6,'/upload/images/20131001/st_212823050.jpg',41,'2013-10-01 21:28:22','1');
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `school`
--

/*!40000 ALTER TABLE `school` DISABLE KEYS */;
INSERT INTO `school` (`id`,`name`,`logo_path`) VALUES 
 (1,'南开大学','/xiaojh/xiaowei/nankai.png'),
 (2,'天津大学','/xiaojh/xiaowei/tju.png'),
 (3,'天津工业大学','/xiaojh/xiaowei/tjpu.png'),
 (4,'天津理工大学','/xiaojh/xiaowei/nankai.png'),
 (5,'天津师范大学','/xiaojh/xiaowei/tjsf.png'),
 (6,'天津城建学院','/xiaojh/xiaowei/nankai.png'),
 (7,'天津农学院','/xiaojh/xiaowei/nankai.png'),
 (8,'天津宝德商学院','/xiaojh/xiaowei/nankai.png'),
 (9,'天津天狮大学','/xiaojh/xiaowei/nankai.png'),
 (10,'天津中医药大学','/xiaojh/xiaowei/nankai.png'),
 (11,'天津外国语大学','/xiaojh/xiaowei/nankai.png'),
 (12,'天津财经大学（和平）','/xiaojh/xiaowei/nankai.png'),
 (13,'天津医科大学','/xiaojh/xiaowei/nankai.png'),
 (14,'天津仁爱学院','/xiaojh/xiaowei/nankai.png'),
 (15,'天津科技大学','/xiaojh/xiaowei/nankai.png'),
 (16,'天津体育学院','/xiaojh/xiaowei/nankai.png'),
 (17,'天津职业技术师范大学','/xiaojh/xiaowei/nankai.png'),
 (18,'天津医科大学临床医学院','/xiaojh/xiaowei/nankai.png'),
 (19,'天津财经大学（河西）','/xiaojh/xiaowei/nankai.png'),
 (20,'天津美术学院','/xiaojh/xiaowei/nankai.png'),
 (21,'天津音乐学院','/xiaojh/xiaowei/nankai.png'),
 (22,'天津商业学院','/xiaojh/xiaowei/nankai.png'),
 (23,'河北工业大学','/xiaojh/xiaowei/nankai.png'),
 (24,'中国民航大学','/xiaojh/xiaowei/nankai.png'),
 (25,'南大滨海','/xiaojh/xiaowei/nankai.png');
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
 (6,0,0),
 (7,1,0),
 (8,0,0),
 (9,0,0),
 (10,0,0),
 (11,0,0),
 (12,0,0),
 (13,0,0),
 (14,1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `talking`
--

/*!40000 ALTER TABLE `talking` DISABLE KEYS */;
INSERT INTO `talking` (`id`,`text`,`datetime`,`user_id`,`url`,`url_type`,`share_talking_id`,`status`) VALUES 
 (1,'系统默认说说','2013-08-05 11:57:11',1,NULL,NULL,NULL,'DELETE'),
 (2,'测试用户1的说说(上传的视频)','2013-08-05 11:57:11',2,'<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>','VIDEO',NULL,'SHARE'),
 (3,'测试用户1的说说(土豆的视频)','2013-08-05 11:57:11',2,'<embed src=\"http://www.tudou.com/l/mvZlZmwpB2Y/&resourceId=0_05_05_99&iid=173717345&bid=05/v.swf\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" wmode=\"opaque\" width=\"480\" height=\"400\"></embed>','VIDEO',NULL,'SHARE'),
 (4,'测试用户1的说说(优酷的视频)','2013-08-05 11:57:11',2,'<embed src=\"http://player.youku.com/player.php/sid/XMzIzNDk5MjAw/v.swf\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>','VIDEO',NULL,'SHARE'),
 (5,'测试用户1的说说(网上图片)','2013-08-05 11:57:11',2,'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','PICTURE',NULL,'SHARE'),
 (6,'商家1对应的用户的说说(上传的视频)','2013-08-05 11:57:11',11,'<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>','VIDEO',NULL,'SHARE'),
 (7,'商家1对应的用户的说说(土豆的视频)','2013-08-05 11:57:11',11,'<embed src=\"http://www.tudou.com/l/mvZlZmwpB2Y/&resourceId=0_05_05_99&iid=173717345&bid=05/v.swf\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" wmode=\"opaque\" width=\"480\" height=\"400\"></embed>','VIDEO',NULL,'SHARE'),
 (8,'商家1对应的用户的说说(优酷的视频)','2013-08-05 11:57:11',11,'<embed src=\"http://player.youku.com/player.php/sid/XMzIzNDk5MjAw/v.swf\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>','VIDEO',NULL,'SHARE'),
 (9,'商家1对应的用户的说说(网上图片)','2013-08-05 11:57:11',11,'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','PICTURE',NULL,'SHARE'),
 (10,'社团1对应的用户的说说(上传的视频)','2013-08-05 11:57:11',21,'<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>','VIDEO',NULL,'SHARE'),
 (11,'社团1对应的用户的说说(土豆的视频)','2013-08-05 11:57:11',21,'<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>','VIDEO',NULL,'SHARE'),
 (12,'社团1对应的用户的说说(优酷的视频)','2013-08-05 11:57:11',21,'<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>','VIDEO',NULL,'SHARE'),
 (13,'社团1对应的用户的说说(网上图片)','2013-08-05 11:57:11',21,'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg','PICTURE',NULL,'SHARE'),
 (14,'测试说说','2013-10-01 14:29:57',4,'',NULL,NULL,'SHARE'),
 (15,'@user3:分享没美化...','2013-10-04 17:50:48',2,NULL,NULL,14,'SHARE'),
 (16,'@merchantuser1:试试','2013-10-04 20:16:00',2,NULL,NULL,7,'SHARE');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `talking_comment`
--

/*!40000 ALTER TABLE `talking_comment` DISABLE KEYS */;
INSERT INTO `talking_comment` (`id`,`datetime`,`text`,`user_id`,`talking_id`) VALUES 
 (2,'2013-10-01 21:41:31','435456',2,2),
 (4,'2013-10-01 21:41:59','343546',2,2),
 (5,'2013-10-01 21:42:11','435456',2,14),
 (6,'2013-10-01 21:42:23','@<a class=\'f12 user_name_color\' href=\'userHome?user.id=2\' target=\'_blank\'>user1</a>:43545646',2,2),
 (7,'2013-10-01 21:42:57','@<a class=\'f12 user_name_color\' href=\'userHome?user.id=2\' target=\'_blank\'>user1</a>:43545646',2,2),
 (8,'2013-10-01 21:43:00','@<a class=\'f12 user_name_color\' href=\'userHome?user.id=2\' target=\'_blank\'>user1</a>:3546',2,2),
 (10,'2013-10-04 17:49:53','我擦',2,14),
 (11,'2013-10-04 17:50:06','@<a class=\'f12 user_name_color\' href=\'userHome?user.id=2\' target=\'_blank\'>user1</a>:你妹',2,14);
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
  `school_id` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`,`name`,`password`,`signature`,`school_id`,`announcement_count`,`email`,`sex`,`real_name`,`subject`,`profession`,`grade`,`birthday`,`phone`,`qq`,`portrait_path`,`liveness`,`popularity`,`receive_letter_count`,`status`,`code`) VALUES 
 (1,'系统用户','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN','我的真名','软件工程','软件工程',2013,'2013-08-05','13666666666','05465757','upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (2,'user1','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,1,13,'wodeyouxiang@163.com','MAN','','软件工程','软件工程',2013,'2013-08-05','13666666666','05465757','upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (3,'user2','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,1,9,'wodeyouxiang@163.com','MAN','我的真名','软件工程','软件工程',2013,'2013-08-05','13666666666','05465757','upload/portrait/auto_photo.png',0,0,0,'ADMIN',NULL),
 (4,'user3','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,1,9,'wodeyouxiang@163.com','MAN','我的真名','软件工程','软件工程',2013,'2013-08-05','13666666666','05465757','upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (5,'user4','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,1,9,'wodeyouxiang@163.com','MAN','我的真名','软件工程','软件工程',2013,'2013-08-05','13666666666','05465757','upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (6,'user5','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,1,9,'wodeyouxiang@163.com','MAN','我的真名','软件工程','软件工程',2013,'2013-08-05','13666666666','05465757','upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (7,'user6','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,2,9,'wodeyouxiang@163.com','MAN','我的真名','软件工程','软件工程',2013,'2013-08-05','13666666666','05465757','upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (8,'user7','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,2,9,'wodeyouxiang@163.com','MAN','我的真名','软件工程','软件工程',2013,'2013-08-05','13666666666','05465757','upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (9,'user8','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,3,9,'wodeyouxiang@163.com','MAN','我的真名','软件工程','软件工程',2013,'2013-08-05','13666666666','05465757','upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (10,'user9','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,3,9,'wodeyouxiang@163.com','MAN','我的真名','软件工程','软件工程',2013,'2013-08-05','13666666666','05465757','upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (11,'merchantuser1','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,4,9,'wodeyouxiang@163.com','MAN','我的真名','软件工程','软件工程',2013,'2013-08-05','13666666666','05465757','upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL),
 (12,'merchantuser2','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN','我的真名',NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (13,'merchantuser3','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN','我的真名',NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (14,'merchantuser4','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN','我的真名',NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (15,'merchantuser5','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (16,'merchantuser6','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (17,'merchantuser7','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (18,'merchantuser8','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN','',NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (19,'merchantuser9','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (20,'merchantuser10','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN','我的真名',NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (21,'clubuser1','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (22,'clubuser2','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (23,'clubuser3','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (24,'clubuser4','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (25,'clubuser5','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (26,'clubuser6','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (27,'clubuser7','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (28,'clubuser8','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (29,'clubuser9','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (30,'clubuser10','feea6340d7192d5e5b3095dc7d1b683e',0xE68891E79A84E4B8AAE680A7E7ADBEE5908D,NULL,9,'wodeyouxiang@163.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (41,'test','dd34716876364a02d0195e2fb9ae2d1b','',1,0,'527519996@qq.com','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'VALIDATED',NULL),
 (44,'1_变态社','变态社','',1,0,'变态社','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'SYSTEM',NULL),
 (45,'1_测试','测试','',1,0,'测试','MAN',NULL,NULL,NULL,2013,NULL,NULL,NULL,NULL,0,0,0,'SYSTEM',NULL),
 (46,'test1','dd34716876364a02d0195e2fb9ae2d1b','',1,0,'Devil0332@hotmail.com','MAN','','','',2013,NULL,'','','upload/portrait/auto_photo.png',0,0,0,'VALIDATED',NULL);
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
 (2,1),
 (2,2),
 (2,3),
 (2,4);
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
 (2,1),
 (3,1),
 (2,2),
 (3,2),
 (41,11);
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
 (3,2),
 (4,2),
 (6,2),
 (41,2),
 (2,3),
 (2,4),
 (41,4),
 (2,5),
 (41,5),
 (41,6),
 (41,7),
 (41,8),
 (41,9);
/*!40000 ALTER TABLE `user_focus_user` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
