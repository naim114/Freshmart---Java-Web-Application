-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 01, 2024 at 03:50 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `freshmart`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `price` double NOT NULL,
  `description` varchar(100) DEFAULT 'Item description',
  `img_url` varchar(999) NOT NULL DEFAULT 'https://via.placeholder.com/700x400'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_id`, `item_name`, `price`, `description`, `img_url`) VALUES
(11, 'Milk', 2.49, 'Fresh and nutritious milk', 'https://mygroser.s3.ap-southeast-1.amazonaws.com/productImages/1000X1000/1624671930788-DUTCH%20LADY%205X%20DHA%201-3Tahun%20biasa%20WM.png'),
(12, 'Bread', 1.99, 'Freshly baked bread', 'https://www.luluhypermarket.com/cdn-cgi/image/f=auto/medias/388461-01.jpg-1200Wx1200H?context=bWFzdGVyfGltYWdlc3wyMTQ2NDJ8aW1hZ2UvanBlZ3xhRE5qTDJoak15ODVPVEE0T1RFd09UZ3hNVFV3THpNNE9EUTJNUzB3TVM1cWNHZGZNVEl3TUZkNE1USXdNRWd8MzlhYThkOGZkODgxODQ0NjM3ZDRiMDk5MzU1MTA4Y2Y1MWQyNmMzZmZjMGY3Nzk5ZGRmMTJiZWZhMTRkMzFhMQ'),
(13, 'Eggs', 1.89, 'Organic and farm-fresh eggs', 'https://via.placeholder.com/700x400'),
(14, 'Bananas', 0.49, 'Ripe and healthy bananas', 'https://via.placeholder.com/700x400'),
(15, 'Chicken', 5.99, 'Premium quality chicken', 'https://via.placeholder.com/700x400'),
(16, 'Rice', 2.79, 'High-quality rice grains', 'https://via.placeholder.com/700x400'),
(17, 'Tomatoes', 1.29, 'Vine-ripened red tomatoes', 'https://via.placeholder.com/700x400'),
(18, 'Cheese', 3.99, 'Imported cheese for gourmet taste', 'https://via.placeholder.com/700x400'),
(19, 'Apples', 0.79, 'Crisp and juicy apples', 'https://mygroser.s3.ap-southeast-1.amazonaws.com/productImages/300X300/1654924699926-336517-0001-800x800.png'),
(20, 'Orange Juice', 2.99, '100% pure orange juice', 'https://via.placeholder.com/700x400'),
(23, 'ytui', 66, 'ytuio', 'https://source.unsplash.com/600x400/?trex');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `purchase_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `item_name` varchar(100) NOT NULL,
  `price` double NOT NULL,
  `img_url` varchar(999) NOT NULL DEFAULT 'https://via.placeholder.com/700x400',
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`purchase_id`, `user_id`, `rating`, `comment`, `created_at`, `item_name`, `price`, `img_url`, `quantity`) VALUES
(6, 1, 5, 'mmmmm', '2024-02-01 21:56:08', 'Milk', 2.49, 'https://mygroser.s3.ap-southeast-1.amazonaws.com/productImages/1000X1000/1624671930788-DUTCH%20LADY%205X%20DHA%201-3Tahun%20biasa%20WM.png', 2),
(7, 1, NULL, NULL, '2024-02-01 21:56:11', 'Apples', 0.79, 'https://mygroser.s3.ap-southeast-1.amazonaws.com/productImages/300X300/1654924699926-336517-0001-800x800.png', 5);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `tel_no` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `is_admin` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `email`, `user_name`, `password`, `tel_no`, `address`, `is_admin`) VALUES
(1, 'admin@email.com', 'admin', 'admin', '013456789', '505, Taman ABC, KL', 1),
(2, 'faiz@unikl.com', 'faiz', 'abc', '013456789', '505', 0),
(3, 'sbob@bikini.bottom', 'Spongebob Squarepants', 'abc', '013456789', 'Little St. James', 0),
(4, 'phoebe@boygenius.com', 'Phoebe Bridgers', 'abc', '013456789', 'Seattle', 0),
(6, 'julien@boygenius.com', 'Julien Baker', 'admin', '013456789', 'Seattle', 0),
(7, 'lucy@boygenius.com', 'Lucy Dacus', 'admin', '013456789', 'Seattle', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`purchase_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `UNIQUE_EMAIL` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
