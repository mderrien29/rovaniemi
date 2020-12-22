-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Dec 17, 2019 at 01:43 PM
-- Server version: 10.4.11-MariaDB-1:10.4.11+maria~bionic
-- PHP Version: 7.2.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rovaniemi`
--

-- --------------------------------------------------------

--
-- Table structure for table `BATTLE`
--

CREATE TABLE `BATTLE` (
  `id` int(11) NOT NULL,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `BATTLE`
--

INSERT INTO `BATTLE` (`id`, `name`) VALUES
(1, 'Noël 2019');

-- --------------------------------------------------------

--
-- Table structure for table `CATEGORY`
--

CREATE TABLE `CATEGORY` (
  `id` int(11) NOT NULL,
  `battleId` int(11) NOT NULL,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CATEGORY`
--

INSERT INTO `CATEGORY` (`id`, `battleId`, `name`) VALUES
(1, 1, 'La musique pour faire le ménage'),
(2, 1, 'La musique parfaite pour conduire'),
(3, 1, 'La reprise la plus nulle (pour une bonne chanson)'),
(4, 1, 'La musique la plus triste'),
(5, 1, 'Le coup de coeur de l\'année');

-- --------------------------------------------------------

--
-- Table structure for table `SONG`
--

CREATE TABLE `SONG` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER`
--

CREATE TABLE `USER` (
  `id` int(11) NOT NULL,
  `admin` tinyint(1) NOT NULL,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `password_hash` char(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER`
--

INSERT INTO `USER` (`id`, `admin`, `name`, `password_hash`) VALUES
(1, 1, 'Admin', '09a5eddc221468a7fe0af1b1bf33056f67cfb7887ff0898d5f05daadba74b67e8e1c469cef54f48f5858cf55ee03f5019e74aad9eafd12cd9c3ded18059c074a'),
(2, 0, 'Martial', '21b871409ddecf777e047986f87e2b191070226c7a59e09213d824410358ca91028deccc8417dc854c7f136b1f11f96bffea32d09f9cb87f4a42e8971516861f'),
(3, 0, 'Elise', '21b871409ddecf777e047986f87e2b191070226c7a59e09213d824410358ca91028deccc8417dc854c7f136b1f11f96bffea32d09f9cb87f4a42e8971516861f'),
(4, 0, 'Nell', '21b871409ddecf777e047986f87e2b191070226c7a59e09213d824410358ca91028deccc8417dc854c7f136b1f11f96bffea32d09f9cb87f4a42e8971516861f'),
(5, 0, 'Ronan', '21b871409ddecf777e047986f87e2b191070226c7a59e09213d824410358ca91028deccc8417dc854c7f136b1f11f96bffea32d09f9cb87f4a42e8971516861f'),
(6, 0, 'Romain', '21b871409ddecf777e047986f87e2b191070226c7a59e09213d824410358ca91028deccc8417dc854c7f136b1f11f96bffea32d09f9cb87f4a42e8971516861f');

-- --------------------------------------------------------

--
-- Table structure for table `USER_BATTLE`
--

CREATE TABLE `USER_BATTLE` (
  `userId` int(11) NOT NULL,
  `battleId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER_BATTLE`
--

INSERT INTO `USER_BATTLE` (`userId`, `battleId`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `BATTLE`
--
ALTER TABLE `BATTLE`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `CATEGORY`
--
ALTER TABLE `CATEGORY`
  ADD PRIMARY KEY (`id`),
  ADD KEY `battleId` (`battleId`);

--
-- Indexes for table `SONG`
--
ALTER TABLE `SONG`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoryId` (`categoryId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `USER`
--
ALTER TABLE `USER`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `USER_BATTLE`
--
ALTER TABLE `USER_BATTLE`
  ADD PRIMARY KEY (`userId`,`battleId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `battleId` (`battleId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `BATTLE`
--
ALTER TABLE `BATTLE`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `CATEGORY`
--
ALTER TABLE `CATEGORY`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `SONG`
--
ALTER TABLE `SONG`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `USER`
--
ALTER TABLE `USER`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `CATEGORY`
--
ALTER TABLE `CATEGORY`
  ADD CONSTRAINT `CATEGORY_ibfk_1` FOREIGN KEY (`battleId`) REFERENCES `BATTLE` (`id`);

--
-- Constraints for table `SONG`
--
ALTER TABLE `SONG`
  ADD CONSTRAINT `SONG_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `CATEGORY` (`id`),
  ADD CONSTRAINT `SONG_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `USER` (`id`);

--
-- Constraints for table `USER_BATTLE`
--
ALTER TABLE `USER_BATTLE`
  ADD CONSTRAINT `USER_BATTLE_ibfk_1` FOREIGN KEY (`battleId`) REFERENCES `BATTLE` (`id`),
  ADD CONSTRAINT `USER_BATTLE_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `USER` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
