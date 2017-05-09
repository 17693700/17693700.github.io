/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : tp5

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2017-05-09 18:18:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_goods_catalog
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_catalog`;
CREATE TABLE `t_goods_catalog` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(55) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int(11) NOT NULL,
  `path` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int(2) NOT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of t_goods_catalog
-- ----------------------------
INSERT INTO `t_goods_catalog` VALUES ('1', '手机数码', '0', '0,1', '1');
INSERT INTO `t_goods_catalog` VALUES ('2', '电脑办公', '0', '0,1', '1');
INSERT INTO `t_goods_catalog` VALUES ('3', '家用电器', '0', '0,1', '1');
INSERT INTO `t_goods_catalog` VALUES ('4', '汽车配件', '0', '0,1', '1');
INSERT INTO `t_goods_catalog` VALUES ('5', '化妆个护', '0', '0,1', '1');
INSERT INTO `t_goods_catalog` VALUES ('6', '其他商品', '0', '0,1', '1');
INSERT INTO `t_goods_catalog` VALUES ('7', '苹果', '1', '', '2');
INSERT INTO `t_goods_catalog` VALUES ('8', '小米', '1', '', '2');
INSERT INTO `t_goods_catalog` VALUES ('9', '主机', '2', '', '2');
INSERT INTO `t_goods_catalog` VALUES ('10', '显示器', '2', '', '2');
INSERT INTO `t_goods_catalog` VALUES ('11', '鼠标', '2', '', '2');
INSERT INTO `t_goods_catalog` VALUES ('12', '键盘', '2', '', '2');
INSERT INTO `t_goods_catalog` VALUES ('14', 'iphone7', '7', '', '3');
INSERT INTO `t_goods_catalog` VALUES ('15', 'iphone6s', '7', '', '3');
