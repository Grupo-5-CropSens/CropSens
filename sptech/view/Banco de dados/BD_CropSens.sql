CREATE DATABASE CropSens;

USE CropSens;

CREATE TABLE usuario (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL,
email VARCHAR(254) NOT NULL UNIQUE,
senha VARCHAR(60) NOT NULL
);

INSERT INTO usuario VALUES 
(DEFAULT, 'Danilo', 'danilo.vrena@sptech.school', 'senha123@'),
(DEFAULT, 'Ana Clara', 'ana.romero@sptech.school', 'senha123@'),
(DEFAULT, 'Daniel Henrique', 'daniel.honorato@sptech.school', 'senha123@'),
(DEFAULT, 'Enzo', 'enzo@sptech.school', 'senha123@'),
(DEFAULT, 'Sophia', 'sophia@sptech.school', 'senha123@');

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

INSERT INTO fazenda (rua, numero,  cidade, estado, cep, fkUsuario) VALUES
('Rua das Flores', 135,'Cuiabá','Mato Grosso', 54950-753, 1), 
('Rua Tantas Palavras', 547, 'Goiânia','Goiás', 37284-837, 2),
('Rua Brasileira', 9567, 'Londrina','Paraná', 18352-267, 3),
('Rua América', 45, 'Aporé', 'Goiás', 48367-243, 4),
('Rua São Francisco', 923, 'Maringá', 'Paraná', 02563-173, 5);

CREATE TABLE plantacao (
id INT PRIMARY KEY AUTO_INCREMENT,
data_plantio DATE,
fkFazenda INT,
	CONSTRAINT fkPlantacao_fazenda FOREIGN KEY(fkFazenda)
      REFERENCES fazenda(id)
);

INSERT INTO plantacao VALUES 
(default, '2025-05-19', 1),
(default, '2025-09-23', 2),
(default, '2025-11-12', 3),
(default, '2026-02-12', 4),
(default, '2026-04-11', 2);

CREATE TABLE sensor (
id INT PRIMARY KEY AUTO_INCREMENT,
statusSensor VARCHAR(12),
  CONSTRAINT chkStatus 
    CHECK(statusSensor IN('ativo', 'inativo', 'manutencao')),
altura_instalacao DECIMAL(5,2) NOT NULL,
fkPlantacao INT,
	CONSTRAINT fkSensor_plantacao FOREIGN KEY(fkPlantacao)
	  REFERENCES plantacao(id)
);

INSERT INTO sensor (id, statusSensor, altura_instalacao, fkPlantacao) VALUES
(DEFAULT, 'ativo', 2.40, 1),
(DEFAULT, 'inativo', 2.40, 3),
(DEFAULT, 'manutencao', 2.40, 2),
(DEFAULT, 'ativo', 2.40, 2),
(DEFAULT, 'ativo', 2.50, 3),
(DEFAULT, 'inativo', 2.60, 1);

CREATE TABLE leitura_sensor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    distancia_lida_cm DECIMAL(10,2),
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
    FOREIGN KEY (fkSensor) REFERENCES sensor(id)
);

DROP DATABASE CropSens;

DROP TABLE alerta;
DROP TABLE leitura_sensor;