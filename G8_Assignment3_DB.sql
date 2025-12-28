-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bpark
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attendants`
--

DROP TABLE IF EXISTS `attendants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendants` (
  `user_id` int NOT NULL,
  `attendant_number` int DEFAULT NULL,
  `attendant_status` enum('active','inactive') NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `attendant_number` (`attendant_number`),
  CONSTRAINT `attendants_ibfk_1` FOREIGN KEY (`attendant_number`) REFERENCES `users` (`user_number`),
  CONSTRAINT `attendants_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendants`
--

LOCK TABLES `attendants` WRITE;
/*!40000 ALTER TABLE `attendants` DISABLE KEYS */;
INSERT INTO `attendants` VALUES (123,3,'active');
/*!40000 ALTER TABLE `attendants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_report`
--

DROP TABLE IF EXISTS `daily_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_report` (
  `date_of_day` date NOT NULL,
  `orders_cnt` int NOT NULL DEFAULT '0',
  `extension_cnt` int NOT NULL DEFAULT '0',
  `cancel_cnt` int NOT NULL DEFAULT '0',
  `hours_parked` int NOT NULL DEFAULT '0',
  `mins_parked` int NOT NULL DEFAULT '0',
  `seconds_parked` int NOT NULL DEFAULT '0',
  `new_order_cnt` int NOT NULL,
  PRIMARY KEY (`date_of_day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_report`
--

LOCK TABLES `daily_report` WRITE;
/*!40000 ALTER TABLE `daily_report` DISABLE KEYS */;
INSERT INTO `daily_report` VALUES ('2025-07-06',4,0,2,0,3,0,7),('2025-07-08',0,0,1,0,0,0,0),('2025-07-09',3,1,2,0,0,0,5);
/*!40000 ALTER TABLE `daily_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extension_request`
--

DROP TABLE IF EXISTS `extension_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extension_request` (
  `extension_request_number` int NOT NULL AUTO_INCREMENT,
  `order_number` int NOT NULL,
  `date_of_request` date NOT NULL,
  `time_of_request` time NOT NULL,
  `request_status` enum('approved','declined') DEFAULT NULL,
  PRIMARY KEY (`extension_request_number`),
  KEY `order_number` (`order_number`),
  CONSTRAINT `extension_request_ibfk_1` FOREIGN KEY (`order_number`) REFERENCES `order` (`order_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extension_request`
--

LOCK TABLES `extension_request` WRITE;
/*!40000 ALTER TABLE `extension_request` DISABLE KEYS */;
INSERT INTO `extension_request` VALUES (1,9,'2025-07-09','20:34:21','approved');
/*!40000 ALTER TABLE `extension_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managers` (
  `user_id` int NOT NULL,
  `manager_number` int DEFAULT NULL,
  `manager_status` enum('active','inactive') NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `manager_number` (`manager_number`),
  CONSTRAINT `managers_ibfk_1` FOREIGN KEY (`manager_number`) REFERENCES `users` (`user_number`),
  CONSTRAINT `managers_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
INSERT INTO `managers` VALUES (318699154,NULL,'active');
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_number` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `order_date` date NOT NULL,
  `order_time` time NOT NULL,
  `scheduled_date` date NOT NULL,
  `scheduled_time_arrive` time NOT NULL,
  `scheduled_time_leave` time NOT NULL,
  `parking_number` int NOT NULL,
  `notified_about_leaving` tinyint(1) DEFAULT '0',
  `confirmation_code` int NOT NULL,
  `receive_code` int NOT NULL,
  `order_status` enum('active','inparking','canceled','finished') NOT NULL DEFAULT 'active',
  `actual_arrive_time` time DEFAULT NULL,
  `actual_leave_time` time DEFAULT NULL,
  PRIMARY KEY (`order_number`),
  UNIQUE KEY `confirmation_code` (`confirmation_code`),
  UNIQUE KEY `receive_code` (`receive_code`),
  KEY `user_id` (`user_id`),
  KEY `parking_number` (`parking_number`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `subscribers` (`user_id`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`parking_number`) REFERENCES `parking` (`parking_number`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,1234,'2025-07-06','20:58:31','2025-07-06','20:58:31','21:13:31',2,0,596417,8907,'canceled',NULL,NULL),(2,1234,'2025-07-06','21:47:40','2025-07-06','21:47:40','22:02:40',3,1,739576,1579,'finished','21:47:55','21:48:50'),(3,1234,'2025-07-06','22:02:17','2025-07-06','22:02:17','22:17:17',1,1,268890,9958,'finished','22:02:46','22:06:10'),(4,1234,'2025-07-06','22:03:23','2025-07-08','08:00:00','12:00:00',3,0,1617,760574,'canceled',NULL,NULL),(5,1234,'2025-07-06','22:13:22','2025-07-08','06:00:00','09:00:00',2,1,2256,758801,'canceled',NULL,NULL),(6,1234,'2025-07-06','22:14:05','2025-07-06','22:14:05','22:29:05',1,1,244268,9693,'finished','22:14:22','22:14:57'),(7,1234,'2025-07-06','22:15:39','2025-07-06','22:15:39','22:30:39',1,0,185238,2540,'finished','22:15:44','22:16:21'),(8,1234,'2025-07-09','20:32:51','2025-07-09','20:32:51','20:47:51',8,0,427580,9166,'canceled',NULL,NULL),(9,1234,'2025-07-09','20:34:05','2025-07-09','20:34:05','01:49:05',4,0,99549,9712,'inparking','20:34:13',NULL),(10,1234,'2025-07-09','20:36:14','2025-07-09','20:36:14','20:51:14',2,1,50100,8226,'inparking','20:43:24',NULL),(11,1234,'2025-07-09','20:39:05','2025-07-10','21:00:00','22:00:00',6,0,4283,601623,'active',NULL,NULL),(12,1234,'2025-07-09','20:43:06','2025-07-09','20:43:06','20:58:06',1,1,181331,3222,'inparking','20:43:42',NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking`
--

DROP TABLE IF EXISTS `parking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parking` (
  `parking_number` int NOT NULL AUTO_INCREMENT,
  `parking_status` enum('available','taken') DEFAULT NULL,
  PRIMARY KEY (`parking_number`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking`
--

LOCK TABLES `parking` WRITE;
/*!40000 ALTER TABLE `parking` DISABLE KEYS */;
INSERT INTO `parking` VALUES (1,'taken'),(2,'taken'),(3,'available'),(4,'taken'),(5,'available'),(6,'available'),(7,'available'),(8,'available'),(9,'available'),(10,'available');
/*!40000 ALTER TABLE `parking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscribers`
--

DROP TABLE IF EXISTS `subscribers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribers` (
  `user_id` int NOT NULL,
  `subscriber_number` int DEFAULT NULL,
  `subscriber_status` enum('active','frozen') NOT NULL,
  `last_login` date DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `subscriber_number` (`subscriber_number`),
  CONSTRAINT `subscribers_ibfk_1` FOREIGN KEY (`subscriber_number`) REFERENCES `users` (`user_number`),
  CONSTRAINT `subscribers_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribers`
--

LOCK TABLES `subscribers` WRITE;
/*!40000 ALTER TABLE `subscribers` DISABLE KEYS */;
INSERT INTO `subscribers` VALUES (1234,2,'active','2025-07-09');
/*!40000 ALTER TABLE `subscribers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `user_number` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(100) NOT NULL,
  `user_type` enum('subscriber','attendant','manager') NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `user_number` (`user_number`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (123,'ameer','rhebi',3,'attendant1','basd','1','attendant','123'),(1234,'bashar','shomaly',2,'bashar2111','basharshomaly1@hotmail.com','11','subscriber','0987'),(318699154,'Bashar','Shoumali',1,'bashar','bashar.shoumali@e.braude.ac.il','1','manager','0527882243');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-09 21:13:27
