-- MySQL Script generated by MySQL Workbench
-- dom 19 abr 2020 14:05:12 -03
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(60) NOT NULL,
  `numero` INT NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(10) NOT NULL,
  `latitude` VARCHAR(45) NOT NULL,
  `longitude` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `endereco_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('PASSAGEIRO', 'MOTORISTA') NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`passageiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`passageiro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `endereco_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_passageiro_endereco_idx` (`endereco_id` ASC) VISIBLE,
  INDEX `fk_passageiro_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_passageiro_endereco`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `mydb`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_passageiro_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mydb`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`instituicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`instituicao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `endereco_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idinstituicao_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_instituicao_endereco1_idx` (`endereco_id` ASC) VISIBLE,
  CONSTRAINT `fk_instituicao_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `mydb`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`itinerario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`itinerario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `turno` ENUM('MANHA', 'TARDE', 'NOITE') NOT NULL,
  `horarioInicio` TIME NOT NULL,
  `descricao` VARCHAR(70) NOT NULL,
  `instituicao_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_itinerario_instituicao1_idx` (`instituicao_id` ASC) VISIBLE,
  CONSTRAINT `fk_itinerario_instituicao1`
    FOREIGN KEY (`instituicao_id`)
    REFERENCES `mydb`.`instituicao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ausencia_passageiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ausencia_passageiro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `passageiro_id` INT NOT NULL,
  `itinerario_id` INT NOT NULL,
  `autor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_ausencia_passageiro1_idx` (`passageiro_id` ASC) VISIBLE,
  INDEX `fk_ausencia_itinerario1_idx` (`itinerario_id` ASC) VISIBLE,
  CONSTRAINT `fk_ausencia_passageiro1`
    FOREIGN KEY (`passageiro_id`)
    REFERENCES `mydb`.`passageiro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ausencia_itinerario1`
    FOREIGN KEY (`itinerario_id`)
    REFERENCES `mydb`.`itinerario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`itinerario_has_passageiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`itinerario_has_passageiro` (
  `itinerario_id` INT NOT NULL,
  `passageiro_id` INT NOT NULL,
  PRIMARY KEY (`itinerario_id`, `passageiro_id`),
  INDEX `fk_itinerario_has_passageiro_passageiro1_idx` (`passageiro_id` ASC) VISIBLE,
  INDEX `fk_itinerario_has_passageiro_itinerario1_idx` (`itinerario_id` ASC) VISIBLE,
  CONSTRAINT `fk_itinerario_has_passageiro_itinerario1`
    FOREIGN KEY (`itinerario_id`)
    REFERENCES `mydb`.`itinerario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itinerario_has_passageiro_passageiro1`
    FOREIGN KEY (`passageiro_id`)
    REFERENCES `mydb`.`passageiro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dia` ENUM('SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB', 'DOM') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dia_has_itinerario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dia_has_itinerario` (
  `dia_id` INT NOT NULL,
  `itinerario_id` INT NOT NULL,
  PRIMARY KEY (`dia_id`, `itinerario_id`),
  INDEX `fk_dia_has_itinerario_itinerario1_idx` (`itinerario_id` ASC) VISIBLE,
  INDEX `fk_dia_has_itinerario_dia1_idx` (`dia_id` ASC) VISIBLE,
  CONSTRAINT `fk_dia_has_itinerario_dia1`
    FOREIGN KEY (`dia_id`)
    REFERENCES `mydb`.`dia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dia_has_itinerario_itinerario1`
    FOREIGN KEY (`itinerario_id`)
    REFERENCES `mydb`.`itinerario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`itinerario_iniciado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`itinerario_iniciado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `itinerario_id` INT NOT NULL,
  `status` ENUM('ATIVO', 'NAO_INICIADO', 'CONCLUIDO') NOT NULL,
  `data` DATETIME NOT NULL,
  `dia_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_itinerario_status_itinerario1_idx` (`itinerario_id` ASC) VISIBLE,
  INDEX `fk_itinerario_status_dia1_idx` (`dia_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_itinerario_status_itinerario1`
    FOREIGN KEY (`itinerario_id`)
    REFERENCES `mydb`.`itinerario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itinerario_status_dia1`
    FOREIGN KEY (`dia_id`)
    REFERENCES `mydb`.`dia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`historico_passageiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`historico_passageiro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `passageiro_id` INT NOT NULL,
  `itinerario_iniciado_id` INT NOT NULL,
  `status` ENUM('EMBARCOU', 'NAO_EMBARCOU') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_historico_passageiro_passageiro1_idx` (`passageiro_id` ASC) VISIBLE,
  INDEX `fk_historico_passageiro_itinerario_iniciado1_idx` (`itinerario_iniciado_id` ASC) VISIBLE,
  CONSTRAINT `fk_historico_passageiro_passageiro1`
    FOREIGN KEY (`passageiro_id`)
    REFERENCES `mydb`.`passageiro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_passageiro_itinerario_iniciado1`
    FOREIGN KEY (`itinerario_iniciado_id`)
    REFERENCES `mydb`.`itinerario_iniciado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`localizacao_motorista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`localizacao_motorista` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `latitude` VARCHAR(45) NOT NULL,
  `longitude` VARCHAR(45) NOT NULL,
  `data` DATETIME NOT NULL,
  `itinerario_iniciado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_localizacao_motorista_itinerario_iniciado1_idx` (`itinerario_iniciado_id` ASC) VISIBLE,
  CONSTRAINT `fk_localizacao_motorista_itinerario_iniciado1`
    FOREIGN KEY (`itinerario_iniciado_id`)
    REFERENCES `mydb`.`itinerario_iniciado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`motorista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`motorista` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_motorista_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_motorista_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mydb`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`indicador_notificacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`indicador_notificacao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `app_id` VARCHAR(45) NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_indicador_notificacao_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_indicador_notificacao_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mydb`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`notificacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`notificacao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_notificacao_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_notificacao_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mydb`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
