/*
 Navicat Premium Data Transfer

 Source Server         : DEV PROTONEMA
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : 103.148.233.151:13306
 Source Schema         : api_template

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 04/09/2024 14:27:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbAuth
-- ----------------------------
DROP TABLE IF EXISTS `tbAuth`;
CREATE TABLE `tbAuth` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `userUid` varchar(255) NOT NULL,
  `status` enum('login','logout') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `expiredAt` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_token` (`userUid`),
  CONSTRAINT `user_token` FOREIGN KEY (`userUid`) REFERENCES `tbUsers` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for tbUsers
-- ----------------------------
DROP TABLE IF EXISTS `tbUsers`;
CREATE TABLE `tbUsers` (
  `uid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Event structure for checkExpiredTokens
-- ----------------------------
DROP EVENT IF EXISTS `checkExpiredTokens`;
delimiter ;;
CREATE EVENT `checkExpiredTokens`
ON SCHEDULE
EVERY '1' SECOND STARTS '2024-08-31 14:42:03'
DO BEGIN
  UPDATE tbAuth
  SET status = 'logout'
  WHERE expiredAt < NOW();
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
