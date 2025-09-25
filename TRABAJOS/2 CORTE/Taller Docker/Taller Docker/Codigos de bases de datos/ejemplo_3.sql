CREATE DATABASE  IF NOT EXISTS `ejemplo_3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ejemplo_3`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ejemplo_3
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `Atleta`
--

DROP TABLE IF EXISTS `Atleta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Atleta` (
  `id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `edad` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Atleta_chk_1` CHECK ((`edad` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Atleta`
--

LOCK TABLES `Atleta` WRITE;
/*!40000 ALTER TABLE `Atleta` DISABLE KEYS */;
INSERT INTO `Atleta` VALUES (124,'Sthit Fernandez',12),(2134,'Roberto Sanchez',31),(2314,'Camilo Bonilla',40),(3516,'Ester Cabrera',32),(124213,'Lionel Alvares',23);
/*!40000 ALTER TABLE `Atleta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Entrenador`
--

DROP TABLE IF EXISTS `Entrenador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Entrenador` (
  `id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `especialidad` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Entrenador`
--

LOCK TABLES `Entrenador` WRITE;
/*!40000 ALTER TABLE `Entrenador` DISABLE KEYS */;
INSERT INTO `Entrenador` VALUES (12132,'Susana Ramirez','Mental'),(21431,'Juan Mendoza','Técnica'),(123123,'Felipe Caviedes','Tática'),(134312,'Maria Bernal','Física'),(2152134,'Juan Mendez','Física');
/*!40000 ALTER TABLE `Entrenador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SesionEntrenamiento`
--

DROP TABLE IF EXISTS `SesionEntrenamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SesionEntrenamiento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `id_entrenador` int DEFAULT NULL,
  `id_atleta` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_entrenador` (`id_entrenador`),
  KEY `id_atleta` (`id_atleta`),
  CONSTRAINT `SesionEntrenamiento_ibfk_1` FOREIGN KEY (`id_entrenador`) REFERENCES `Entrenador` (`id`),
  CONSTRAINT `SesionEntrenamiento_ibfk_2` FOREIGN KEY (`id_atleta`) REFERENCES `Atleta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SesionEntrenamiento`
--

LOCK TABLES `SesionEntrenamiento` WRITE;
/*!40000 ALTER TABLE `SesionEntrenamiento` DISABLE KEYS */;
INSERT INTO `SesionEntrenamiento` VALUES (1,'2025-09-22','10:09:58',2152134,124213),(2,'2025-09-20','12:09:58',21431,2134),(3,'2025-09-24','13:17:50',12132,124),(4,'2025-09-23','16:30:45',123123,2314);
/*!40000 ALTER TABLE `SesionEntrenamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ejemplo_3'
--

--
-- Dumping routines for database 'ejemplo_3'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-24 19:02:38
