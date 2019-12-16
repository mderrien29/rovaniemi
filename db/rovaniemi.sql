-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Dec 16, 2019 at 09:09 PM
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
(1, 1, 'Admin', '18E8CF03BE682008032D9ADB502EA590906C088EC5AE69CA0F2028B8844C65758492DFD2937344DDE2F419F193ACE88895012B3FB05BC2C941189FA02200CC5F'),
(2, 0, 'Martial', '15EFEADB168827003DA1BFE1BEFBC2D816215B2402B32AFBA96B99B6696F3DE69F9E0CAA98622A77E74EEF40C6A6FA125493BBD3A20B8E11324DFC0D507C028D'),
(3, 0, 'Elise', '06E07BA98D30DA98F9A7AD8243781D687F913B7CD8C2AFCD6DBFA0ABCD34FB0D62660BC2D2D3ED580D0D93CAAEC31441102F20403A684FC02447284EEB54AC40'),
(4, 0, 'Nell', '315ED22107445321B0EC40D31C8111563143362A0D6465BFB53B78AA896035656D90D42A11CDF1F2F1F81874644181D166035EBF82EAA36C1DB08DA299E147ED'),
(5, 0, 'Ronan', '5AF17752A3BBA3A921EEB0FB57787858D7DA598052980BBF5AA063C494FB203DB5DAD62893EA81BE740EE0A06F0C7B1E5480F5962FAFF08B1443EA686E3EDB63'),
(6, 0, 'Romain', 'E22B09B8503B4EB77D8855AC6CE565821302881387026AEB88E3CB72DE6191FAE6CF719AE3D9F2ED68142C4122CE2BB878165DC317096AB2A47895DE56C1BF60');

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
