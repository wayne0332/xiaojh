SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `xiaojh` ;
CREATE SCHEMA IF NOT EXISTS `xiaojh` DEFAULT CHARACTER SET utf8 ;
USE `xiaojh` ;

-- -----------------------------------------------------
-- Table `xiaojh`.`school`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`school` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`school` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(100) NOT NULL ,
  `logo_path` VARCHAR(250) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`user` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `signature` VARCHAR(300) BINARY NOT NULL DEFAULT '' COMMENT '类似于qq的个性签名(状态)' ,
  `school_id` INT NULL ,
  `announcement_count` INT NOT NULL DEFAULT 0 COMMENT '通知数量 在通知那用触发器弄' ,
  `email` VARCHAR(45) NOT NULL ,
  `sex` VARCHAR(45) NOT NULL ,
  `real_name` VARCHAR(45) NULL ,
  `subject` VARCHAR(45) NULL COMMENT '院系' ,
  `profession` VARCHAR(45) NULL ,
  `grade` INT NOT NULL COMMENT '填的入学年份' ,
  `birthday` DATE NULL ,
  `phone` VARCHAR(45) NULL ,
  `qq` VARCHAR(45) NULL ,
  `portrait_path` VARCHAR(250) NULL COMMENT '头像' ,
  `liveness` INT NOT NULL DEFAULT 0 COMMENT '活跃度' ,
  `popularity` INT NOT NULL DEFAULT 0 COMMENT '知名度' ,
  `receive_letter_count` INT NOT NULL DEFAULT 0 ,
  `status` VARCHAR(45) NOT NULL ,
  `code` VARCHAR(200) NULL COMMENT '验证和修改密码时的码' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  INDEX `fk_user_school1` (`school_id` ASC) ,
  CONSTRAINT `fk_user_school1`
    FOREIGN KEY (`school_id` )
    REFERENCES `xiaojh`.`school` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`picture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`picture` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`picture` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `path` VARCHAR(250) NOT NULL ,
  `user_id` INT NOT NULL ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_picture_user` (`user_id` ASC) ,
  CONSTRAINT `fk_picture_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`user_focus_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`user_focus_user` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`user_focus_user` (
  `source_user_id` INT NOT NULL ,
  `target_user_id` INT NOT NULL ,
  PRIMARY KEY (`source_user_id`, `target_user_id`) ,
  INDEX `fk_user_has_user_user2` (`target_user_id` ASC) ,
  INDEX `fk_user_has_user_user1` (`source_user_id` ASC) ,
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`source_user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`target_user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`personal_letter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`personal_letter` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`personal_letter` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `text` VARCHAR(300) NOT NULL ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `source_user_id` INT NOT NULL ,
  `target_user_id` INT NOT NULL ,
  `status` VARCHAR(45) NOT NULL COMMENT '状态,判断是否已读删除等' ,
  `title` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_personal_letter_user1` (`source_user_id` ASC) ,
  INDEX `fk_personal_letter_user2` (`target_user_id` ASC) ,
  CONSTRAINT `fk_personal_letter_user1`
    FOREIGN KEY (`source_user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_letter_user2`
    FOREIGN KEY (`target_user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`talking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`talking` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`talking` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `text` VARCHAR(300) NOT NULL ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `user_id` INT NOT NULL ,
  `url` VARCHAR(500) NULL ,
  `url_type` VARCHAR(45) NULL COMMENT '枚举(图片,视屏)' ,
  `share_talking_id` INT NULL ,
  `status` VARCHAR(45) NOT NULL COMMENT '不分享,删除等' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_talking_user1` (`user_id` ASC) ,
  INDEX `fk_talking_talking1` (`share_talking_id` ASC) ,
  CONSTRAINT `fk_talking_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_talking_talking1`
    FOREIGN KEY (`share_talking_id` )
    REFERENCES `xiaojh`.`talking` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`club` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`club` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `introduction` TEXT NOT NULL ,
  `name` VARCHAR(100) NOT NULL ,
  `logo_path` VARCHAR(250) NOT NULL ,
  `liveness` INT NOT NULL DEFAULT 0 COMMENT '活跃度' ,
  `proprieter_user_id` INT NOT NULL ,
  `school_id` INT NOT NULL ,
  `type` VARCHAR(45) NOT NULL COMMENT '类型,全部写死(音乐类,体育类等)' ,
  `status` VARCHAR(45) NOT NULL COMMENT '是否通过审核等' ,
  `member_number` INT NOT NULL DEFAULT 0 COMMENT '社团人数,触发器没弄' ,
  `brief_introduction` VARCHAR(200) NOT NULL ,
  `popularity` INT NOT NULL DEFAULT 0 COMMENT '知名度' ,
  `user_id` INT NOT NULL ,
  INDEX `fk_club_user1` (`proprieter_user_id` ASC) ,
  INDEX `fk_club_school1` (`school_id` ASC) ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_club_user2` (`user_id` ASC) ,
  CONSTRAINT `fk_club_user1`
    FOREIGN KEY (`proprieter_user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_school1`
    FOREIGN KEY (`school_id` )
    REFERENCES `xiaojh`.`school` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_user2`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`club_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`club_member` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`club_member` (
  `club_id` INT NOT NULL ,
  `user_id` INT NOT NULL ,
  `source` VARCHAR(45) NOT NULL COMMENT '表示谁向谁申请 枚举类型 (社团,用户)' ,
  `status` VARCHAR(45) NOT NULL COMMENT '这个请求的情况(未操作,通过,拒绝)' ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `role` VARCHAR(45) NOT NULL COMMENT '枚举(普通社员,社团管理员,社长)' ,
  PRIMARY KEY (`club_id`, `user_id`) ,
  INDEX `fk_club_has_user_user1` (`user_id` ASC) ,
  INDEX `fk_club_has_user_club1` (`club_id` ASC) ,
  CONSTRAINT `fk_club_has_user_club1`
    FOREIGN KEY (`club_id` )
    REFERENCES `xiaojh`.`club` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_has_user_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`club_news`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`club_news` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`club_news` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tittle` VARCHAR(200) NOT NULL ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `text` TEXT NOT NULL ,
  `title_img_path` VARCHAR(250) NOT NULL ,
  `video_url` VARCHAR(500) NULL ,
  `club_id` INT NOT NULL ,
  `talking_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_trends_club1` (`club_id` ASC) ,
  INDEX `fk_club_news_talking1` (`talking_id` ASC) ,
  CONSTRAINT `fk_trends_club1`
    FOREIGN KEY (`club_id` )
    REFERENCES `xiaojh`.`club` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_news_talking1`
    FOREIGN KEY (`talking_id` )
    REFERENCES `xiaojh`.`talking` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`talking_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`talking_comment` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`talking_comment` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `text` VARCHAR(300) NOT NULL ,
  `user_id` INT NOT NULL ,
  `talking_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_comment_user1` (`user_id` ASC) ,
  INDEX `fk_talking_comment_talking1` (`talking_id` ASC) ,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_talking_comment_talking1`
    FOREIGN KEY (`talking_id` )
    REFERENCES `xiaojh`.`talking` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`club_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`club_post` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`club_post` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `text` TEXT NOT NULL ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `praise_count` INT NOT NULL DEFAULT 0 ,
  `user_id` INT NOT NULL ,
  `club_id` INT NOT NULL ,
  `title` VARCHAR(200) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_post_user1` (`user_id` ASC) ,
  INDEX `fk_post_club1` (`club_id` ASC) ,
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_club1`
    FOREIGN KEY (`club_id` )
    REFERENCES `xiaojh`.`club` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`club_post_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`club_post_comment` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`club_post_comment` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `text` VARCHAR(300) NOT NULL ,
  `club_post_id` INT NOT NULL ,
  `user_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_post_comment_post1` (`club_post_id` ASC) ,
  INDEX `fk_post_comment_user1` (`user_id` ASC) ,
  CONSTRAINT `fk_post_comment_post1`
    FOREIGN KEY (`club_post_id` )
    REFERENCES `xiaojh`.`club_post` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_comment_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`announcement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`announcement` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`announcement` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `title` VARCHAR(200) NOT NULL ,
  `text` VARCHAR(300) NOT NULL ,
  `club_id` INT NULL COMMENT '有为社团通知,没有为全局通知' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_announcement_club1` (`club_id` ASC) ,
  CONSTRAINT `fk_announcement_club1`
    FOREIGN KEY (`club_id` )
    REFERENCES `xiaojh`.`club` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`merchant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`merchant` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`merchant` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `template` VARCHAR(300) NULL COMMENT '自定义模块字段' ,
  `status` VARCHAR(45) NOT NULL ,
  `type` VARCHAR(45) NOT NULL COMMENT '国企、私企、外企' ,
  `business` VARCHAR(45) NOT NULL COMMENT '电子、餐饮、酒店、教育、会展、传媒、家政、电器、超市、婚庆、医疗、互联网、房地产、金融、物流、保险、服装、家具、其他' ,
  `purpose` VARCHAR(45) NOT NULL COMMENT '校园赞助、兼职、商品买卖、品牌推广、创业投资、其他   可多选' ,
  `address` VARCHAR(300) NOT NULL ,
  `phone` VARCHAR(45) NOT NULL ,
  `connector_name` VARCHAR(45) NOT NULL COMMENT '联系人' ,
  `connector_phone` VARCHAR(45) NOT NULL ,
  `connector_qq` VARCHAR(45) NOT NULL ,
  `connector_email` VARCHAR(45) NOT NULL ,
  `liveness` INT NOT NULL DEFAULT 0 COMMENT '活跃度' ,
  `popularity` INT NOT NULL DEFAULT 0 COMMENT '知名度' ,
  `user_id` INT NOT NULL ,
  `merchantName` VARCHAR(100) NOT NULL ,
  `logo_path` VARCHAR(250) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_merchant_user1` (`user_id` ASC) ,
  CONSTRAINT `fk_merchant_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`user_focus_club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`user_focus_club` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`user_focus_club` (
  `user_id` INT NOT NULL ,
  `club_id` INT NOT NULL ,
  PRIMARY KEY (`user_id`, `club_id`) ,
  INDEX `fk_user_has_club_club1` (`club_id` ASC) ,
  INDEX `fk_user_has_club_user1` (`user_id` ASC) ,
  CONSTRAINT `fk_user_has_club_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_club_club1`
    FOREIGN KEY (`club_id` )
    REFERENCES `xiaojh`.`club` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`club_focus_club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`club_focus_club` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`club_focus_club` (
  `source_club_id` INT NOT NULL ,
  `target_club_id` INT NOT NULL ,
  PRIMARY KEY (`source_club_id`, `target_club_id`) ,
  INDEX `fk_club_has_club_club2` (`target_club_id` ASC) ,
  INDEX `fk_club_has_club_club1` (`source_club_id` ASC) ,
  CONSTRAINT `fk_club_has_club_club1`
    FOREIGN KEY (`source_club_id` )
    REFERENCES `xiaojh`.`club` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_has_club_club2`
    FOREIGN KEY (`target_club_id` )
    REFERENCES `xiaojh`.`club` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`merchant_focus_merchant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`merchant_focus_merchant` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`merchant_focus_merchant` (
  `merchant_id` INT NOT NULL ,
  `merchant_id1` INT NOT NULL ,
  PRIMARY KEY (`merchant_id`, `merchant_id1`) ,
  INDEX `fk_merchant_has_merchant_merchant2` (`merchant_id1` ASC) ,
  INDEX `fk_merchant_has_merchant_merchant1` (`merchant_id` ASC) ,
  CONSTRAINT `fk_merchant_has_merchant_merchant1`
    FOREIGN KEY (`merchant_id` )
    REFERENCES `xiaojh`.`merchant` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_merchant_has_merchant_merchant2`
    FOREIGN KEY (`merchant_id1` )
    REFERENCES `xiaojh`.`merchant` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`merchant_focus_club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`merchant_focus_club` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`merchant_focus_club` (
  `merchant_id` INT NOT NULL ,
  `club_id` INT NOT NULL ,
  PRIMARY KEY (`merchant_id`, `club_id`) ,
  INDEX `fk_merchant_has_club_club1` (`club_id` ASC) ,
  INDEX `fk_merchant_has_club_merchant1` (`merchant_id` ASC) ,
  CONSTRAINT `fk_merchant_has_club_merchant1`
    FOREIGN KEY (`merchant_id` )
    REFERENCES `xiaojh`.`merchant` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_merchant_has_club_club1`
    FOREIGN KEY (`club_id` )
    REFERENCES `xiaojh`.`club` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`merchant_news`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`merchant_news` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`merchant_news` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tittle` VARCHAR(200) NOT NULL ,
  `text` TEXT NOT NULL ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `url` VARCHAR(500) NULL ,
  `url_type` VARCHAR(45) NULL ,
  `merchant_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_merchant_news_merchant1` (`merchant_id` ASC) ,
  CONSTRAINT `fk_merchant_news_merchant1`
    FOREIGN KEY (`merchant_id` )
    REFERENCES `xiaojh`.`merchant` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`activity` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`activity` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tittle` VARCHAR(200) NOT NULL ,
  `text` TEXT NOT NULL ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `video_url` VARCHAR(500) NULL ,
  `title_img_path` VARCHAR(250) NOT NULL ,
  `place` VARCHAR(200) NOT NULL ,
  `hold_club_id` INT NULL COMMENT '两个主办方外键只能有一个 看要不要用trigger' ,
  `hold_merchant_id` INT NULL ,
  `organizer` VARCHAR(500) NOT NULL ,
  `heat` INT NOT NULL DEFAULT 0 COMMENT '热度 用trigger' ,
  `budget` VARCHAR(100) NOT NULL ,
  `status` VARCHAR(45) NOT NULL COMMENT '申请,正在进行,结束' ,
  `talking_id` INT NOT NULL ,
  `participant_count` INT NOT NULL DEFAULT 0 COMMENT '参加人数 触发器控制' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_activity_club1` (`hold_club_id` ASC) ,
  INDEX `fk_activity_merchant1` (`hold_merchant_id` ASC) ,
  INDEX `fk_activity_talking1` (`talking_id` ASC) ,
  CONSTRAINT `fk_activity_club1`
    FOREIGN KEY (`hold_club_id` )
    REFERENCES `xiaojh`.`club` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_merchant1`
    FOREIGN KEY (`hold_merchant_id` )
    REFERENCES `xiaojh`.`merchant` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_talking1`
    FOREIGN KEY (`talking_id` )
    REFERENCES `xiaojh`.`talking` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`activity_participant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`activity_participant` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`activity_participant` (
  `activity_id` INT NOT NULL ,
  `user_id` INT NOT NULL ,
  PRIMARY KEY (`activity_id`, `user_id`) ,
  INDEX `fk_activity_has_user_user1` (`user_id` ASC) ,
  INDEX `fk_activity_has_user_activity1` (`activity_id` ASC) ,
  CONSTRAINT `fk_activity_has_user_activity1`
    FOREIGN KEY (`activity_id` )
    REFERENCES `xiaojh`.`activity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_has_user_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`user_focus_merchant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`user_focus_merchant` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`user_focus_merchant` (
  `user_id` INT NOT NULL ,
  `merchant_id` INT NOT NULL ,
  PRIMARY KEY (`user_id`, `merchant_id`) ,
  INDEX `fk_user_has_merchant_merchant1` (`merchant_id` ASC) ,
  INDEX `fk_user_has_merchant_user1` (`user_id` ASC) ,
  CONSTRAINT `fk_user_has_merchant_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_merchant_merchant1`
    FOREIGN KEY (`merchant_id` )
    REFERENCES `xiaojh`.`merchant` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`share_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`share_details` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`share_details` (
  `talking_id` INT NOT NULL COMMENT '级联删除先依赖hibernate 不行再弄删除的trigger' ,
  `share_count` INT NOT NULL DEFAULT 0 ,
  `praise_count` INT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`talking_id`) ,
  CONSTRAINT `fk_share_talking1`
    FOREIGN KEY (`talking_id` )
    REFERENCES `xiaojh`.`talking` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`online_activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`online_activity` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`online_activity` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tittle` VARCHAR(200) NOT NULL ,
  `text` TEXT NOT NULL ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `video_url` VARCHAR(500) NULL ,
  `title_img_path` VARCHAR(250) NOT NULL ,
  `heat` INT NOT NULL DEFAULT 0 COMMENT '热度 用trigger' ,
  `status` VARCHAR(45) NOT NULL COMMENT '申请,正在进行,结束' ,
  `talking_id` INT NOT NULL ,
  `hold_user_id` INT NOT NULL ,
  `participant_count` INT NOT NULL DEFAULT 0 COMMENT '参加人数' ,
  `praise_count` INT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_activity_talking1` (`talking_id` ASC) ,
  INDEX `fk_online_activity_user1` (`hold_user_id` ASC) ,
  CONSTRAINT `fk_activity_talking10`
    FOREIGN KEY (`talking_id` )
    REFERENCES `xiaojh`.`talking` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_online_activity_user1`
    FOREIGN KEY (`hold_user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`activity_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`activity_post` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`activity_post` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `text` TEXT NOT NULL ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `praise_count` INT NOT NULL DEFAULT 0 ,
  `user_id` INT NOT NULL ,
  `online_activity_id` INT NOT NULL ,
  `title` VARCHAR(200) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_post_user1` (`user_id` ASC) ,
  INDEX `fk_activity_post_online_activity1` (`online_activity_id` ASC) ,
  CONSTRAINT `fk_post_user10`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_post_online_activity1`
    FOREIGN KEY (`online_activity_id` )
    REFERENCES `xiaojh`.`online_activity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`activity_post_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`activity_post_comment` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`activity_post_comment` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `text` VARCHAR(300) NOT NULL ,
  `user_id` INT NOT NULL ,
  `activity_post_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_post_comment_user1` (`user_id` ASC) ,
  INDEX `fk_activity_post_comment_activity_post1` (`activity_post_id` ASC) ,
  CONSTRAINT `fk_post_comment_user10`
    FOREIGN KEY (`user_id` )
    REFERENCES `xiaojh`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_post_comment_activity_post1`
    FOREIGN KEY (`activity_post_id` )
    REFERENCES `xiaojh`.`activity_post` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`advertisement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`advertisement` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`advertisement` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `type` VARCHAR(45) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `height` INT NULL ,
  `width` INT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`club_focus_merchant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`club_focus_merchant` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`club_focus_merchant` (
  `club_id` INT NOT NULL ,
  `merchant_id` INT NOT NULL ,
  PRIMARY KEY (`club_id`, `merchant_id`) ,
  INDEX `fk_club_has_merchant_merchant1` (`merchant_id` ASC) ,
  INDEX `fk_club_has_merchant_club1` (`club_id` ASC) ,
  CONSTRAINT `fk_club_has_merchant_club1`
    FOREIGN KEY (`club_id` )
    REFERENCES `xiaojh`.`club` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_has_merchant_merchant1`
    FOREIGN KEY (`merchant_id` )
    REFERENCES `xiaojh`.`merchant` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `xiaojh`.`advertisement_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `xiaojh`.`advertisement_content` ;

CREATE  TABLE IF NOT EXISTS `xiaojh`.`advertisement_content` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `advertisement_id` INT NOT NULL ,
  `content_path` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(64) NULL ,
  `code` VARCHAR(512) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_content_advertisement` (`advertisement_id` ASC) ,
  CONSTRAINT `fk_content_advertisement`
    FOREIGN KEY (`advertisement_id` )
    REFERENCES `xiaojh`.`advertisement` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `xiaojh`;

DELIMITER $$

USE `xiaojh`$$
DROP TRIGGER IF EXISTS `xiaojh`.`user_letter` $$
USE `xiaojh`$$






create trigger user_letter
after insert on personal_letter
for each row
begin
    update user set receive_letter_count=receive_letter_count + 1 where id=new.target_user_id;
end;
$$


DELIMITER ;

DELIMITER $$

USE `xiaojh`$$
DROP TRIGGER IF EXISTS `xiaojh`.`share_count` $$
USE `xiaojh`$$






create trigger share_count
after insert on talking
for each row
begin
    if new.share_talking_id is not null then
        update share_details set share_count=share_count + 1 where talking_id=new.share_talking_id;
    else
        insert into share_details(talking_id) values(new.id);
    end if;
end;
$$


DELIMITER ;

DELIMITER $$

USE `xiaojh`$$
DROP TRIGGER IF EXISTS `xiaojh`.`user_announcement` $$
USE `xiaojh`$$






create trigger user_announcement
after insert on announcement
for each row
begin
    if new.club_id is null then
        update user set announcement_count=announcement_count + 1;
    else
        update user set announcement_count=announcement_count + 1 where id in (select user_id from club_member where club_id=new.club_id);
    end if;
end;
$$


DELIMITER ;

DELIMITER $$

USE `xiaojh`$$
DROP TRIGGER IF EXISTS `xiaojh`.`add_participant_count` $$
USE `xiaojh`$$






create trigger add_participant_count
after insert on activity_participant
for each row
begin
    update activity set participant_count=participant_count + 1 where id=new.activity_id;
end;
$$


DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`school`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`school` (`id`, `name`, `logo_path`) VALUES (1, '南开大学', 'test/xiaojh/xiaowei/nankai.png');
INSERT INTO `xiaojh`.`school` (`id`, `name`, `logo_path`) VALUES (NULL, '天津大学', '/xiaojh/xiaowei/tju.png');
INSERT INTO `xiaojh`.`school` (`id`, `name`, `logo_path`) VALUES (NULL, '天津工业大学', '/xiaojh/xiaowei/tjpu.png');
INSERT INTO `xiaojh`.`school` (`id`, `name`, `logo_path`) VALUES (NULL, '天津理工大学', 'test/xiaojh/xiaowei/nankai.png');
INSERT INTO `xiaojh`.`school` (`id`, `name`, `logo_path`) VALUES (NULL, '天津师范大学', '/xiaojh/xiaowei/tjsf.png');
INSERT INTO `xiaojh`.`school` (`id`, `name`, `logo_path`) VALUES (NULL, '天津城市建设学院', 'test/xiaojh/xiaowei/nankai.png');
INSERT INTO `xiaojh`.`school` (`id`, `name`, `logo_path`) VALUES (NULL, '天津农学院', 'test/xiaojh/xiaowei/nankai.png');
INSERT INTO `xiaojh`.`school` (`id`, `name`, `logo_path`) VALUES (NULL, '天津宝德商学院', 'test/xiaojh/xiaowei/nankai.png');

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (2, 'user1', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', 1, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', '软件工程', '软件工程', 2013, '2013-08-05 10:53:54', '13666666666', '05465757', 'upload/portrait/auto_photo.png', 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (3, 'user2', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', 1, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', '软件工程', '软件工程', 2013, '2013-08-05 10:53:54', '13666666666', '05465757', 'upload/portrait/auto_photo.png', 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (4, 'user3', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', 1, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', '软件工程', '软件工程', 2013, '2013-08-05 10:53:54', '13666666666', '05465757', 'upload/portrait/auto_photo.png', 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (5, 'user4', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', 1, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', '软件工程', '软件工程', 2013, '2013-08-05 10:53:54', '13666666666', '05465757', 'upload/portrait/auto_photo.png', 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (6, 'user5', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', 1, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', '软件工程', '软件工程', 2013, '2013-08-05 10:53:54', '13666666666', '05465757', 'upload/portrait/auto_photo.png', 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (7, 'user6', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', 2, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', '软件工程', '软件工程', 2013, '2013-08-05 10:53:54', '13666666666', '05465757', 'upload/portrait/auto_photo.png', 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (8, 'user7', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', 2, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', '软件工程', '软件工程', 2013, '2013-08-05 10:53:54', '13666666666', '05465757', 'upload/portrait/auto_photo.png', 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (9, 'user8', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', 3, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', '软件工程', '软件工程', 2013, '2013-08-05 10:53:54', '13666666666', '05465757', 'upload/portrait/auto_photo.png', 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (10, 'user9', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', 3, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', '软件工程', '软件工程', 2013, '2013-08-05 10:53:54', '13666666666', '05465757', 'upload/portrait/auto_photo.png', 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (11, 'merchantuser1', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', 4, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', '软件工程', '软件工程', 2013, '2013-08-05 10:53:54', '13666666666', '05465757', 'upload/portrait/auto_photo.png', 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (1, '系统用户', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', '软件工程', '软件工程', 2013, '2013-08-05 10:53:54', '13666666666', '05465757', 'upload/portrait/auto_photo.png', 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (20, 'merchantuser10', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (12, 'merchantuser2', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (13, 'merchantuser3', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (14, 'merchantuser4', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', '我的真名', NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (15, 'merchantuser5', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (16, 'merchantuser6', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (17, 'merchantuser7', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (18, 'merchantuser8', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', '', NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (19, 'merchantuser9', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (21, 'clubuser1', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (22, 'clubuser2', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (23, 'clubuser3', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (24, 'clubuser4', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (25, 'clubuser5', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (26, 'clubuser6', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (27, 'clubuser7', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (28, 'clubuser8', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (29, 'clubuser9', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);
INSERT INTO `xiaojh`.`user` (`id`, `name`, `password`, `signature`, `school_id`, `announcement_count`, `email`, `sex`, `real_name`, `subject`, `profession`, `grade`, `birthday`, `phone`, `qq`, `portrait_path`, `liveness`, `popularity`, `receive_letter_count`, `status`, `code`) VALUES (30, 'clubuser10', 'feea6340d7192d5e5b3095dc7d1b683e', '我的个性签名', NULL, 0, 'wodeyouxiang@163.com', 'MAN', NULL, NULL, NULL, 2013, NULL, NULL, NULL, NULL, 0, 0, 0, 'VALIDATED', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`user_focus_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`user_focus_user` (`source_user_id`, `target_user_id`) VALUES (2, 3);
INSERT INTO `xiaojh`.`user_focus_user` (`source_user_id`, `target_user_id`) VALUES (3, 2);
INSERT INTO `xiaojh`.`user_focus_user` (`source_user_id`, `target_user_id`) VALUES (2, 4);
INSERT INTO `xiaojh`.`user_focus_user` (`source_user_id`, `target_user_id`) VALUES (4, 2);
INSERT INTO `xiaojh`.`user_focus_user` (`source_user_id`, `target_user_id`) VALUES (2, 5);
INSERT INTO `xiaojh`.`user_focus_user` (`source_user_id`, `target_user_id`) VALUES (2, 6);
INSERT INTO `xiaojh`.`user_focus_user` (`source_user_id`, `target_user_id`) VALUES (6, 2);
INSERT INTO `xiaojh`.`user_focus_user` (`source_user_id`, `target_user_id`) VALUES (5, 2);

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`talking`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (1, '系统默认说说', '2013-08-05 11:57:11', 1, NULL, NULL, NULL, 'DELETE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (2, '测试用户1的说说(上传的视频)', '2013-08-05 11:57:11', 2, '<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>', 'VIDEO', NULL, 'SHARE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (3, '测试用户1的说说(土豆的视频)', '2013-08-05 11:57:11', 2, '<embed src=\"http://www.tudou.com/l/mvZlZmwpB2Y/&resourceId=0_05_05_99&iid=173717345&bid=05/v.swf\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" wmode=\"opaque\" width=\"480\" height=\"400\"></embed>', 'VIDEO', NULL, 'SHARE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (4, '测试用户1的说说(优酷的视频)', '2013-08-05 11:57:11', 2, '<embed src=\"http://player.youku.com/player.php/sid/XMzIzNDk5MjAw/v.swf\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>', 'VIDEO', NULL, 'SHARE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (5, '测试用户1的说说(网上图片)', '2013-08-05 11:57:11', 2, 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', 'PICTURE', NULL, 'SHARE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (6, '商家1对应的用户的说说(上传的视频)', '2013-08-05 11:57:11', 11, '<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>', 'VIDEO', NULL, 'SHARE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (7, '商家1对应的用户的说说(土豆的视频)', '2013-08-05 11:57:11', 11, '<embed src=\"http://www.tudou.com/l/mvZlZmwpB2Y/&resourceId=0_05_05_99&iid=173717345&bid=05/v.swf\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" wmode=\"opaque\" width=\"480\" height=\"400\"></embed>', 'VIDEO', NULL, 'SHARE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (8, '商家1对应的用户的说说(优酷的视频)', '2013-08-05 11:57:11', 11, '<embed src=\"http://player.youku.com/player.php/sid/XMzIzNDk5MjAw/v.swf\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>', 'VIDEO', NULL, 'SHARE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (9, '商家1对应的用户的说说(网上图片)', '2013-08-05 11:57:11', 11, 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', 'PICTURE', NULL, 'SHARE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (10, '社团1对应的用户的说说(上传的视频)', '2013-08-05 11:57:11', 21, '<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>', 'VIDEO', NULL, 'SHARE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (11, '社团1对应的用户的说说(土豆的视频)', '2013-08-05 11:57:11', 21, '<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>', 'VIDEO', NULL, 'SHARE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (12, '社团1对应的用户的说说(优酷的视频)', '2013-08-05 11:57:11', 21, '<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>', 'VIDEO', NULL, 'SHARE');
INSERT INTO `xiaojh`.`talking` (`id`, `text`, `datetime`, `user_id`, `url`, `url_type`, `share_talking_id`, `status`) VALUES (13, '社团1对应的用户的说说(网上图片)', '2013-08-05 11:57:11', 21, 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', 'PICTURE', NULL, 'SHARE');

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`club`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (1, '测试社团1', '测试社团1', 'upload/portrait/auto_photo.png', 0, 2, 1, 'SPORT', 'PASSED', 2, '社团简介', 88889, 21);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (2, '测试社团2', '测试社团2', 'upload/portrait/auto_photo.png', 0, 2, 2, 'SPORT', 'PASSED', 5, '社团简介', 888888, 22);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (3, '测试社团3', '测试社团3', 'upload/portrait/auto_photo.png', 0, 3, 1, 'SPORT', 'PASSED', 6, '社团简介', 8988, 23);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (4, '测试社团4', '测试社团4', 'upload/portrait/auto_photo.png', 0, 4, 1, 'SPORT', 'PASSED', 9, '社团简介', 63, 24);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (5, '测试社团5', '测试社团5', 'upload/portrait/auto_photo.png', 0, 5, 2, 'SPORT', 'PASSED', 9, '社团简介', 25, 25);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (6, '测试社团6', '测试社团6', 'upload/portrait/auto_photo.png', 0, 6, 2, 'MUSIC', 'PASSED', 5, '社团简介', 10, 26);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (7, '测试社团7', '测试社团7', 'upload/portrait/auto_photo.png', 0, 7, 2, 'MUSIC', 'PASSED', 5, '社团简介', 1, 27);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (8, '测试社团8', '测试社团8', 'upload/portrait/auto_photo.png', 0, 8, 1, 'MUSIC', 'PASSED', 5, '社团简介', 35, 28);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (9, '测试社团9', '测试社团9', 'upload/portrait/auto_photo.png', 0, 9, 3, 'MUSIC', 'PASSED', 6, '社团简介', 85, 29);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (10, '测试社团10', '测试社团10', 'upload/portrait/auto_photo.png', 0, 10, 3, 'LITERATURE', 'PASSED', 95, '社团简介', 46, 30);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (11, '测试社团11', '测试社团11', 'upload/portrait/auto_photo.png', 0, 2, 3, 'LITERATURE', 'PASSED', 45, '社团简介', 52, 21);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (12, '测试社团12', '测试社团12', 'upload/portrait/auto_photo.png', 0, 3, 3, 'IT', 'PASSED', 5, '社团简介', 35, 22);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (13, '测试社团13', '测试社团13', 'upload/portrait/auto_photo.png', 0, 4, 4, 'IT', 'PASSED', 4, '社团简介', 39, 23);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (14, '测试社团14', '测试社团14', 'upload/portrait/auto_photo.png', 0, 5, 4, 'IT', 'PASSED', 5, '社团简介', 75, 24);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (15, '测试社团15', '测试社团15', 'upload/portrait/auto_photo.png', 0, 6, 4, 'IT', 'PASSED', 5, '社团简介', 62, 25);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (16, '测试社团16', '测试社团16', 'upload/portrait/auto_photo.png', 0, 7, 4, 'IT', 'PASSED', 4, '社团简介', 999, 26);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (17, '测试社团17', '测试社团17', 'upload/portrait/auto_photo.png', 0, 8, 5, 'IT', 'PASSED', 8, '社团简介', 54, 27);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (18, '测试社团18', '测试社团18', 'upload/portrait/auto_photo.png', 0, 9, 5, 'IT', 'PASSED', 7, '社团简介', 61, 28);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (19, '测试社团19', '测试社团19', 'upload/portrait/auto_photo.png', 0, 10, 5, 'IT', 'PASSED', 9, '社团简介', 18, 29);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (20, '测试社团20', '测试社团20', 'upload/portrait/auto_photo.png', 0, 2, 1, 'IT', 'PASSED', 6, '社团简介', 39, 30);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (22, '测试社团22', '测试社团22', 'upload/portrait/auto_photo.png', 0, 3, 1, 'SPORT', 'PASSED', 54, '社团简介', 56, 21);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (23, '测试社团23', '测试社团23', 'upload/portrait/auto_photo.png', 0, 4, 1, 'SPORT', 'PASSED', 5, '社团简介', 78, 22);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (24, '测试社团24', '测试社团24', 'upload/portrait/auto_photo.png', 0, 5, 2, 'SPORT', 'PASSED', 85, '社团简介', 98, 23);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (25, '测试社团25', '测试社团25', 'upload/portrait/auto_photo.png', 0, 6, 4, 'SPORT', 'PASSED', 78, '社团简介', 78, 24);
INSERT INTO `xiaojh`.`club` (`id`, `introduction`, `name`, `logo_path`, `liveness`, `proprieter_user_id`, `school_id`, `type`, `status`, `member_number`, `brief_introduction`, `popularity`, `user_id`) VALUES (26, '测试社团26', '测试社团26', 'upload/portrait/auto_photo.png', 0, 7, 4, 'SPORT', 'PASSED', 12, '社团简介', 98, 25);

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`merchant`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`merchant` (`id`, `name`, `password`, `template`, `status`, `type`, `business`, `purpose`, `address`, `phone`, `connector_name`, `connector_phone`, `connector_qq`, `connector_email`, `liveness`, `popularity`, `user_id`, `merchantName`, `logo_path`) VALUES (1, 'merchant1', 'feea6340d7192d5e5b3095dc7d1b683e', '55', 'PASSED', 'STATE_OWNED', 'ELECTRON', '66', '6666', '666', '666', '66', '666', '66', 6, 64888, 11, '5446', 'upload/portrait/auto_photo.png');
INSERT INTO `xiaojh`.`merchant` (`id`, `name`, `password`, `template`, `status`, `type`, `business`, `purpose`, `address`, `phone`, `connector_name`, `connector_phone`, `connector_qq`, `connector_email`, `liveness`, `popularity`, `user_id`, `merchantName`, `logo_path`) VALUES (2, 'merchant2', 'feea6340d7192d5e5b3095dc7d1b683e', '5', 'PASSED', 'STATE_OWNED', 'ELECTRON', '6', '6', '66', '66', '66', '666', '66', 66, 468888, 12, '576', 'upload/portrait/auto_photo.png');
INSERT INTO `xiaojh`.`merchant` (`id`, `name`, `password`, `template`, `status`, `type`, `business`, `purpose`, `address`, `phone`, `connector_name`, `connector_phone`, `connector_qq`, `connector_email`, `liveness`, `popularity`, `user_id`, `merchantName`, `logo_path`) VALUES (3, 'merchant3', 'feea6340d7192d5e5b3095dc7d1b683e', '5', 'PASSED', 'STATE_OWNED', 'ELECTRON', '6', '666', '666', '66', '666666', '66', '66', 66, 54, 13, '89887', 'upload/portrait/auto_photo.png');
INSERT INTO `xiaojh`.`merchant` (`id`, `name`, `password`, `template`, `status`, `type`, `business`, `purpose`, `address`, `phone`, `connector_name`, `connector_phone`, `connector_qq`, `connector_email`, `liveness`, `popularity`, `user_id`, `merchantName`, `logo_path`) VALUES (4, 'merchant4', 'feea6340d7192d5e5b3095dc7d1b683e', '5', 'PASSED', 'STATE_OWNED', 'ELECTRON', '6', '666', '666', '666', '66', '66', '66666', 6, 6, 14, '6878', 'upload/portrait/auto_photo.png');
INSERT INTO `xiaojh`.`merchant` (`id`, `name`, `password`, `template`, `status`, `type`, `business`, `purpose`, `address`, `phone`, `connector_name`, `connector_phone`, `connector_qq`, `connector_email`, `liveness`, `popularity`, `user_id`, `merchantName`, `logo_path`) VALUES (5, 'merchant5', 'feea6340d7192d5e5b3095dc7d1b683e', '5', 'PASSED', 'STATE_OWNED', 'ELECTRON', '6', '66', '666', '666', '666', '66', '66', 66, 46, 15, '9909', 'upload/portrait/auto_photo.png');
INSERT INTO `xiaojh`.`merchant` (`id`, `name`, `password`, `template`, `status`, `type`, `business`, `purpose`, `address`, `phone`, `connector_name`, `connector_phone`, `connector_qq`, `connector_email`, `liveness`, `popularity`, `user_id`, `merchantName`, `logo_path`) VALUES (6, 'merchant6', 'feea6340d7192d5e5b3095dc7d1b683e', '5', 'PASSED', 'STATE_OWNED', 'ELECTRON', '6', '6666', '666', '666', '666', '66', '6666', 6, 46, 16, '6878', 'upload/portrait/auto_photo.png');
INSERT INTO `xiaojh`.`merchant` (`id`, `name`, `password`, `template`, `status`, `type`, `business`, `purpose`, `address`, `phone`, `connector_name`, `connector_phone`, `connector_qq`, `connector_email`, `liveness`, `popularity`, `user_id`, `merchantName`, `logo_path`) VALUES (7, 'merchant7', 'feea6340d7192d5e5b3095dc7d1b683e', '5', 'PASSED', 'STATE_OWNED', 'ELECTRON', '6', '666', '666', '666', '666', '6', '666', 6, 46, 17, '676', 'upload/portrait/auto_photo.png');
INSERT INTO `xiaojh`.`merchant` (`id`, `name`, `password`, `template`, `status`, `type`, `business`, `purpose`, `address`, `phone`, `connector_name`, `connector_phone`, `connector_qq`, `connector_email`, `liveness`, `popularity`, `user_id`, `merchantName`, `logo_path`) VALUES (8, 'merchant8', 'feea6340d7192d5e5b3095dc7d1b683e', '5', 'PASSED', 'STATE_OWNED', 'ELECTRON', '6', '666', '666', '666', '666', '666', '66', 6, 46, 18, '876', 'upload/portrait/auto_photo.png');
INSERT INTO `xiaojh`.`merchant` (`id`, `name`, `password`, `template`, `status`, `type`, `business`, `purpose`, `address`, `phone`, `connector_name`, `connector_phone`, `connector_qq`, `connector_email`, `liveness`, `popularity`, `user_id`, `merchantName`, `logo_path`) VALUES (9, 'merchant9', 'feea6340d7192d5e5b3095dc7d1b683e', '5', 'PASSED', 'STATE_OWNED', 'ELECTRON', '6', '666', '666', '666', '666', '6666', '666', 6, 74, 19, '57ddte', 'upload/portrait/auto_photo.png');
INSERT INTO `xiaojh`.`merchant` (`id`, `name`, `password`, `template`, `status`, `type`, `business`, `purpose`, `address`, `phone`, `connector_name`, `connector_phone`, `connector_qq`, `connector_email`, `liveness`, `popularity`, `user_id`, `merchantName`, `logo_path`) VALUES (10, 'merchant10', 'feea6340d7192d5e5b3095dc7d1b683e', '5', 'PASSED', 'STATE_OWNED', 'ELECTRON', '6', '66', '666', '66', '66666', '666', '66', 6, 24, 20, 'e54', 'upload/portrait/auto_photo.png');

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`user_focus_club`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`user_focus_club` (`user_id`, `club_id`) VALUES (2, 1);
INSERT INTO `xiaojh`.`user_focus_club` (`user_id`, `club_id`) VALUES (2, 2);
INSERT INTO `xiaojh`.`user_focus_club` (`user_id`, `club_id`) VALUES (2, 3);
INSERT INTO `xiaojh`.`user_focus_club` (`user_id`, `club_id`) VALUES (2, 4);

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`club_focus_club`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`club_focus_club` (`source_club_id`, `target_club_id`) VALUES (1, 2);
INSERT INTO `xiaojh`.`club_focus_club` (`source_club_id`, `target_club_id`) VALUES (2, 1);
INSERT INTO `xiaojh`.`club_focus_club` (`source_club_id`, `target_club_id`) VALUES (1, 3);
INSERT INTO `xiaojh`.`club_focus_club` (`source_club_id`, `target_club_id`) VALUES (3, 1);
INSERT INTO `xiaojh`.`club_focus_club` (`source_club_id`, `target_club_id`) VALUES (2, 3);
INSERT INTO `xiaojh`.`club_focus_club` (`source_club_id`, `target_club_id`) VALUES (3, 2);

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`merchant_focus_club`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`merchant_focus_club` (`merchant_id`, `club_id`) VALUES (1, 2);
INSERT INTO `xiaojh`.`merchant_focus_club` (`merchant_id`, `club_id`) VALUES (1, 1);
INSERT INTO `xiaojh`.`merchant_focus_club` (`merchant_id`, `club_id`) VALUES (2, 1);
INSERT INTO `xiaojh`.`merchant_focus_club` (`merchant_id`, `club_id`) VALUES (2, 2);

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`activity` (`id`, `tittle`, `text`, `datetime`, `video_url`, `title_img_path`, `place`, `hold_club_id`, `hold_merchant_id`, `organizer`, `heat`, `budget`, `status`, `talking_id`, `participant_count`) VALUES (1, '商家活动一', '商家活动一商家活动一', '2013-08-05 11:57:11', '<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>', 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', '天津工业大学', 2, 1, '商家1社团2', 44, '200', 'UNDERWAY', 6, 56);
INSERT INTO `xiaojh`.`activity` (`id`, `tittle`, `text`, `datetime`, `video_url`, `title_img_path`, `place`, `hold_club_id`, `hold_merchant_id`, `organizer`, `heat`, `budget`, `status`, `talking_id`, `participant_count`) VALUES (2, '商家活动二', '商家活动二商家活动二商家活动二商家活动二商家活动二', '2013-08-05 11:57:11', '<embed src=\"http://www.tudou.com/l/mvZlZmwpB2Y/&resourceId=0_05_05_99&iid=173717345&bid=05/v.swf\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" wmode=\"opaque\" width=\"480\" height=\"400\"></embed>', 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', '天津', 2, 1, '商家1社团2', 75, '556', 'UNDERWAY', 7, 78);
INSERT INTO `xiaojh`.`activity` (`id`, `tittle`, `text`, `datetime`, `video_url`, `title_img_path`, `place`, `hold_club_id`, `hold_merchant_id`, `organizer`, `heat`, `budget`, `status`, `talking_id`, `participant_count`) VALUES (3, '商家活动三', '商家活动三商家活动三商家活动三商家活动三商家活动三商家活动三', '2013-08-05 11:57:11', '<embed src=\"http://player.youku.com/player.php/sid/XMzIzNDk5MjAw/v.swf\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>', 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', '天津', 2, 1, '商家1社团2', 55, '555', 'UNDERWAY', 8, 67);
INSERT INTO `xiaojh`.`activity` (`id`, `tittle`, `text`, `datetime`, `video_url`, `title_img_path`, `place`, `hold_club_id`, `hold_merchant_id`, `organizer`, `heat`, `budget`, `status`, `talking_id`, `participant_count`) VALUES (4, '商家活动四', '商家活动四商家活动四商家活动四商家活动四商家活动四商家活动四', '2013-08-05 11:57:11', 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', '天津天津', 2, 1, '商家1社团2', 65, '545', 'UNDERWAY', 9, 67);
INSERT INTO `xiaojh`.`activity` (`id`, `tittle`, `text`, `datetime`, `video_url`, `title_img_path`, `place`, `hold_club_id`, `hold_merchant_id`, `organizer`, `heat`, `budget`, `status`, `talking_id`, `participant_count`) VALUES (5, '社团活动1', '社团活动1社团活动1社团活动1社团活动1社团活动1社团活动1', '2013-08-05 11:57:11', '<embed src=\"http://player.youku.com/player.php/sid/XMzIzNDk5MjAw/v.swf\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>', 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', '65767', 1, 2, '社团1商家2', 66, '545', 'UNDERWAY', 10, 67);
INSERT INTO `xiaojh`.`activity` (`id`, `tittle`, `text`, `datetime`, `video_url`, `title_img_path`, `place`, `hold_club_id`, `hold_merchant_id`, `organizer`, `heat`, `budget`, `status`, `talking_id`, `participant_count`) VALUES (6, '社团活动2', '社团活动2社团活动2社团活动2社团活动2', '2013-08-05 11:57:11', '<embed src=\'/xiaojh/video/ckplayer/ckplayer.swf?p=0&c=1&i=/xiaojh/video/ckplayer/xiaojh.png\' flashvars=\'f=/xiaojh/video/ckplayer/mandy.flv\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' allowFullscreen=\'true\' type=\'application/x-shockwave-flash\'></embed>', 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', '4657', 1, 2, '社团1商家2', 777, '545', 'UNDERWAY', 11, 55);
INSERT INTO `xiaojh`.`activity` (`id`, `tittle`, `text`, `datetime`, `video_url`, `title_img_path`, `place`, `hold_club_id`, `hold_merchant_id`, `organizer`, `heat`, `budget`, `status`, `talking_id`, `participant_count`) VALUES (7, '社团活动3', '社团活动3社团活动3社团活动3社团活动3社团活动3', '2013-08-05 11:57:11', '<embed src=\"http://www.tudou.com/l/mvZlZmwpB2Y/&resourceId=0_05_05_99&iid=173717345&bid=05/v.swf\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" wmode=\"opaque\" width=\"480\" height=\"400\"></embed>', 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', 'rgfff', 1, 2, '社团1商家2', 777, '545', 'UNDERWAY', 12, 87);
INSERT INTO `xiaojh`.`activity` (`id`, `tittle`, `text`, `datetime`, `video_url`, `title_img_path`, `place`, `hold_club_id`, `hold_merchant_id`, `organizer`, `heat`, `budget`, `status`, `talking_id`, `participant_count`) VALUES (8, '社团活动4', '社团活动4社团活动4社团活动4社团活动4社团活动4', '2013-08-05 11:57:11', 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', 'http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg', '54646', 1, 2, '社团1商家2', 444, '444', 'UNDERWAY', 13, 54);

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`user_focus_merchant`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`user_focus_merchant` (`user_id`, `merchant_id`) VALUES (2, 1);
INSERT INTO `xiaojh`.`user_focus_merchant` (`user_id`, `merchant_id`) VALUES (2, 2);
INSERT INTO `xiaojh`.`user_focus_merchant` (`user_id`, `merchant_id`) VALUES (3, 1);
INSERT INTO `xiaojh`.`user_focus_merchant` (`user_id`, `merchant_id`) VALUES (3, 2);

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`advertisement`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`advertisement` (`id`, `type`, `name`, `height`, `width`) VALUES (1, 'JS', '活动页广告1', 200, 800);
INSERT INTO `xiaojh`.`advertisement` (`id`, `type`, `name`, `height`, `width`) VALUES (2, 'IMG', '活动页广告2', 100, 230);

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`club_focus_merchant`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`club_focus_merchant` (`club_id`, `merchant_id`) VALUES (1, 2);
INSERT INTO `xiaojh`.`club_focus_merchant` (`club_id`, `merchant_id`) VALUES (1, 1);
INSERT INTO `xiaojh`.`club_focus_merchant` (`club_id`, `merchant_id`) VALUES (2, 1);
INSERT INTO `xiaojh`.`club_focus_merchant` (`club_id`, `merchant_id`) VALUES (2, 2);

COMMIT;

-- -----------------------------------------------------
-- Data for table `xiaojh`.`advertisement_content`
-- -----------------------------------------------------
START TRANSACTION;
USE `xiaojh`;
INSERT INTO `xiaojh`.`advertisement_content` (`id`, `advertisement_id`, `content_path`, `description`, `code`) VALUES (1, 1, '/upload/ads/20130805/153532856.jpg', '活动广告1', 'http://www.baidu.com/');
INSERT INTO `xiaojh`.`advertisement_content` (`id`, `advertisement_id`, `content_path`, `description`, `code`) VALUES (2, 1, '/upload/ads/20130805/153603187.png', '活动广告2', 'http://www.ifeng.com/');
INSERT INTO `xiaojh`.`advertisement_content` (`id`, `advertisement_id`, `content_path`, `description`, `code`) VALUES (3, 1, '/upload/ads/20130805/153630819.jpg', '活动广告3', 'http://www.taobao.com/');
INSERT INTO `xiaojh`.`advertisement_content` (`id`, `advertisement_id`, `content_path`, `description`, `code`) VALUES (4, 2, '/upload/ads/20130805/153826469.jpg', '活动广告', 'http://www.baidu.com/');

COMMIT;
