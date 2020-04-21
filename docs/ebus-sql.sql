USE `heroku_478adca6f832bfb` ;

-- -----------------------------------------------------
-- Table `endereco`
-- -----------------------------------------------------
CREATE TABLE `endereco` (
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
  UNIQUE INDEX `endereco_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuario`
-- -----------------------------------------------------
CREATE TABLE `usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('PASSAGEIRO', 'MOTORISTA') NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `passageiro`
-- -----------------------------------------------------
CREATE TABLE `passageiro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `endereco_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_passageiro_endereco_idx` (`endereco_id` ASC),
  INDEX `fk_passageiro_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_passageiro_endereco`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_passageiro_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instituicao`
-- -----------------------------------------------------
CREATE TABLE `instituicao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `endereco_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idinstituicao_UNIQUE` (`id` ASC),
  INDEX `fk_instituicao_endereco1_idx` (`endereco_id` ASC),
  CONSTRAINT `fk_instituicao_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itinerario`
-- -----------------------------------------------------
CREATE TABLE `itinerario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `turno` ENUM('MANHA', 'TARDE', 'NOITE') NOT NULL,
  `horarioInicio` TIME NOT NULL,
  `descricao` VARCHAR(70) NOT NULL,
  `instituicao_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_itinerario_instituicao1_idx` (`instituicao_id` ASC),
  CONSTRAINT `fk_itinerario_instituicao1`
    FOREIGN KEY (`instituicao_id`)
    REFERENCES `instituicao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ausencia_passageiro`
-- -----------------------------------------------------
CREATE TABLE `ausencia_passageiro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `passageiro_id` INT NOT NULL,
  `itinerario_id` INT NOT NULL,
  `autor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_ausencia_passageiro1_idx` (`passageiro_id` ASC),
  INDEX `fk_ausencia_itinerario1_idx` (`itinerario_id` ASC),
  CONSTRAINT `fk_ausencia_passageiro1`
    FOREIGN KEY (`passageiro_id`)
    REFERENCES `passageiro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ausencia_itinerario1`
    FOREIGN KEY (`itinerario_id`)
    REFERENCES `itinerario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itinerario_has_passageiro`
-- -----------------------------------------------------
CREATE TABLE `itinerario_has_passageiro` (
  `itinerario_id` INT NOT NULL,
  `passageiro_id` INT NOT NULL,
  PRIMARY KEY (`itinerario_id`, `passageiro_id`),
  INDEX `fk_itinerario_has_passageiro_passageiro1_idx` (`passageiro_id` ASC),
  INDEX `fk_itinerario_has_passageiro_itinerario1_idx` (`itinerario_id` ASC),
  CONSTRAINT `fk_itinerario_has_passageiro_itinerario1`
    FOREIGN KEY (`itinerario_id`)
    REFERENCES `itinerario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itinerario_has_passageiro_passageiro1`
    FOREIGN KEY (`passageiro_id`)
    REFERENCES `passageiro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dia`
-- -----------------------------------------------------
CREATE TABLE `dia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dia` ENUM('SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB', 'DOM') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dia_has_itinerario`
-- -----------------------------------------------------
CREATE TABLE `dia_has_itinerario` (
  `dia_id` INT NOT NULL,
  `itinerario_id` INT NOT NULL,
  PRIMARY KEY (`dia_id`, `itinerario_id`),
  INDEX `fk_dia_has_itinerario_itinerario1_idx` (`itinerario_id` ASC),
  INDEX `fk_dia_has_itinerario_dia1_idx` (`dia_id` ASC),
  CONSTRAINT `fk_dia_has_itinerario_dia1`
    FOREIGN KEY (`dia_id`)
    REFERENCES `dia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dia_has_itinerario_itinerario1`
    FOREIGN KEY (`itinerario_id`)
    REFERENCES `itinerario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itinerario_iniciado`
-- -----------------------------------------------------
CREATE TABLE `itinerario_iniciado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `itinerario_id` INT NOT NULL,
  `status` ENUM('ATIVO', 'CONCLUIDO') NOT NULL,
  `data` DATETIME NOT NULL,
  `dia_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_itinerario_status_itinerario1_idx` (`itinerario_id` ASC),
  INDEX `fk_itinerario_status_dia1_idx` (`dia_id` ASC),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_itinerario_status_itinerario1`
    FOREIGN KEY (`itinerario_id`)
    REFERENCES `itinerario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itinerario_status_dia1`
    FOREIGN KEY (`dia_id`)
    REFERENCES `dia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `historico_passageiro`
-- -----------------------------------------------------
CREATE TABLE `historico_passageiro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `passageiro_id` INT NOT NULL,
  `itinerario_iniciado_id` INT NOT NULL,
  `status` ENUM('EMBARCOU', 'NAO_EMBARCOU') NOT NULL,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_historico_passageiro_passageiro1_idx` (`passageiro_id` ASC),
  INDEX `fk_historico_passageiro_itinerario_iniciado1_idx` (`itinerario_iniciado_id` ASC),
  CONSTRAINT `fk_historico_passageiro_passageiro1`
    FOREIGN KEY (`passageiro_id`)
    REFERENCES `passageiro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_passageiro_itinerario_iniciado1`
    FOREIGN KEY (`itinerario_iniciado_id`)
    REFERENCES `itinerario_iniciado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `localizacao_motorista`
-- -----------------------------------------------------
CREATE TABLE `localizacao_motorista` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `latitude` VARCHAR(45) NOT NULL,
  `longitude` VARCHAR(45) NOT NULL,
  `data` DATETIME NOT NULL,
  `itinerario_iniciado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_localizacao_motorista_itinerario_iniciado1_idx` (`itinerario_iniciado_id` ASC),
  CONSTRAINT `fk_localizacao_motorista_itinerario_iniciado1`
    FOREIGN KEY (`itinerario_iniciado_id`)
    REFERENCES `itinerario_iniciado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `motorista`
-- -----------------------------------------------------
CREATE TABLE `motorista` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_motorista_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_motorista_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `indicador_notificacao`
-- -----------------------------------------------------
CREATE TABLE `indicador_notificacao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `app_id` VARCHAR(45) NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_indicador_notificacao_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_indicador_notificacao_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `notificacao`
-- -----------------------------------------------------
CREATE TABLE `notificacao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `usuario_id` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `status` ENUM('NOVO', 'LIDO') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_notificacao_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_notificacao_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
