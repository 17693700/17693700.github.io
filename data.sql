-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2017-06-04 10:58:52
-- 服务器版本： 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tp5`
--
CREATE DATABASE IF NOT EXISTS `tp5` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `tp5`;

-- --------------------------------------------------------

--
-- 表的结构 `admin_user`
--

CREATE TABLE IF NOT EXISTS `admin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(55) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `admin_user`
--

INSERT INTO `admin_user` (`id`, `admin_name`, `password`) VALUES
(10, 'boss', 123),
(11, 'jian', 123);

-- --------------------------------------------------------

--
-- 表的结构 `auth_group`
--

CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` char(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `auth_group`
--

INSERT INTO `auth_group` (`id`, `title`, `status`, `rules`) VALUES
(1, '最高管理员', 1, '11,10,7'),
(2, '普通管理员', 1, '11,10,7'),
(3, '最低管理员', 1, '10');

-- --------------------------------------------------------

--
-- 表的结构 `auth_group_access`
--

CREATE TABLE IF NOT EXISTS `auth_group_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `auth_group_access`
--

INSERT INTO `auth_group_access` (`id`, `uid`, `group_id`) VALUES
(5, 10, 1),
(6, 11, 3);

-- --------------------------------------------------------

--
-- 表的结构 `auth_rule`
--

CREATE TABLE IF NOT EXISTS `auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(20) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `auth_rule`
--

INSERT INTO `auth_rule` (`id`, `name`, `title`, `type`, `status`, `condition`) VALUES
(11, 'index/product/goods_edit', '商品修改', 1, 1, ''),
(10, 'index/product/goods_add', '商品添加', 1, 1, ''),
(12, 'index/product/goods_del', '商品删除', 1, 1, ''),
(7, 'index/product/product_category_add', '分类添加', 1, 1, '');

-- --------------------------------------------------------

--
-- 表的结构 `t_goods_catalog`
--

CREATE TABLE IF NOT EXISTS `t_goods_catalog` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(55) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int(11) NOT NULL,
  `path` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int(2) NOT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=15 ;

--
-- 转存表中的数据 `t_goods_catalog`
--

INSERT INTO `t_goods_catalog` (`cat_id`, `cat_name`, `parent_id`, `path`, `level`) VALUES
(1, '手机数码', 0, '0,1', 1),
(2, '电脑办公', 0, '0,1', 1),
(3, '家用电器', 0, '0,1', 1),
(4, '汽车配件', 0, '0,1', 1),
(5, '化妆个护', 0, '0,1', 1),
(7, '苹果', 1, '', 2),
(8, '小米', 1, '', 2),
(9, '主机', 2, '', 2),
(14, 'iphone7', 7, '', 3);

-- --------------------------------------------------------

--
-- 表的结构 `t_goods_thread`
--

CREATE TABLE IF NOT EXISTS `t_goods_thread` (
  `goods_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `goods_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL DEFAULT '0',
  `service` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(222) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `popularity` int(11) NOT NULL DEFAULT '0',
  `sales` int(11) NOT NULL DEFAULT '0',
  `addtime` date NOT NULL,
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=35 ;

--
-- 转存表中的数据 `t_goods_thread`
--

INSERT INTO `t_goods_thread` (`goods_id`, `cat_id`, `order_id`, `goods_name`, `summary`, `price`, `service`, `image`, `content`, `popularity`, `sales`, `addtime`) VALUES
(2, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(3, 7, 3, 'Ipad2', '这是摘要', 4444, '保修一年', '20170521\\0669f87e99f8b15bf472e252ad642d0d.jpg', '<p>1223</p>', 0, 0, '2017-05-21'),
(4, 7, 1, '苹果（Apple）iPhone 7 128G版 4G手机', '4.7英寸显示屏，突破性的设计， 又有新突破！（颜色随机发）', 6199, '满99元包邮 | 正品保证', '20170521\\d1f77fb2602e7da6293176e3a13df491.png', '<p>1</p>', 0, 0, '2017-05-21'),
(5, 8, 0, '红米note3', '', 1000, '', '20170520\\043a76ea546e0c4365f10ad480918e19.jpg', '<p>111</p>', 0, 0, '2017-05-20'),
(6, 8, 0, '小米6', '', 2555, '', '20170520\\c135f19ca22f844c951bbc60ffd96dc4.jpg', '<p>这是小米6</p>', 0, 0, '2017-05-20'),
(7, 8, 0, '小米4', '', 0, '', '20170521\\46a297f3d1c22179b45ddb2e163a5a36.jpg', '<p>2</p>', 0, 0, '2017-05-21'),
(8, 2, 0, '高斯87', '', 339, '', '20170601\\83880503f527206a46cfdc7fa3ecbd94.jpg', '<p>87</p>', 0, 0, '2017-06-01'),
(9, 3, 0, '吸尘器', '', 555, '', '20170601\\cfa04b367130dd4c6161d886fb668c75.jpg', '<p>76</p>', 0, 0, '2017-06-01'),
(10, 2, 0, '笔记本电脑', '', 9999, '', '20170601\\437478b5be19bc1503f04c7a06c72bff.jpg', '<p>电脑</p>', 0, 0, '2017-06-01'),
(11, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5390, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(12, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(13, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(14, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(15, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5222, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(16, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5555, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(17, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 3333, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(18, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 6666, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(19, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(20, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(21, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(22, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(23, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(24, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(25, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(26, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(27, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(28, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(29, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(30, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(31, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(32, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '20170520\\fd74115cf5009025fda14b321962e9e8.jpg', '<p>1</p>', 0, 0, '2017-05-20'),
(33, 4, 0, '方向盘', '', 6666, '', '20170602\\807e02e174ef2e6bf8602ef1b82c236d.png', '<p>芳香胺</p>', 0, 0, '2017-06-02'),
(34, 5, 0, '洗面奶', '', 66, '', '20170602\\c35d0246fa0775c902eb3127f44dbb16.jpg', '<p>洗面奶一瓶</p>', 0, 0, '2017-06-02');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
