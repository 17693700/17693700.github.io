-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2017-05-14 14:44:41
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
  `thumbnail` varchar(222) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `popularity` int(11) NOT NULL DEFAULT '0',
  `sales` int(11) NOT NULL DEFAULT '0',
  `addtime` date NOT NULL,
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `t_goods_thread`
--

INSERT INTO `t_goods_thread` (`goods_id`, `cat_id`, `order_id`, `goods_name`, `summary`, `price`, `service`, `thumbnail`, `content`, `popularity`, `sales`, `addtime`) VALUES
(2, 7, 1, '苹果（Apple）iPhone 6s 64G版', '4.7英寸显示屏，突破性的设计， 又有新突破！', 5399, '满99元包邮 | 正品保证', '', '', 0, 0, '2017-05-14'),
(3, 7, 3, 'Ipad', '这是摘要', 4444, '保修一年', '', '<p>这是详情</p>', 0, 0, '2017-05-14'),
(4, 7, 1, '苹果（Apple）iPhone 7 128G版 4G手机', '4.7英寸显示屏，突破性的设计， 又有新突破！（颜色随机发）', 6199, '满99元包邮 | 正品保证', '', '<p>1</p>', 0, 0, '2017-05-14');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
