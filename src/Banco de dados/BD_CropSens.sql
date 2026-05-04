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
nome VARCHAR(50),
municipio VARCHAR(50),
cep VARCHAR(13),
fkUsuario INT,
  CONSTRAINT fkFazenda_usuario FOREIGN KEY(fkUsuario) 
    REFERENCES usuario(id)
);

INSERT INTO fazenda (nome, municipio, cep, fkUsuario) VALUES
('Fazenda Flores', 'Mato Grosso', '54950-753', 1), 
('Fazenda dos sonhos', 'Goiás', '37284-837', 2),
('Fazenda Carrossel', 'Paraná', '18352-267', 3),
('Fazenda da luz', 'Goiás', '48367-243', 4),
('Fazenda milharal', 'Paraná', '02563-173', 5);

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

SELECT * FROM usuario;
SELECT * FROM fazenda;
SELECT * FROM plantacao;
SELECT * FROM sensor;
SELECT * FROM leitura_sensor;

SELECT u.nome AS Usuario, u.email AS Email, f.nome AS 'Nome Fazenda', f.cep AS CEP FROM usuario AS u JOIN fazenda AS f ON f.fkUsuario = u.id;

SELECT u.nome AS Usuario, f.nome AS 'Nome Fazenda', f.cep AS CEP, p.id AS 'ID_Plantação'
 FROM usuario AS u JOIN fazenda AS f ON f.fkUsuario = u.id JOIN plantacao as p ON p.fkFazenda = f.id;
 
SELECT u.nome AS 'Usuário', f.nome AS 'Nome Fazenda', p.id AS 'ID_Plantação', s.statusSensor AS 'Status do Sensor' 
	FROM usuario AS u JOIN fazenda AS f ON f.fkUsuario = u.id 
		JOIN plantacao AS p ON p.fkFazenda = f.id
			JOIN sensor AS s ON s.fkPlantacao = p.id WHERE statusSensor = 'ativo';
            
SELECT u.nome AS 'Usuário', f.nome AS 'Nome Fazenda', p.id AS 'ID_Plantação', s.statusSensor AS 'Status do Sensor' 
	FROM usuario AS u JOIN fazenda AS f ON f.fkUsuario = u.id 
		JOIN plantacao AS p ON p.fkFazenda = f.id
			JOIN sensor AS s ON s.fkPlantacao = p.id  WHERE statusSensor = 'inativo';
            
SELECT u.nome AS 'Usuário', f.nome AS 'Nome Fazenda', p.id AS 'ID_Plantação', s.statusSensor AS 'Status do Sensor' 
	FROM usuario AS u JOIN fazenda AS f ON f.fkUsuario = u.id 
		JOIN plantacao AS p ON p.fkFazenda = f.id
			JOIN sensor AS s ON s.fkPlantacao = p.id  WHERE statusSensor = 'manutencao';
 
SELECT u.nome AS 'Usuário', f.nome AS 'Nome Fazenda', p.id AS 'ID_Plantação', s.statusSensor AS 'Status do Sensor' 
	FROM usuario AS u JOIN fazenda AS f ON f.fkUsuario = u.id 
		JOIN plantacao AS p ON p.fkFazenda = f.id
			JOIN sensor AS s ON s.fkPlantacao = p.id;
            
