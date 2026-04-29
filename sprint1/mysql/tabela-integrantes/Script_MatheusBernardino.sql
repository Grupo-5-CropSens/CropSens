CREATE DATABASE CropSense;
USE CropSense;

CREATE TABLE cliente(
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
cpf_unique VARCHAR(20) NOT NULL UNIQUE,
endereco VARCHAR(100),
email VARCHAR(60),
telefone CHAR(13)
);

CREATE TABLE sensorHC(
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
valor FLOAT,
unidade VARCHAR(20),
data_leitura TIMESTAMP DEFAULT current_timestamp
);

CREATE TABLE plantacao(
id_plantacao INT PRIMARY KEY, 
id_cliente INT NOT NULL,
nome_lote VARCHAR(30),
area_m2 DECIMAL(10,2),
data_plantio DATE NOT NULL,
data_colheita date);

CREATE TABLE leitura_sensor(
id INT PRIMARY KEY,
id_sensor INT NOT NULL,
id_plantacao INT NOT NULL,
altura_cm DECIMAL (6,2) NOT NULL,
timestamp_leitura DATETIME NOT NULL
);

CREATE TABLE alerta(
id INT PRIMARY KEY AUTO_INCREMENT,
id_plantacao INT NOT NULL,
mensagem VARCHAR(200),
lido varchar(30) CHECK(lido in ('Lido', 'Não lido'))
);

INSERT INTO cliente (nome, cpf_unique, endereco, email, telefone) VALUES
('Matheus Silva', '12345678901', 'Rua das Flores, 120 - São Paulo', 'matheus.silva@email.com', '11987654321'),
('Ana Souza', '23456789012', 'Av. Paulista, 900 - São Paulo', 'ana.souza@email.com', '11976543210'),
('Carlos Pereira', '34567890123', 'Rua Augusta, 450 - São Paulo', 'carlos.p@email.com', '11965432109'),
('Juliana Santos', '45678901234', 'Rua Vergueiro, 300 - São Paulo', 'juliana.s@email.com', '11954321098'),
('Ricardo Oliveira', '56789012345', 'Av. Brigadeiro Faria Lima, 1500 - São Paulo', 'ricardo.o@email.com', '11943210987'),
('Fernanda Costa', '67890123456', 'Rua Haddock Lobo, 210 - São Paulo', 'fernanda.c@email.com', '11932109876'),
('Lucas Martins', '78901234567', 'Av. Rebouças, 780 - São Paulo', 'lucas.m@email.com', '11921098765'),
('Beatriz Almeida', '89012345678', 'Rua Consolação, 600 - São Paulo', 'beatriz.a@email.com', '11910987654'),
('Gabriel Rocha', '90123456789', 'Av. Ibirapuera, 1000 - São Paulo', 'gabriel.r@email.com', '11899887766'),
('Camila Ribeiro', '01234567890', 'Rua Pamplona, 350 - São Paulo', 'camila.r@email.com', '11888776655');