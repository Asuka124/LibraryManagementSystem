SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `book`
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `B_ID` int(11) NOT NULL,
  `B_TITLE` varchar(45) NOT NULL,
  `B_AUTHOR` varchar(45) NOT NULL,
  `PU_NAME` varchar(45) NOT NULL,
  `B_PUBLISHTIME` date NOT NULL,
  PRIMARY KEY (`B_ID`),
  KEY `PU_NAME` (`PU_NAME`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`PU_NAME`) REFERENCES `publisher` (`PU_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('1', 'title1', 'author1', 'PU_1', '2019-08-01');
INSERT INTO `book` VALUES ('2', 'title2', 'author2', 'PU_2', '2019-06-01');
INSERT INTO `book` VALUES ('3', 'title3', 'author3', 'PU_3', '2019-01-27');
INSERT INTO `book` VALUES ('4', 'title4', 'author4', 'PU_1', '2016-06-06');
INSERT INTO `book` VALUES ('5', 'title5', 'author5', 'PU_1', '2019-06-18');

-- ----------------------------
-- Table structure for `booktype`
-- ----------------------------
DROP TABLE IF EXISTS `booktype`;
CREATE TABLE `booktype` (
  `BT_ID` int(11) NOT NULL,
  `BT_TYPE` varchar(50) NOT NULL,
  `B_ID` int(11) NOT NULL,
  PRIMARY KEY (`BT_ID`),
  KEY `B_ID` (`B_ID`),
  CONSTRAINT `booktype_ibfk_1` FOREIGN KEY (`B_ID`) REFERENCES `book` (`B_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of booktype
-- ----------------------------
INSERT INTO `booktype` VALUES ('1', 'Religion', '1');
INSERT INTO `booktype` VALUES ('2', 'Philosophy', '1');
INSERT INTO `booktype` VALUES ('3', 'Law', '2');
INSERT INTO `booktype` VALUES ('4', 'Politics', '3');
INSERT INTO `booktype` VALUES ('5', 'Economy', '4');
INSERT INTO `booktype` VALUES ('6', 'Science', '5');

-- ----------------------------
-- Table structure for `borrow`
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow` (
  `BO_ID` int(11) NOT NULL,
  `BO_BORROWTIME` datetime DEFAULT NULL,
  `BO_RETURNTIME` datetime NOT NULL,
  `SB_ID` int(11) NOT NULL,
  `U_USERNAME` varchar(15) NOT NULL,
  PRIMARY KEY (`BO_ID`),
  KEY `SB_ID` (`SB_ID`),
  KEY `U_USERNAME` (`U_USERNAME`),
  CONSTRAINT `borrow_ibfk_1` FOREIGN KEY (`SB_ID`) REFERENCES `sbook` (`SB_ID`),
  CONSTRAINT `borrow_ibfk_2` FOREIGN KEY (`U_USERNAME`) REFERENCES `user` (`U_USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES ('1', '2019-10-21 20:18:38', '2019-12-22 20:18:38', '1', 'User1');
INSERT INTO `borrow` VALUES ('2', '2019-11-21 20:18:38', '2019-12-22 20:18:38', '4', 'User1');
INSERT INTO `borrow` VALUES ('3', '2019-12-20 20:20:00', '2019-12-21 20:20:00', '5', 'User2');
INSERT INTO `borrow` VALUES ('4', '2019-12-23 20:20:34', '2019-12-24 20:20:34', '6', 'User3');
INSERT INTO `borrow` VALUES ('5', '2019-10-01 20:28:47', '2019-11-12 20:28:47', '7', 'User1');
INSERT INTO `borrow` VALUES ('6', '2019-10-29 20:30:04', '2019-12-26 20:30:04', '3', 'User1');

-- ----------------------------
-- Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `C_ID` int(11) NOT NULL,
  `C_SCORE` decimal(2,1) NOT NULL,
  `C_TEXT` varchar(1000) DEFAULT NULL,
  `C_TIME` datetime NOT NULL,
  `U_USERNAME` varchar(15) NOT NULL,
  `B_ID` int(11) NOT NULL,
  PRIMARY KEY (`C_ID`),
  KEY `U_USERNAME` (`U_USERNAME`),
  KEY `B_ID` (`B_ID`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`U_USERNAME`) REFERENCES `user` (`U_USERNAME`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`B_ID`) REFERENCES `book` (`B_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', '4.3', 'not bad', '2019-12-27 20:22:08', 'User1', '1');
INSERT INTO `comment` VALUES ('2', '4.9', 'good', '2019-12-27 20:23:01', 'User1', '4');
INSERT INTO `comment` VALUES ('3', '5.0', 'very good', '2019-12-26 12:25:03', 'User2', '5');

-- ----------------------------
-- Table structure for `permission`
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `P_ID` int(11) NOT NULL,
  `P_MAX_TIME` int(11) NOT NULL,
  `P_MAX_NUMBER` int(11) NOT NULL,
  PRIMARY KEY (`P_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '15', '5');
INSERT INTO `permission` VALUES ('2', '30', '10');
INSERT INTO `permission` VALUES ('3', '45', '15');

-- ----------------------------
-- Table structure for `publisher`
-- ----------------------------
DROP TABLE IF EXISTS `publisher`;
CREATE TABLE `publisher` (
  `PU_NAME` varchar(45) NOT NULL,
  `PU_ADDRESS` varchar(200) DEFAULT NULL,
  `PU_PHONE` varchar(20) NOT NULL,
  PRIMARY KEY (`PU_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of publisher
-- ----------------------------
INSERT INTO `publisher` VALUES ('PU_1', 'address1', 'phone1');
INSERT INTO `publisher` VALUES ('PU_2', 'address2', 'phone2');
INSERT INTO `publisher` VALUES ('PU_3', 'address3', 'phone3');

-- ----------------------------
-- Table structure for `sbook`
-- ----------------------------
DROP TABLE IF EXISTS `sbook`;
CREATE TABLE `sbook` (
  `SB_ID` int(11) NOT NULL,
  `B_ID` int(11) NOT NULL,
  `SB_LOCATION` varchar(100) NOT NULL,
  `SB_STATUS` varchar(14) DEFAULT '' COMMENT 'Borrowable;Not Borrowable;Borrowed',
  PRIMARY KEY (`SB_ID`),
  KEY `B_ID` (`B_ID`),
  CONSTRAINT `sbook_ibfk_1` FOREIGN KEY (`B_ID`) REFERENCES `book` (`B_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbook
-- ----------------------------
INSERT INTO `sbook` VALUES ('1', '1', 'locationx', 'Borrowable');
INSERT INTO `sbook` VALUES ('2', '1', 'locationx', 'Borrowable');
INSERT INTO `sbook` VALUES ('3', '1', 'locationx', 'Borrowed');
INSERT INTO `sbook` VALUES ('4', '2', 'locationx', 'Borrowable');
INSERT INTO `sbook` VALUES ('5', '3', 'locationx', 'Borrowable');
INSERT INTO `sbook` VALUES ('6', '4', 'locationx', 'Borrowable');
INSERT INTO `sbook` VALUES ('7', '5', 'locationx', 'Not Borrowable');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `U_USERNAME` varchar(15) NOT NULL,
  `U_REALNAME` varchar(45) NOT NULL,
  `U_IDNUMBER` varchar(20) DEFAULT NULL,
  `U_GENDER` varchar(6) DEFAULT NULL,
  `P_ID` int(11) NOT NULL,
  PRIMARY KEY (`U_USERNAME`),
  KEY `P_ID` (`P_ID`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`P_ID`) REFERENCES `permission` (`P_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('User1', 'James', '100000001', 'Male', '1');
INSERT INTO `user` VALUES ('User2', 'Ross', '100000002', 'Female', '2');
INSERT INTO `user` VALUES ('User3', 'Kevin', '100000003', 'Male', '3');

-- ----------------------------
-- View structure for `v_not_return`
-- ----------------------------
DROP VIEW IF EXISTS `v_not_return`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_not_return` AS select `bo`.`BO_BORROWTIME` AS `BO_BORROWTIME`,`bo`.`BO_RETURNTIME` AS `BO_RETURNTIME`,`u`.`U_USERNAME` AS `U_USERNAME`,`b`.`B_TITLE` AS `B_TITLE`,((to_days(`bo`.`BO_RETURNTIME`) - to_days(`bo`.`BO_BORROWTIME`)) - `p`.`P_MAX_NUMBER`) AS `delay` from ((((`borrow` `bo` join `sbook` `sb`) join `book` `b`) join `user` `u`) join `permission` `p`) where ((`bo`.`U_USERNAME` = `u`.`U_USERNAME`) and (`bo`.`SB_ID` = `sb`.`SB_ID`) and (`sb`.`B_ID` = `b`.`B_ID`) and (`u`.`P_ID` = `p`.`P_ID`) and ((to_days(`bo`.`BO_RETURNTIME`) - to_days(`bo`.`BO_BORROWTIME`)) > `p`.`P_MAX_NUMBER`)) ;
