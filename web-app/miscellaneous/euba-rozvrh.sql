/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50525
 Source Host           : localhost
 Source Database       : euba-rozvrh

 Target Server Type    : MySQL
 Target Server Version : 50525
 File Encoding         : utf-8

 Date: 03/19/2014 15:32:03 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `den`
-- ----------------------------
DROP TABLE IF EXISTS `den`;
CREATE TABLE `den` (
  `id_den` int(11) NOT NULL,
  `den` varchar(10) NOT NULL,
  PRIMARY KEY (`id_den`),
  UNIQUE KEY `UQ_Den_id_den` (`id_den`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `fakulta`
-- ----------------------------
DROP TABLE IF EXISTS `fakulta`;
CREATE TABLE `fakulta` (
  `id_fakulta` int(11) NOT NULL AUTO_INCREMENT,
  `kod` varchar(10) NOT NULL,
  `nazov` varchar(250) NOT NULL,
  PRIMARY KEY (`id_fakulta`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `hodina`
-- ----------------------------
DROP TABLE IF EXISTS `hodina`;
CREATE TABLE `hodina` (
  `id_hodina` int(11) NOT NULL AUTO_INCREMENT,
  `cislo` int(11) NOT NULL,
  `cas_od` time NOT NULL,
  `cas_do` time NOT NULL,
  PRIMARY KEY (`id_hodina`),
  UNIQUE KEY `UQ_Hodina_id_hodina` (`id_hodina`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `katedra`
-- ----------------------------
DROP TABLE IF EXISTS `katedra`;
CREATE TABLE `katedra` (
  `id_katedra` int(11) NOT NULL AUTO_INCREMENT,
  `id_fakulta` int(11) NOT NULL,
  `kod` varchar(20) NOT NULL,
  `nazov` varchar(250) NOT NULL,
  PRIMARY KEY (`id_katedra`),
  UNIQUE KEY `UQ_Katedra_id_katedra` (`id_katedra`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `kruzok`
-- ----------------------------
DROP TABLE IF EXISTS `kruzok`;
CREATE TABLE `kruzok` (
  `id_kruzok` int(11) NOT NULL AUTO_INCREMENT,
  `kod` varchar(10) NOT NULL,
  `cislo` int(2) NOT NULL,
  `nazov` varchar(250) NOT NULL,
  `id_odbor` int(11) NOT NULL,
  PRIMARY KEY (`id_kruzok`),
  UNIQUE KEY `UQ_kruzok_id_kruzok` (`id_kruzok`)
) ENGINE=InnoDB AUTO_INCREMENT=374 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `miestnost`
-- ----------------------------
DROP TABLE IF EXISTS `miestnost`;
CREATE TABLE `miestnost` (
  `id_miestnost` int(11) NOT NULL AUTO_INCREMENT,
  `kod` varchar(10) NOT NULL,
  `nazov` varchar(250) NOT NULL,
  `kapacita` int(3) DEFAULT NULL,
  PRIMARY KEY (`id_miestnost`),
  UNIQUE KEY `UQ_Miestnost_id_miestnost` (`id_miestnost`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `odbor`
-- ----------------------------
DROP TABLE IF EXISTS `odbor`;
CREATE TABLE `odbor` (
  `id_odbor` int(11) NOT NULL AUTO_INCREMENT,
  `kod` varchar(10) NOT NULL,
  `nazov` varchar(250) NOT NULL,
  `pocet_studentov` int(3) DEFAULT NULL,
  `id_fakulta` int(11) NOT NULL,
  `rocnik` int(1) NOT NULL,
  PRIMARY KEY (`id_odbor`),
  UNIQUE KEY `UQ_Odbor_id_odbor` (`id_odbor`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `predmet`
-- ----------------------------
DROP TABLE IF EXISTS `predmet`;
CREATE TABLE `predmet` (
  `id_predmet` int(11) NOT NULL AUTO_INCREMENT,
  `kod` varchar(10) NOT NULL,
  `nazov` varchar(250) NOT NULL,
  `skratka` varchar(5) DEFAULT NULL,
  `vymera` varchar(3) DEFAULT NULL,
  `prednaska` char(1) NOT NULL,
  `povinny` int(1) DEFAULT NULL,
  `semester` int(11) NOT NULL,
  PRIMARY KEY (`id_predmet`),
  UNIQUE KEY `UQ_predmet_id_predmet` (`id_predmet`)
) ENGINE=InnoDB AUTO_INCREMENT=684 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `pripomienka`
-- ----------------------------
DROP TABLE IF EXISTS `pripomienka`;
CREATE TABLE `pripomienka` (
  `id_pripomienka` int(11) NOT NULL,
  `id_vyuka` int(11) NOT NULL,
  `odoslana` char(1) DEFAULT NULL,
  `rozpracovana` char(1) DEFAULT NULL,
  `potvrdena` char(1) DEFAULT NULL,
  `pripomienka` text NOT NULL,
  PRIMARY KEY (`id_pripomienka`),
  UNIQUE KEY `UQ_Pripomienka_id_pripomienka` (`id_pripomienka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rola`
-- ----------------------------
DROP TABLE IF EXISTS `rola`;
CREATE TABLE `rola` (
  `id_rola` int(11) NOT NULL,
  `kod` varchar(10) NOT NULL,
  `nazov` varchar(100) NOT NULL,
  PRIMARY KEY (`id_rola`),
  UNIQUE KEY `UQ_Rola_id_rola` (`id_rola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rolaprac`
-- ----------------------------
DROP TABLE IF EXISTS `rolaprac`;
CREATE TABLE `rolaprac` (
  `id_rola` int(11) NOT NULL,
  `id_ucitel` int(11) NOT NULL,
  KEY `id_rola` (`id_rola`),
  KEY `id_ucitel` (`id_ucitel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rozvrh`
-- ----------------------------
DROP TABLE IF EXISTS `rozvrh`;
CREATE TABLE `rozvrh` (
  `id_rozvrh` int(11) NOT NULL,
  `skratka` varchar(30) NOT NULL,
  `nazov` varchar(100) NOT NULL,
  PRIMARY KEY (`id_rozvrh`),
  UNIQUE KEY `UQ_Rozvrh_id_rozvrh` (`id_rozvrh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ucitel`
-- ----------------------------
DROP TABLE IF EXISTS `ucitel`;
CREATE TABLE `ucitel` (
  `id_ucitel` int(11) NOT NULL AUTO_INCREMENT,
  `id_katedra` int(11) NOT NULL,
  `kod` varchar(99) NOT NULL,
  `priezvisko` varchar(50) NOT NULL,
  `meno` varchar(50) NOT NULL,
  `titul` varchar(20) DEFAULT NULL,
  `titul_za` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_ucitel`),
  UNIQUE KEY `UQ_Ucitel_id_ucitel` (`id_ucitel`)
) ENGINE=InnoDB AUTO_INCREMENT=682 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `role` tinyint(4) DEFAULT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `blocked` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `vyucujuci`
-- ----------------------------
DROP TABLE IF EXISTS `vyucujuci`;
CREATE TABLE `vyucujuci` (
  `id_predmet` int(11) NOT NULL,
  `id_ucitel` int(11) NOT NULL,
  KEY `id_predmet` (`id_predmet`),
  KEY `id_ucitel` (`id_ucitel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `vyuka`
-- ----------------------------
DROP TABLE IF EXISTS `vyuka`;
CREATE TABLE `vyuka` (
  `id_vyuka` int(11) NOT NULL AUTO_INCREMENT,
  `id_kruzok` int(11) NOT NULL,
  `id_den` int(11) NOT NULL,
  `id_hodina` int(11) NOT NULL,
  `id_predmet` int(11) NOT NULL,
  `prednaska` int(1) NOT NULL,
  `id_miestnost` int(11) NOT NULL,
  `id_ucitel` int(11) NOT NULL,
  `polrok` varchar(50) DEFAULT NULL,
  `id_rozvrh` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_vyuka`),
  UNIQUE KEY `UQ_vyuka_id_vyuka` (`id_vyuka`)
) ENGINE=InnoDB AUTO_INCREMENT=3349 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
