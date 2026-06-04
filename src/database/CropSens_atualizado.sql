CREATE DATABASE CropSens;
USE CropSens;

CREATE TABLE empresa (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);

INSERT INTO empresa (nome) VALUES
('AgroTech Solutions'),
('GreenFarm LTDA'),
('CropSens Brasil');

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL,
    empresa_id_empresa INT,
    CONSTRAINT fk_usuario_empresa FOREIGN KEY (empresa_id_empresa)
        REFERENCES empresa(id_empresa)
);

INSERT INTO usuario (nome, email, senha, empresa_id_empresa) VALUES
('Danilo Silva', 'danilo@cropsens.com', '123456', 3),
('Carla Mendes', 'carla@cropsens.com', '123456', 3),
('Joao Pereira', 'joao@agrotech.com', '123456', 1),
('Maria Souza', 'maria@agrotech.com', '123456', 1),
('Pedro Santos', 'pedro@greenfarm.com', '123456', 2),
('Ana Costa', 'ana@greenfarm.com', '123456', 2),
('Lucas Lima', 'lucas@gmail.com', '123456', 1),
('Fernanda Rocha', 'fernanda@gmail.com', '123456', 1),
('Bruno Alves', 'bruno@gmail.com', '123456', 2),
('Juliana Martins', 'juliana@gmail.com', '123456', 2),
('Rafael Gomes', 'rafael@gmail.com', '123456', 3),
('Patricia Oliveira', 'patricia@gmail.com', '123456', 3);

CREATE TABLE fazenda (
    id_fazenda INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    municipio VARCHAR(45),
    cep VARCHAR(45)
);

INSERT INTO fazenda (nome, municipio, cep) VALUES
('Fazenda Boa Esperanca', 'Ribeirao Preto', '14000-000'),
('Fazenda Sao Jose', 'Campinas', '13000-000'),
('Fazenda Horizonte', 'Araraquara', '14800-000'),
('Fazenda Santa Rita', 'Piracicaba', '13400-000'),
('Fazenda Ouro Verde', 'Bauru', '17000-000');

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

INSERT INTO link VALUES
(1,1,'Administrador'),
(2,1,'Gerente'),
(3,2,'Administrador'),
(4,2,'Operador'),
(5,3,'Administrador'),
(6,3,'Gerente'),
(7,4,'Operador'),
(8,4,'Supervisor'),
(9,5,'Operador'),
(10,5,'Gerente'),
(11,1,'Analista'),
(12,3,'Supervisor');

CREATE TABLE plantacao (
    id_plantacao INT PRIMARY KEY AUTO_INCREMENT,
    data_plantio DATE,
    id_fazenda INT,
    CONSTRAINT fk_plantacao_fazenda FOREIGN KEY (id_fazenda)
        REFERENCES fazenda(id_fazenda)
);

INSERT INTO plantacao (data_plantio, id_fazenda) VALUES
('2025-01-15',1),
('2025-02-10',1),
('2025-03-05',2),
('2025-03-20',3),
('2025-04-12',4),
('2025-05-01',5),
('2025-05-15',5);

CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    status TINYINT(1),
    altura_instalacao DECIMAL(5,2),
    fkPlantacao INT,
    CONSTRAINT fk_sensor_plantacao FOREIGN KEY (fkPlantacao)
        REFERENCES plantacao(id_plantacao)
);

INSERT INTO sensor (status, altura_instalacao, fkPlantacao) VALUES
(1, 120.00, 1),
(1, 150.00, 1),
(1, 130.00, 2),
(0, 140.00, 2),
(1, 125.00, 3),
(1, 135.00, 3),
(1, 145.00, 4),
(0, 155.00, 4),
(1, 160.00, 5),
(1, 170.00, 5),
(1, 180.00, 6),
(0, 190.00, 6),
(1, 200.00, 7),
(1, 210.00, 7);

CREATE TABLE leitura_sensor (
    id_leitura_sensor INT PRIMARY KEY AUTO_INCREMENT,
    distancia_lida_cm DECIMAL(10,2),
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
    CONSTRAINT fk_leitura_sensor FOREIGN KEY (fkSensor)
        REFERENCES sensor(id_sensor)
);

INSERT INTO leitura_sensor
(distancia_lida_cm, data_hora, fkSensor)
VALUES

(34.5,'2026-06-01 08:00:00',1),
(36.2,'2026-06-01 12:00:00',1),
(35.8,'2026-06-01 16:00:00',1),
(41.2,'2026-06-01 08:00:00',2),
(42.5,'2026-06-01 12:00:00',2),
(43.0,'2026-06-01 16:00:00',2),
(28.3,'2026-06-01 08:00:00',3),
(29.1,'2026-06-01 12:00:00',3),
(30.4,'2026-06-01 16:00:00',3),
(55.7,'2026-06-01 08:00:00',4),
(56.1,'2026-06-01 12:00:00',4),
(22.4,'2026-06-01 08:00:00',5),
(24.3,'2026-06-01 12:00:00',5),
(25.0,'2026-06-01 16:00:00',5),
(18.6,'2026-06-01 08:00:00',6),
(19.1,'2026-06-01 12:00:00',6),
(20.5,'2026-06-01 16:00:00',6),
(62.7,'2026-06-01 08:00:00',7),
(61.5,'2026-06-01 12:00:00',7),
(70.2,'2026-06-01 08:00:00',8),
(68.9,'2026-06-01 12:00:00',8),
(31.7,'2026-06-01 08:00:00',9),
(32.8,'2026-06-01 12:00:00',9),
(38.4,'2026-06-01 08:00:00',10),
(39.6,'2026-06-01 12:00:00',10),
(44.2,'2026-06-01 08:00:00',11),
(45.1,'2026-06-01 12:00:00',11),
(58.8,'2026-06-01 08:00:00',12),
(57.9,'2026-06-01 12:00:00',12),
(27.6,'2026-06-01 08:00:00',13),
(28.9,'2026-06-01 12:00:00',13),
(15.3,'2026-06-01 08:00:00',14),
(16.7,'2026-06-01 12:00:00',14);

CREATE VIEW vw_ultima_leitura_sensor AS
SELECT
    s.id_sensor,
    p.id_plantacao,
    f.nome AS fazenda,
    ls.distancia_lida_cm,
    ls.data_hora
FROM sensor s
JOIN plantacao p
    ON s.fkPlantacao = p.id_plantacao
JOIN fazenda f
    ON p.id_fazenda = f.id_fazenda
JOIN leitura_sensor ls
    ON s.id_sensor = ls.fkSensor
WHERE ls.data_hora = (
    SELECT MAX(ls2.data_hora)
    FROM leitura_sensor ls2
    WHERE ls2.fkSensor = s.id_sensor
);

CREATE VIEW vw_media_leitura_plantacao AS
SELECT
    p.id_plantacao,
    f.nome AS fazenda,
    AVG(ls.distancia_lida_cm) AS media_distancia_cm
FROM plantacao p
JOIN fazenda f
    ON p.id_fazenda = f.id_fazenda
JOIN sensor s
    ON p.id_plantacao = s.fkPlantacao
JOIN leitura_sensor ls
    ON s.id_sensor = ls.fkSensor
GROUP BY
    p.id_plantacao,
    f.nome;
    
CREATE VIEW vw_sensores_por_fazenda AS
SELECT
    f.id_fazenda,
    f.nome AS fazenda,
    COUNT(s.id_sensor) AS total_sensores
FROM fazenda f
LEFT JOIN plantacao p
    ON f.id_fazenda = p.id_fazenda
LEFT JOIN sensor s
    ON p.id_plantacao = s.fkPlantacao
GROUP BY
    f.id_fazenda,
    f.nome;
    
CREATE VIEW vw_status_sensores AS
SELECT
    s.id_sensor,
    f.nome AS fazenda,
    p.id_plantacao,
    CASE
        WHEN s.status = 1 THEN 'Ativo'
        ELSE 'Inativo'
    END AS status_sensor,
    s.altura_instalacao
FROM sensor s
JOIN plantacao p
    ON s.fkPlantacao = p.id_plantacao
JOIN fazenda f
    ON p.id_fazenda = f.id_fazenda;

CREATE VIEW vw_dashboard_geral AS
SELECT
    f.nome AS fazenda,
    p.id_plantacao,
    s.id_sensor,
    s.status,
    ls.distancia_lida_cm,
    ls.data_hora
FROM fazenda f
JOIN plantacao p
    ON f.id_fazenda = p.id_fazenda
JOIN sensor s
    ON p.id_plantacao = s.fkPlantacao
JOIN leitura_sensor ls
    ON s.id_sensor = ls.fkSensor;



SELECT *FROM vw_ultima_leitura_sensor;
SELECT *FROM vw_media_leitura_plantacao;
SELECT *FROM vw_sensores_por_fazenda;
SELECT *FROM vw_status_sensores;
SELECT *FROM vw_dashboard_geral;