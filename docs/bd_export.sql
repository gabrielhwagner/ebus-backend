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
-- Dumping data for table `ausencia_passageiro`
--

LOCK TABLES `ausencia_passageiro` WRITE;
/*!40000 ALTER TABLE `ausencia_passageiro` DISABLE KEYS */;
INSERT INTO `ausencia_passageiro` VALUES (1,'2020-04-14',1,3,'MOTORISTA');
/*!40000 ALTER TABLE `ausencia_passageiro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dia`
--

LOCK TABLES `dia` WRITE;
/*!40000 ALTER TABLE `dia` DISABLE KEYS */;
INSERT INTO `dia` VALUES (1,'SEG'),(2,'TER'),(3,'QUA'),(4,'QUI'),(5,'SEX'),(6,'SAB'),(7,'DOM');
/*!40000 ALTER TABLE `dia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dia_has_itinerario`
--

LOCK TABLES `dia_has_itinerario` WRITE;
/*!40000 ALTER TABLE `dia_has_itinerario` DISABLE KEYS */;
INSERT INTO `dia_has_itinerario` VALUES (1,1),(2,1),(3,1),(5,1),(6,1),(1,2),(3,2),(5,2),(6,2),(1,3),(2,3),(3,3),(6,3),(1,4),(2,4),(3,4),(6,4);
/*!40000 ALTER TABLE `dia_has_itinerario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` VALUES (1,'Rua Magistério',115,'Sarandi','Porto Alegre','Prédio esquina','91140-300','-29.986797','-51.115147'),(2,'Av. Assis Brasil',2611,'Cristo Redentor','Porto Alegre','Shopping Wallig','91010-004','-30.010883','-51.160388'),(3,'Av. João Wallig',1800,'Passo dAreia','Porto Alegre','Shopping Igauatemi','91340-000','-30.024924','-51.162926'),(4,'R. Olávo Barreto Viana',36,'Moinhos de Vento','Porto Alegre','Shopping Moinhos','90570-070','-30.023824','-51.201528'),(5,'Av. Praia de Belas',1181,'Praia de Belas','Porto Alegre','Shopping Praia de Belas','90110-001','-30.04934','-51.227949'),(6,'Av. Diário de Notícias',300,'Cristal','Porto Alegre','Shopping Barra Sul','90810-080','-30.084676','-51.247381'),(7,'Rua Orfanotrófio',555,'Teresópolis','Porto Alegre','Uniritter','90840-440','-30.080146','-51.218701');
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `historico_passageiro`
--

LOCK TABLES `historico_passageiro` WRITE;
/*!40000 ALTER TABLE `historico_passageiro` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_passageiro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `instituicao`
--

LOCK TABLES `instituicao` WRITE;
/*!40000 ALTER TABLE `instituicao` DISABLE KEYS */;
INSERT INTO `instituicao` VALUES (1,'Centro Universitário Ritter dos Reis\n',7);
/*!40000 ALTER TABLE `instituicao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `itinerario`
--

LOCK TABLES `itinerario` WRITE;
/*!40000 ALTER TABLE `itinerario` DISABLE KEYS */;
INSERT INTO `itinerario` VALUES (1,'MANHA','08:30:00','Ida a Uniritter',1),(2,'TARDE','12:00:00','Volta da Uniritter',1),(3,'NOITE','18:00:00','Ida a Uniritter',1),(4,'NOITE','22:00:00','Volta a Uniritter',1);
/*!40000 ALTER TABLE `itinerario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `itinerario_has_passageiro`
--

LOCK TABLES `itinerario_has_passageiro` WRITE;
/*!40000 ALTER TABLE `itinerario_has_passageiro` DISABLE KEYS */;
INSERT INTO `itinerario_has_passageiro` VALUES (1,1),(3,1),(4,1),(1,2),(2,2),(3,2),(1,3),(2,3),(3,3),(4,3),(1,4),(2,4),(3,4),(1,5),(2,5),(3,5),(4,5),(1,6),(2,6),(3,6),(4,6);
/*!40000 ALTER TABLE `itinerario_has_passageiro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `itinerario_iniciado`
--

LOCK TABLES `itinerario_iniciado` WRITE;
/*!40000 ALTER TABLE `itinerario_iniciado` DISABLE KEYS */;
INSERT INTO `itinerario_iniciado` VALUES (1,1,'ATIVO','2020-04-14 09:10:00',2),(2,1,'INATIVO','2020-04-14 12:00:00',2),(3,1,'ATIVO','2020-04-14 13:00:00',2);
/*!40000 ALTER TABLE `itinerario_iniciado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `localizacao_motorista`
--

LOCK TABLES `localizacao_motorista` WRITE;
/*!40000 ALTER TABLE `localizacao_motorista` DISABLE KEYS */;
INSERT INTO `localizacao_motorista` VALUES (1,'-30.027054','-51.199524','2020-04-14 00:00:00',3);
/*!40000 ALTER TABLE `localizacao_motorista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `motorista`
--

LOCK TABLES `motorista` WRITE;
/*!40000 ALTER TABLE `motorista` DISABLE KEYS */;
INSERT INTO `motorista` VALUES (1,'joão torres','11111111111',7);
/*!40000 ALTER TABLE `motorista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `passageiro`
--

LOCK TABLES `passageiro` WRITE;
/*!40000 ALTER TABLE `passageiro` DISABLE KEYS */;
INSERT INTO `passageiro` VALUES (1,'Claudia Ramos',1,1),(2,'Miguel Davi',2,2),(3,'Davi Miguel',3,3),(4,'Sophia Giovanna',4,4),(5,'Giovanna Sophia',5,5),(6,'Helena Sophia',6,6);
/*!40000 ALTER TABLE `passageiro` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2020-04-15 21:39:13
