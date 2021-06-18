-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 18, 2021 at 03:45 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `marshell`
--

-- --------------------------------------------------------

--
-- Table structure for table `entities_details`
--

CREATE TABLE `entities_details` (
  `entity_id` int(11) NOT NULL,
  `entity_type` enum('Individual Account','LLC Account','Corporation Account','Retirement Account') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `lender_details`
--

CREATE TABLE `lender_details` (
  `lender_id` int(11) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `phone_number` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `lender_entities`
--

CREATE TABLE `lender_entities` (
  `id` int(11) NOT NULL,
  `lender_id` varchar(150) NOT NULL,
  `entity_id` varchar(150) NOT NULL,
  `w9_document_code` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `loan_details`
--

CREATE TABLE `loan_details` (
  `loan_id` int(11) NOT NULL,
  `loan_amount` decimal(10,0) NOT NULL,
  `interest_rate` decimal(10,0) NOT NULL,
  `loan_status` enum('Draft','Available','Funded','Complete') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `loan_transactions`
--

CREATE TABLE `loan_transactions` (
  `transaction_id` int(11) NOT NULL,
  `transaction_type` enum('Origination','Sales','','') NOT NULL DEFAULT 'Origination',
  `loan_id` varchar(150) NOT NULL,
  `old_lender_id` varchar(150) NOT NULL,
  `new_lender_id` varchar(150) NOT NULL,
  `disclaimer_code` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `entities_details`
--
ALTER TABLE `entities_details`
  ADD PRIMARY KEY (`entity_id`);

--
-- Indexes for table `lender_details`
--
ALTER TABLE `lender_details`
  ADD PRIMARY KEY (`lender_id`);

--
-- Indexes for table `lender_entities`
--
ALTER TABLE `lender_entities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_details`
--
ALTER TABLE `loan_details`
  ADD PRIMARY KEY (`loan_id`);

--
-- Indexes for table `loan_transactions`
--
ALTER TABLE `loan_transactions`
  ADD PRIMARY KEY (`transaction_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `entities_details`
--
ALTER TABLE `entities_details`
  MODIFY `entity_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lender_details`
--
ALTER TABLE `lender_details`
  MODIFY `lender_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lender_entities`
--
ALTER TABLE `lender_entities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loan_details`
--
ALTER TABLE `loan_details`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_transactions`
--
ALTER TABLE `loan_transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
