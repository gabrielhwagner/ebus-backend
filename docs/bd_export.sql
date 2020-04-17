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

USE heroku_478adca6f832bfb;

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
-- Dumping data for table `ausencia_passageiro`
--

LOCK TABLES `ausencia_passageiro` WRITE;
/*!40000 ALTER TABLE `ausencia_passageiro` DISABLE KEYS */;
INSERT INTO `ausencia_passageiro` VALUES (1,'2020-04-14',1,3,'MOTORISTA');
/*!40000 ALTER TABLE `ausencia_passageiro` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `dia`
--

LOCK TABLES `dia` WRITE;
/*!40000 ALTER TABLE `dia` DISABLE KEYS */;
INSERT INTO `dia` VALUES (1,'SEG'),(2,'TER'),(3,'QUA'),(4,'QUI'),(5,'SEX'),(6,'SAB'),(7,'DOM');
/*!40000 ALTER TABLE `dia` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `dia_has_itinerario`
--

LOCK TABLES `dia_has_itinerario` WRITE;
/*!40000 ALTER TABLE `dia_has_itinerario` DISABLE KEYS */;
INSERT INTO `dia_has_itinerario` VALUES (1,1),(2,1),(3,1),(5,1),(6,1),(1,2),(3,2),(5,2),(6,2),(1,3),(2,3),(3,3),(6,3),(1,4),(2,4),(3,4),(6,4);
/*!40000 ALTER TABLE `dia_has_itinerario` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` VALUES (1,'Rua Magistério',115,'Sarandi','Porto Alegre','Prédio esquina','91140-300','-29.986797','-51.115147'),(2,'Av. Assis Brasil',2611,'Cristo Redentor','Porto Alegre','Shopping Wallig','91010-004','-30.010883','-51.160388'),(3,'Av. João Wallig',1800,'Passo dAreia','Porto Alegre','Shopping Igauatemi','91340-000','-30.024924','-51.162926'),(4,'R. Olávo Barreto Viana',36,'Moinhos de Vento','Porto Alegre','Shopping Moinhos','90570-070','-30.023824','-51.201528'),(5,'Av. Praia de Belas',1181,'Praia de Belas','Porto Alegre','Shopping Praia de Belas','90110-001','-30.04934','-51.227949'),(6,'Av. Diário de Notícias',300,'Cristal','Porto Alegre','Shopping Barra Sul','90810-080','-30.084676','-51.247381'),(7,'Rua Orfanotrófio',555,'Teresópolis','Porto Alegre','Uniritter','90840-440','-30.080146','-51.218701');
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `historico_passageiro`
--

LOCK TABLES `historico_passageiro` WRITE;
/*!40000 ALTER TABLE `historico_passageiro` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_passageiro` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `instituicao`
--

LOCK TABLES `instituicao` WRITE;
/*!40000 ALTER TABLE `instituicao` DISABLE KEYS */;
INSERT INTO `instituicao` VALUES (1,'Centro Universitário Ritter dos Reis\n',7);
/*!40000 ALTER TABLE `instituicao` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `itinerario`
--

LOCK TABLES `itinerario` WRITE;
/*!40000 ALTER TABLE `itinerario` DISABLE KEYS */;
INSERT INTO `itinerario` VALUES (1,'MANHA','08:30:00','Ida a Uniritter',1),(2,'TARDE','12:00:00','Volta da Uniritter',1),(3,'NOITE','18:00:00','Ida a Uniritter',1),(4,'NOITE','22:00:00','Volta a Uniritter',1);
/*!40000 ALTER TABLE `itinerario` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `itinerario_has_passageiro`
--

LOCK TABLES `itinerario_has_passageiro` WRITE;
/*!40000 ALTER TABLE `itinerario_has_passageiro` DISABLE KEYS */;
INSERT INTO `itinerario_has_passageiro` VALUES (1,1),(3,1),(4,1),(1,2),(2,2),(3,2),(1,3),(2,3),(3,3),(4,3),(1,4),(2,4),(3,4),(1,5),(2,5),(3,5),(4,5),(1,6),(2,6),(3,6),(4,6);
/*!40000 ALTER TABLE `itinerario_has_passageiro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itinerario_iniciado`
--

DROP TABLE IF EXISTS `itinerario_iniciado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itinerario_iniciado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `itinerario_id` int NOT NULL,
  `status` enum('ATIVO','NAO_INICIADO','CONCLUIDO') NOT NULL,
  `data` datetime NOT NULL,
  `dia_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_itinerario_status_itinerario1_idx` (`itinerario_id`),
  KEY `fk_itinerario_status_dia1_idx` (`dia_id`),
  CONSTRAINT `fk_itinerario_status_dia1` FOREIGN KEY (`dia_id`) REFERENCES `dia` (`id`),
  CONSTRAINT `fk_itinerario_status_itinerario1` FOREIGN KEY (`itinerario_id`) REFERENCES `itinerario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itinerario_iniciado`
--

LOCK TABLES `itinerario_iniciado` WRITE;
/*!40000 ALTER TABLE `itinerario_iniciado` DISABLE KEYS */;
INSERT INTO `itinerario_iniciado` VALUES (1,1,'NAO_INICIADO','2020-04-14 09:10:00',2),(2,1,'ATIVO','2020-04-14 12:00:00',2),(3,1,'ATIVO','2020-04-14 13:00:00',2);
/*!40000 ALTER TABLE `itinerario_iniciado` ENABLE KEYS */;
UNLOCK TABLES;

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
  `data` datetime NOT NULL,
  `itinerario_iniciado_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_localizacao_motorista_itinerario_iniciado1_idx` (`itinerario_iniciado_id`),
  CONSTRAINT `fk_localizacao_motorista_itinerario_iniciado1` FOREIGN KEY (`itinerario_iniciado_id`) REFERENCES `itinerario_iniciado` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localizacao_motorista`
--

LOCK TABLES `localizacao_motorista` WRITE;
/*!40000 ALTER TABLE `localizacao_motorista` DISABLE KEYS */;
INSERT INTO `localizacao_motorista` VALUES (1,'-30.027054','-51.199524','2020-04-14 00:00:00',3),(2,'-30.027055','-51.199525','2020-04-14 00:10:00',3);
/*!40000 ALTER TABLE `localizacao_motorista` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `motorista`
--

LOCK TABLES `motorista` WRITE;
/*!40000 ALTER TABLE `motorista` DISABLE KEYS */;
INSERT INTO `motorista` VALUES (1,'joão torres','11111111111',7);
/*!40000 ALTER TABLE `motorista` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `passageiro`
--

LOCK TABLES `passageiro` WRITE;
/*!40000 ALTER TABLE `passageiro` DISABLE KEYS */;
INSERT INTO `passageiro` VALUES (1,'Claudia Ramos',1,1),(2,'Miguel Davi',2,2),(3,'Davi Miguel',3,3),(4,'Sophia Giovanna',4,4),(5,'Giovanna Sophia',5,5),(6,'Helena Sophia',6,6);
/*!40000 ALTER TABLE `passageiro` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'PASSAGEIRO','claudia_ramos@teste.com','admin'),(2,'PASSAGEIRO','miguel_davi@teste.com','admin'),(3,'PASSAGEIRO','davi_miguel@teste.com','admin'),(4,'PASSAGEIRO','sophia_giovanna@teste.com','admin'),(5,'PASSAGEIRO','giovanna_sophia@teste.com','admin'),(6,'PASSAGEIRO','helena_sophia@teste.com','admin'),(7,'MOTORISTA','motorista@teste.com','admin');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-17 11:09:15
