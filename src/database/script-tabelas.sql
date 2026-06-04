CREATE DATABASE CropSens;

USE CropSens;

CREATE TABLE empresa (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL,
    empresa_id_empresa INT,
    CONSTRAINT fk_usuario_empresa FOREIGN KEY (empresa_id_empresa)
        REFERENCES empresa(id_empresa)
);

CREATE TABLE fazenda (
    id_fazenda INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    municipio VARCHAR(45),
    cep VARCHAR(45)
);

CREATE TABLE link (
    id_usuario INT,
    id_fazenda INT,
    cargo VARCHAR(45),
    PRIMARY KEY (id_usuario, id_fazenda),
    CONSTRAINT fk_link_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario),
    CONSTRAINT fk_link_fazenda FOREIGN KEY (id_fazenda)
        REFERENCES fazenda(id_fazenda)
);

CREATE TABLE plantacao (
    id_plantacao INT PRIMARY KEY AUTO_INCREMENT,
    data_plantio DATE,
    id_fazenda INT,
    CONSTRAINT fk_plantacao_fazenda FOREIGN KEY (id_fazenda)
        REFERENCES fazenda(id_fazenda)
);

CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    status TINYINT(1),
    altura_instalacao DECIMAL(5,2),
    fkPlantacao INT,
    CONSTRAINT fk_sensor_plantacao FOREIGN KEY (fkPlantacao)
        REFERENCES plantacao(id_plantacao)
);

CREATE TABLE leitura_sensor (
    id_leitura_sensor INT PRIMARY KEY AUTO_INCREMENT,
    distancia_lida_cm DECIMAL(10,2),
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
    CONSTRAINT fk_leitura_sensor FOREIGN KEY (fkSensor)
        REFERENCES sensor(id_sensor)
);