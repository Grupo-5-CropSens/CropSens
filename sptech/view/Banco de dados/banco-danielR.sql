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
nome VARCHAR(70),
localizacao VARCHAR(100),
fkUsuario INT,
  CONSTRAINT fkFazenda_usuario FOREIGN KEY(fkUsuario) 
    REFERENCES usuario(id)
);

CREATE TABLE plantacao (
id INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR(45),
data_plantio DATE,
fkFazenda INT,
	CONSTRAINT fkPlantacao_fazenda FOREIGN KEY(fkFazenda)
      REFERENCES fazenda(id)
);

CREATE TABLE sensor (
id INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR(50),
statusSensor VARCHAR(50),
fkFazenda INT,
	CONSTRAINT fkSensor_fazenda FOREIGN KEY(fkFazenda)
	  REFERENCES fazenda(id)
);

CREATE TABLE leitura_sensor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(10,2),
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
    FOREIGN KEY (fkSensor) REFERENCES sensor(id)
);

CREATE TABLE alerta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    mensagem VARCHAR(200),
    nivel VARCHAR(20), -- baixo, médio, alto acho que vou tirar
    data_hora DATETIME,
    fkSensor INT,
    FOREIGN KEY (fkSensor) REFERENCES sensor(id)
);
