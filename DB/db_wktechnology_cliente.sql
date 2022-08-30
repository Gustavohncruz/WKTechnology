CREATE DATABASE  IF NOT EXISTS `db_wktechnology` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_wktechnology`;
-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: db_wktechnology
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `IDCLIENTE` int NOT NULL AUTO_INCREMENT,
  `CODIGO` varchar(10) DEFAULT NULL,
  `NOME` varchar(100) DEFAULT NULL,
  `CIDADE` varchar(100) DEFAULT NULL,
  `UF` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`IDCLIENTE`),
  UNIQUE KEY `CODIGO_UNIQUE` (`CODIGO`),
  KEY `IDX_NOME` (`NOME`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'001','SILVIO SANTOS','SÃO PAULO','SP'),(2,'002','FAUSTO SILVA','SÃO PAULO','SP'),(3,'003','ANTONIO BANDERAS','RIO DE JANEIRO','RJ'),(4,'004','BONO VOX','SÃO PAULO','SP'),(5,'005','CHUCK NORRIRS','SÃO PAULO','SP'),(6,'006','DEMI MOORE','SÃO PAULO','SP'),(7,'007','FERNANDA MONTENEGRO','SÃO PAULO','SP'),(8,'008','FREDDIE MERCURY','SÃO PAULO','SP'),(9,'009','JACKIE CHAN','RIO DE JANEIRO','RJ'),(10,'010','JODIE FOSTER','RIO DE JANEIRO','RJ'),(11,'011','JON BON JOVI','RIO DE JANEIRO','RJ'),(12,'012','KATY PERRY','BETIM','MG'),(13,'013','ELTON JOHN','BETIM','MG'),(14,'014','ETTA JAMES','BETIM','MG'),(15,'015','NICOLAS CAGE','SÃO PAULO','SP'),(16,'016','ROBERT DE NIRO','SÃO PAULO','SP'),(17,'017','SEAN CONNERY','SÃO PAULO','SP'),(18,'018','ED SHEERAN','SÃO PAULO','SP'),(19,'019','WILL SMITH','SÃO PAULO','SP'),(20,'020','DANIEL CRAIG','SÃO PAULO','SP');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-30 13:23:13
