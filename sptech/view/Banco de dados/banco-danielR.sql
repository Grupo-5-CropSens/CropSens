CREATE DATABASE CropSens;

USE CropSens;

CREATE TABLE usuario (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL,
email VARCHAR(254) NOT NULL UNIQUE,
senha VARCHAR(60) NOT NULL,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE fazenda (
id INT PRIMARY KEY AUTO_INCREMENT,
rua VARCHAR(70),
numero VARCHAR(10),
cidade VARCHAR(50),
estado VARCHAR(50),
cep VARCHAR(10),
fkUsuario INT,
  CONSTRAINT fkFazenda_usuario FOREIGN KEY(fkUsuario) 
    REFERENCES usuario(id)
);

CREATE TABLE plantacao (
id INT PRIMARY KEY AUTO_INCREMENT,
data_plantio DATE,
fkFazenda INT,
	CONSTRAINT fkPlantacao_fazenda FOREIGN KEY(fkFazenda)
      REFERENCES fazenda(id)
);

CREATE TABLE sensor (
id INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR(50),
statusSensor VARCHAR(12),
  CONSTRAINT chkStatus 
    CHECK(statusSensor IN('ativo', 'inativo', 'manutencao')),
altura_instalacao DECIMAL(5,2) NOT NULL,
fkPlantacao INT,
	CONSTRAINT fkSensor_plantacao FOREIGN KEY(fkPlantacao)
	  REFERENCES plantacao(id)
);

CREATE TABLE leitura_sensor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    distancia_lida_cm DECIMAL(10,2),
    altura_calculada_planta DECIMAL(10,2), -- (altura_instalacao - distancia_lida)
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
    FOREIGN KEY (fkSensor) REFERENCES sensor(id)
);

CREATE TABLE alerta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    mensagem VARCHAR(200),
    nivel VARCHAR(20),
    CONSTRAINT chkNivel CHECK(nivel IN ('baixo', 'medio', 'alto')),
    data_hora DATETIME,
    fkSensor INT,
    FOREIGN KEY (fkSensor) REFERENCES sensor(id)
);

DROP DATABASE CropSens;

DROP TABLE alerta;
DROP TABLE leitura_sensor;
