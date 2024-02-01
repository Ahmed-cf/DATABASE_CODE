-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 29, 2024 at 09:10 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medical tourism`
--

-- --------------------------------------------------------

--
-- Table structure for table `area`
--

CREATE TABLE `area` (
  `id` int(8) NOT NULL,
  `area_name` varchar(32) NOT NULL,
  `information` text NOT NULL,
  `current_care` tinytext NOT NULL,
  `city_id` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- RELATIONSHIPS FOR TABLE `area`:
--   `city_id`
--       `city` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `id` int(8) NOT NULL,
  `city_name` varchar(20) NOT NULL,
  `location` varchar(32) NOT NULL,
  `count_area` int(16) NOT NULL,
  `information` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- RELATIONSHIPS FOR TABLE `city`:
--

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `id` int(8) NOT NULL,
  `h_name` varchar(20) NOT NULL,
  `h_information` text NOT NULL,
  `h_url` varchar(52) NOT NULL,
  `area_id` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- RELATIONSHIPS FOR TABLE `hotels`:
--   `area_id`
--       `area` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `ho_phone`
--

CREATE TABLE `ho_phone` (
  `id` int(8) NOT NULL,
  `phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- RELATIONSHIPS FOR TABLE `ho_phone`:
--   `id`
--       `hotels` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `id` int(10) NOT NULL,
  `offer_name` varchar(32) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `offer_period` varchar(16) NOT NULL,
  `offer_cost` decimal(8,0) NOT NULL,
  `information` text NOT NULL,
  `resorts_id` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- RELATIONSHIPS FOR TABLE `offers`:
--   `resorts_id`
--       `resorts` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(16) NOT NULL,
  `user_id` int(16) NOT NULL,
  `offer_id` int(16) NOT NULL,
  `reserve_statue` varchar(16) NOT NULL,
  `leaving_date` date NOT NULL,
  `arrive_date` date NOT NULL,
  `passport_num` varchar(12) NOT NULL,
  `unit_type` varchar(16) NOT NULL,
  `payment_statues` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- RELATIONSHIPS FOR TABLE `reservations`:
--   `user_id`
--       `user` -> `id`
--   `offer_id`
--       `offers` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `resorts`
--

CREATE TABLE `resorts` (
  `id` int(10) NOT NULL,
  `r_name` varchar(20) NOT NULL,
  `location` varchar(20) NOT NULL,
  `area_id` int(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- RELATIONSHIPS FOR TABLE `resorts`:
--   `id`
--       `ho_phone` -> `id`
--   `area_id`
--       `area` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `re_phone`
--

CREATE TABLE `re_phone` (
  `id` int(10) NOT NULL,
  `phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- RELATIONSHIPS FOR TABLE `re_phone`:
--   `id`
--       `reservations` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `user_name` varchar(32) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(52) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- RELATIONSHIPS FOR TABLE `user`:
--

--
-- Indexes for dumped tables
--

--
-- Indexes for table `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_id` (`city_id`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `area_id` (`area_id`);

--
-- Indexes for table `ho_phone`
--
ALTER TABLE `ho_phone`
  ADD PRIMARY KEY (`id`,`phone`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `resorts_id` (`resorts_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `offer_id` (`offer_id`);

--
-- Indexes for table `resorts`
--
ALTER TABLE `resorts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `area_id` (`area_id`);

--
-- Indexes for table `re_phone`
--
ALTER TABLE `re_phone`
  ADD PRIMARY KEY (`phone`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `area`
--
ALTER TABLE `area`
  ADD CONSTRAINT `area_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`);

--
-- Constraints for table `hotels`
--
ALTER TABLE `hotels`
  ADD CONSTRAINT `hotels_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`);

--
-- Constraints for table `ho_phone`
--
ALTER TABLE `ho_phone`
  ADD CONSTRAINT `ho_phone_ibfk_1` FOREIGN KEY (`id`) REFERENCES `hotels` (`id`);

--
-- Constraints for table `offers`
--
ALTER TABLE `offers`
  ADD CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`resorts_id`) REFERENCES `resorts` (`id`);

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`);

--
-- Constraints for table `resorts`
--
ALTER TABLE `resorts`
  ADD CONSTRAINT `resorts_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`);

--
-- Constraints for table `re_phone`
--
ALTER TABLE `re_phone`
  ADD CONSTRAINT `re_phone_ibfk_1` FOREIGN KEY (`id`) REFERENCES `reservations` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
