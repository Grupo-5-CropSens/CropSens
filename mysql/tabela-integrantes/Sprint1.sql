CREATE DATABASE CropSense;
USE CropSense;

CREATE TABLE cliente(
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
CPF VARCHAR(20) NOT NULL UNIQUE,
CEP VARCHAR(100),
email VARCHAR(60),
telefone CHAR(13)
);

CREATE TABLE sensorHC(
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
valor TINYINT CHECK (valor IN(1,0)),
unidade VARCHAR(20),
data_leitura TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE plantacao(
id_plantacao INT PRIMARY KEY, 
id_cliente INT NOT NULL,
nome_lote VARCHAR(30),
area_m2 DECIMAL(10,2),
data_plantio DATE NOT NULL,
data_colheita DATE
);

CREATE TABLE leitura_sensor(
id INT PRIMARY KEY,
id_sensor INT NOT NULL,
id_plantacao INT NOT NULL,
altura_cm DECIMAL (6,2) NOT NULL,
timestamp_leitura DATETIME NOT NULL
);

-- CLIENTES (mantidos)
INSERT INTO cliente (nome, CPF, CEP, email, telefone) VALUES
('João Batista', '11823456701', '13010-120', 'joao.batista@email.com', '11998765432'),
('Mariana Lopes', '22734567802', '13020-210', 'mariana.lopes@email.com', '11987654321'),
('Fernando Almeida', '33645678903', '13030-320', 'fernando.almeida@email.com', '11976543210'),
('Patricia Andrade', '44556789004', '13040-430', 'patricia.andrade@email.com', '11965432109'),
('Rafael Costa', '55467890105', '13050-540', 'rafael.costa@email.com', '11954321098');




INSERT INTO sensorHC (valor, unidade) VALUES
(1, 'cm'),
(0, 'cm'),
(1, 'cm');

INSERT INTO plantacao (id_plantacao, id_cliente, nome_lote, area_m2, data_plantio, data_colheita) VALUES
(1, 1, 'Lote A', 1500.50, '2025-01-10', '2025-05-10'),
(2, 2, 'Lote B', 2000.00, '2025-02-15', '2025-06-15'),
(3, 3, 'Lote C', 1750.75, '2025-03-01', NULL);


INSERT INTO leitura_sensor (id, id_sensor, id_plantacao, altura_cm, timestamp_leitura) VALUES
(1, 1, 1, 12.5, '2025-03-01 06:00:00'),
(2, 1, 1, 14.2, '2025-03-01 18:00:00'),
(3, 2, 2, 10.8, '2025-03-02 06:00:00'),
(4, 2, 2, 13.0, '2025-03-02 18:00:00'),
(5, 3, 3, 9.5, '2025-03-03 06:00:00'),
(6, 3, 3, 11.7, '2025-03-03 18:00:00');