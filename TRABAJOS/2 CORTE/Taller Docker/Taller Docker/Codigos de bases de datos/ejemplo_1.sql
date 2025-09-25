CREATE DATABASE  IF NOT EXISTS `ejemplo_1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ejemplo_1`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ejemplo_1
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
-- Table structure for table `Consulta`
--

DROP TABLE IF EXISTS `Consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Consulta` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `motivo` varchar(100) NOT NULL,
  `id_veterinario` int DEFAULT NULL,
  `id_mascota` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_veterinario` (`id_veterinario`),
  KEY `id_mascota` (`id_mascota`),
  CONSTRAINT `Consulta_ibfk_1` FOREIGN KEY (`id_veterinario`) REFERENCES `Veterinario` (`id`),
  CONSTRAINT `Consulta_ibfk_2` FOREIGN KEY (`id_mascota`) REFERENCES `Mascota` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Consulta`
--

LOCK TABLES `Consulta` WRITE;
/*!40000 ALTER TABLE `Consulta` DISABLE KEYS */;
INSERT INTO `Consulta` VALUES (1,'2025-09-12','Muchas Garrapatas',123214,1231),(2,'2025-09-22','No tiene apetito',12313,12555),(3,'2025-09-23','Masa en el cuello',198273,1351332),(4,'2025-09-25','Bajo de Ánimo',123214,1422);
/*!40000 ALTER TABLE `Consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mascota`
--

DROP TABLE IF EXISTS `Mascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mascota` (
  `id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `raza` varchar(50) NOT NULL,
  `edad` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Mascota_chk_1` CHECK ((`edad` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mascota`
--

LOCK TABLES `Mascota` WRITE;
/*!40000 ALTER TABLE `Mascota` DISABLE KEYS */;
INSERT INTO `Mascota` VALUES (1231,'Luffy','chihuahua',12),(1422,'Motas','Labrador',14),(12555,'Gussi','Lobo siberiano',18),(146134,'Firulais','buldog',28),(1351332,'Samy','Dalmata',32);
/*!40000 ALTER TABLE `Mascota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Veterinario`
--

DROP TABLE IF EXISTS `Veterinario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Veterinario` (
  `id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `especialidad` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Veterinario`
--

LOCK TABLES `Veterinario` WRITE;
/*!40000 ALTER TABLE `Veterinario` DISABLE KEYS */;
INSERT INTO `Veterinario` VALUES (12313,'Susana Puentes','Dermatología'),(81920,'Saúl Quintero','Fauna Silvestre'),(123214,'Juan Perez','Cardiología'),(128378,'Samuel Acosta','Aftalmología'),(198273,'María Bernal','Fauna Silvestre');
/*!40000 ALTER TABLE `Veterinario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ejemplo_1'
--

--
-- Dumping routines for database 'ejemplo_1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-24 19:00:32
