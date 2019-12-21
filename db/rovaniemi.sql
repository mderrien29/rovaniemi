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
(1, 1, 'La chanson qu\'on écoute en boucle en ce moment'),
(2, 1, 'La chanson pour dancer'),
(3, 1, 'La chanson qu\'on écoute en secret'),
(4, 1, 'La plus belle des chansons'),
(5, 1, 'La chanson qu\'on souhaite d\'écouter à son pire ennemi'),
(6, 1, 'La découverte de l\'année');

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
(1, 1, 'Admin', '18e8cf03be682008032d9adb502ea590906c088ec5ae69ca0f2028b8844c65758492dfd2937344dde2f419f193ace88895012b3fb05bc2c941189fa02200cc5f'),
(2, 0, 'Martial', '15efeadb168827003da1bfe1befbc2d816215b2402b32afba96b99b6696f3de69f9e0caa98622a77e74eef40c6a6fa125493bbd3a20b8e11324dfc0d507c028d'),
(3, 0, 'Elise', '06e07ba98d30da98f9a7ad8243781d687f913b7cd8c2afcd6dbfa0abcd34fb0d62660bc2d2d3ed580d0d93caaec31441102f20403a684fc02447284eeb54ac40'),
(4, 0, 'Nell', '14c8319b25b882dfc7c0e16f72c4677374950512945a886b48ace5c1e5b28019a8208bc0f450c56ba2a6d83db18cedafa20e06557bebf5dc1899d48738f4cb2b'),
(5, 0, 'Ronan', 'e7f1a03baa8a0fbfe26c1ad14e0b1eeeafefbe3bd1184eea0a010481afb17b70334056d51ab419e3ec620fc92d114a1deab1e7b708f5480ef6d0f11abb3254c0'),
(6, 0, 'Romain', 'ea8c5d21da107d52bb0fae4c5a94691cbfb7df16d5c9b3a82d06e627c161dc96f49084a68f178c5f6167cba65093f5ce5c545132bb0124924427bf083a6555b4');

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
