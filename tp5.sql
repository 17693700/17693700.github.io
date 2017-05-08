-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2017-05-08 09:49:26
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `t_goods_catalog`
--

INSERT INTO `t_goods_catalog` (`cat_id`, `cat_name`, `parent_id`, `path`, `level`) VALUES
(1, '手机数码', 0, '0,1', 1),
(2, '电脑办公', 0, '0,1', 1),
(3, '家用电器', 0, '0,1', 1),
(4, '汽车配件', 0, '0,1', 1),
(5, '化妆个护', 0, '0,1', 1),
(6, '其他商品', 0, '0,1', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
