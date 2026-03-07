
/*  GRUPO 5
Alexandre Tabacchi - 03261068
Arthur Balduino - 03261014
Kauã Pedroso - 03261026
Marcela Fachim - 03261019
Matheus Bernardino - 03261028
Pedro Caparroz - 03261005
Yuri Dairiki - 03261016 */

CREATE DATABASE CropSense;
USE CropSense;

CREATE TABLE cliente(
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
CPF CHAR(12) NOT NULL UNIQUE,
CEP CHAR(9),
email VARCHAR(60),
senha VARCHAR(25),
telefone CHAR(13)
);

CREATE TABLE empresas(
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
nome_fantasia VARCHAR(50),
cnpj CHAR(14) UNIQUE NOT NULL,
razao_social VARCHAR(80), 
data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE sensores(
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
estado VARCHAR(15) NOT NULL, 
CONSTRAINT chk_estado_fisico_sensor 
CHECK (estado IN('critico', 'inoperante', 'bom')),
local_instalacao VARCHAR(20),
data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE plantacao(
id_plantacao INT PRIMARY KEY AUTO_INCREMENT, 
id_cliente INT ,
id_empresa INT,
nome_lote VARCHAR(30),
area_m2 DECIMAL(10,2),
data_plantio DATE NOT NULL,
data_colheita DATE
);

CREATE TABLE leitura_sensor(
id INT PRIMARY KEY AUTO_INCREMENT,
id_sensor INT NOT NULL,
id_plantacao INT NOT NULL, 
nome_lote VARCHAR(30),
altura_cm DECIMAL (6,2) NOT NULL,
timestamp_leitura DATETIME NOT NULL,
resposta_sensor TINYINT,
CONSTRAINT chk_resposta 
CHECK (resposta_sensor IN(1,0))
);

-- CLIENTES (mantidos)
INSERT INTO cliente (nome, CPF, CEP, email, senha, telefone) VALUES
('João Batista', '11823456701', '13010-120', 'joao.batista@email.com', 'senha123', '11998765432'),
('Mariana Lopes', '22734567802', '13020-210', 'mariana.lopes@email.com', 'tenhosaud', '11987654321'),
('Fernando Almeida', '33645678903', '13030-320', 'fernando.almeida@email.com', 'moias', '11976543210'),
('Patricia Andrade', '44556789004', '13040-430', 'patricia.andrade@email.com', 'corinthians', '11965432109'),
('Rafael Costa', '55467890105', '13050-540', 'rafael.costa@email.com', 'midastouch', '11954321098');


INSERT INTO empresas (nome_fantasia, cnpj, razao_social) VALUES
('AgroTech Soluções', '12345678000101', 'AgroTech Soluções Agrícolas LTDA'),
('Campo Inteligente', '23456789000102', 'Campo Inteligente Tecnologia Rural SA'),
('Verde Sensorial', '34567890000103', 'Verde Sensorial Monitoramento Agrícola LTDA');


INSERT INTO sensores (estado, local_instalacao) VALUES
('bom', 'Lote A'),
('bom', 'Lote B'),
('critico', 'Lote C'),
('inoperante', 'Estufa 1'),
('bom', 'Estufa 2');

INSERT INTO plantacao (id_cliente, nome_lote, area_m2, data_plantio, data_colheita) VALUES
(1, 'Lote A', 1500.50, '2025-01-10', '2025-05-10'),
(2, 'Lote B', 2000.00, '2025-02-15', '2025-06-15'),
(3, 'Lote C', 1750.75, '2025-03-01', NULL);

INSERT INTO leitura_sensor (id_sensor, id_plantacao, altura_cm, timestamp_leitura) VALUES
(1, 1, 12.5, '2025-03-01 06:00:00'),
(1, 1, 14.2, '2025-03-01 18:00:00'),
(2, 2, 10.8, '2025-03-02 06:00:00'),
(2, 2, 13.0, '2025-03-02 18:00:00'),
(3, 3, 9.5, '2025-03-03 06:00:00'),
(3, 3, 11.7, '2025-03-03 18:00:00');


-- MOSTRAR ESTADO FÍSICO DOS SENSORES
SELECT id_sensor, estado, data_cadastro FROM sensores;

-- MOSTRAR QUAIS PLANTAÇÕES AINDA NÃO FORAM COLHIDAS
SELECT nome_lote,data_plantio FROM plantacao WHERE data_colheita IS NULL;

-- MOSTRAR USUÁRIO E SENHA

SELECT nome, senha FROM cliente;