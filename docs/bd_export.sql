-- MySQL dump 10.13  Distrib 8.0.19, for Linux (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.19-0ubuntu0.19.10.3

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
-- Table structure for table `ausencia_passageiro`
--

DROP TABLE IF EXISTS `ausencia_passageiro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ausencia_passageiro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `passageiro_id` int NOT NULL,
  `itinerario_id` int NOT NULL,
  `autor` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_ausencia_passageiro1_idx` (`passageiro_id`),
  KEY `fk_ausencia_itinerario1_idx` (`itinerario_id`),
  CONSTRAINT `fk_ausencia_itinerario1` FOREIGN KEY (`itinerario_id`) REFERENCES `itinerario` (`id`),
  CONSTRAINT `fk_ausencia_passageiro1` FOREIGN KEY (`passageiro_id`) REFERENCES `passageiro` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dia`
--

DROP TABLE IF EXISTS `dia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dia` enum('SEG','TER','QUA','QUI','SEX','SAB','DOM') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dia_has_itinerario`
--

DROP TABLE IF EXISTS `dia_has_itinerario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dia_has_itinerario` (
  `dia_id` int NOT NULL,
  `itinerario_id` int NOT NULL,
  PRIMARY KEY (`dia_id`,`itinerario_id`),
  KEY `fk_dia_has_itinerario_itinerario1_idx` (`itinerario_id`),
  KEY `fk_dia_has_itinerario_dia1_idx` (`dia_id`),
  CONSTRAINT `fk_dia_has_itinerario_dia1` FOREIGN KEY (`dia_id`) REFERENCES `dia` (`id`),
  CONSTRAINT `fk_dia_has_itinerario_itinerario1` FOREIGN KEY (`itinerario_id`) REFERENCES `itinerario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `endereco` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logradouro` varchar(60) NOT NULL,
  `numero` int NOT NULL,
  `bairro` varchar(45) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `complemento` varchar(45) NOT NULL,
  `cep` varchar(10) NOT NULL,
  `latitude` varchar(45) NOT NULL,
  `longitude` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `endereco_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `historico_passageiro`
--

DROP TABLE IF EXISTS `historico_passageiro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_passageiro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `passageiro_id` int NOT NULL,
  `itinerario_iniciado_id` int NOT NULL,
  `status` enum('EMBARCOU','NAO_EMBARCOU') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_historico_passageiro_passageiro1_idx` (`passageiro_id`),
  KEY `fk_historico_passageiro_itinerario_iniciado1_idx` (`itinerario_iniciado_id`),
  CONSTRAINT `fk_historico_passageiro_itinerario_iniciado1` FOREIGN KEY (`itinerario_iniciado_id`) REFERENCES `itinerario_iniciado` (`id`),
  CONSTRAINT `fk_historico_passageiro_passageiro1` FOREIGN KEY (`passageiro_id`) REFERENCES `passageiro` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instituicao`
--

DROP TABLE IF EXISTS `instituicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instituicao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `endereco_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idinstituicao_UNIQUE` (`id`),
  KEY `fk_instituicao_endereco1_idx` (`endereco_id`),
  CONSTRAINT `fk_instituicao_endereco1` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itinerario`
--

DROP TABLE IF EXISTS `itinerario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itinerario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `turno` enum('MANHA','TARDE','NOITE') NOT NULL,
  `horarioInicio` time NOT NULL,
  `descricao` varchar(70) NOT NULL,
  `instituicao_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_itinerario_instituicao1_idx` (`instituicao_id`),
  CONSTRAINT `fk_itinerario_instituicao1` FOREIGN KEY (`instituicao_id`) REFERENCES `instituicao` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itinerario_has_passageiro`
--

DROP TABLE IF EXISTS `itinerario_has_passageiro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itinerario_has_passageiro` (
  `itinerario_id` int NOT NULL,
  `passageiro_id` int NOT NULL,
  PRIMARY KEY (`itinerario_id`,`passageiro_id`),
  KEY `fk_itinerario_has_passageiro_passageiro1_idx` (`passageiro_id`),
  KEY `fk_itinerario_has_passageiro_itinerario1_idx` (`itinerario_id`),
  CONSTRAINT `fk_itinerario_has_passageiro_itinerario1` FOREIGN KEY (`itinerario_id`) REFERENCES `itinerario` (`id`),
  CONSTRAINT `fk_itinerario_has_passageiro_passageiro1` FOREIGN KEY (`passageiro_id`) REFERENCES `passageiro` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itinerario_iniciado`
--

DROP TABLE IF EXISTS `itinerario_iniciado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itinerario_iniciado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `itinerario_id` int NOT NULL,
  `ativo` enum('ATIVO','INATIVO') NOT NULL,
  `data` datetime NOT NULL,
  `dia_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_itinerario_status_itinerario1_idx` (`itinerario_id`),
  KEY `fk_itinerario_status_dia1_idx` (`dia_id`),
  CONSTRAINT `fk_itinerario_status_dia1` FOREIGN KEY (`dia_id`) REFERENCES `dia` (`id`),
  CONSTRAINT `fk_itinerario_status_itinerario1` FOREIGN KEY (`itinerario_id`) REFERENCES `itinerario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `localizacao_motorista`
--

DROP TABLE IF EXISTS `localizacao_motorista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localizacao_motorista` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `latitude` varchar(45) NOT NULL,
  `longitude` varchar(45) NOT NULL,
  `date` datetime NOT NULL,
  `itinerario_iniciado_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_localizacao_motorista_itinerario_iniciado1_idx` (`itinerario_iniciado_id`),
  CONSTRAINT `fk_localizacao_motorista_itinerario_iniciado1` FOREIGN KEY (`itinerario_iniciado_id`) REFERENCES `itinerario_iniciado` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `motorista`
--

DROP TABLE IF EXISTS `motorista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `motorista` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `cpf` varchar(45) NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_motorista_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_motorista_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `passageiro`
--

DROP TABLE IF EXISTS `passageiro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passageiro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `endereco_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_passageiro_endereco_idx` (`endereco_id`),
  KEY `fk_passageiro_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_passageiro_endereco` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`),
  CONSTRAINT `fk_passageiro_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` enum('PASSAGEIRO','MOTORISTA') NOT NULL,
  `email` varchar(45) NOT NULL,
  `senha` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-15 20:09:02
