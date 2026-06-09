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

CREATE TABLE parametros_lavoura (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fase_atual_dam INT,
    potencial_maximo_kgha DECIMAL(10,2),
    fkPlantacao INT,
    FOREIGN KEY (fkPlantacao) REFERENCES plantacao(id_plantacao)
);

CREATE TABLE dados_colheita (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dam_dias INT,
    produtividade_kgha DECIMAL(10,2),
    perda_acumulada_kg DECIMAL(10,2),
    percentual_perda DECIMAL(5,2),
    custo_secagem DECIMAL(10,2),
    custo_total DECIMAL(10,2),
    fkPlantacao INT,
    FOREIGN KEY (fkPlantacao) REFERENCES plantacao(id_plantacao)
);

-- INSERTS REDUZIDOS PARA AMOSTRAGEM --

INSERT INTO empresa (nome) VALUES
('AgroTech Solutions'),
('GreenFarm LTDA');

INSERT INTO usuario (nome, email, senha, empresa_id_empresa) VALUES
('Danilo Silva', 'danilo@cropsens.com', '123456', 1),
('Carla Mendes', 'carla@cropsens.com', '123456', 1),
('Pedro Santos', 'pedro@greenfarm.com', '123456', 2),
('Fernanda Caramico', 'fernanda@gmail.com', '123456', 1);

INSERT INTO fazenda (nome, municipio, cep) VALUES
('Fazenda Boa Esperanca', 'Ribeirao Preto', '14000-000'),
('Fazenda Sao Jose', 'Campinas', '13000-000');

INSERT INTO link (id_usuario, id_fazenda, cargo) VALUES
(1, 1, 'Administrador'),
(2, 1, 'Operador'),
(3, 2, 'Gerente'),
(4, 1, 'Operador');

INSERT INTO plantacao (data_plantio, id_fazenda) VALUES
('2025-01-15', 1),
('2025-02-10', 1),
('2025-03-05', 2);

INSERT INTO sensor (status, altura_instalacao, fkPlantacao) VALUES
(1, 120.00, 1),
(1, 150.00, 1),
(0, 140.00, 2);

INSERT INTO leitura_sensor (distancia_lida_cm, data_hora, fkSensor) VALUES
(60, '2026-06-01 08:00:00', 1),
(46, '2026-06-08 08:00:00', 1),
(30, '2026-06-15 08:00:00', 1),

(75, '2026-06-01 08:00:00', 2),
(57, '2026-06-08 08:00:00', 2),
(38, '2026-06-15 08:00:00', 2);

INSERT INTO parametros_lavoura (fase_atual_dam, potencial_maximo_kgha, fkPlantacao) VALUES
(30, 9500.00, 1),
(20, 9000.00, 2);

INSERT INTO dados_colheita (dam_dias, produtividade_kgha, perda_acumulada_kg, percentual_perda, custo_secagem, custo_total, fkPlantacao) VALUES
(10, 9500.00, 0.00, 0.00, 1200.00, 1200.00, 1),
(20, 9500.00, 50.00, 0.53, 800.00, 850.00, 1),
(30, 9500.00, 100.00, 1.05, 0.00, 225.00, 1),

(10, 9000.00, 0.00, 0.00, 1100.00, 1100.00, 2),
(20, 9000.00, 40.00, 0.44, 750.00, 790.00, 2);

-- VIEWS MANTIDAS INTEGRALMENTE --

CREATE VIEW vwInstalacaoDistancia AS
SELECT
    ls.data_hora,
    s.id_sensor,
    s.fkPlantacao,
    s.altura_instalacao,
    ls.distancia_lida_cm AS distancia,
    (s.altura_instalacao - ls.distancia_lida_cm) AS altura_planta
FROM leitura_sensor ls
JOIN sensor s ON ls.fkSensor = s.id_sensor
ORDER BY ls.data_hora ASC;

CREATE VIEW vwGraficoAdmin AS
SELECT
    f.nome AS fazenda,
    COUNT(s.id_sensor) AS total,
    SUM(CASE WHEN s.status = 1 THEN 1 ELSE 0 END) AS ativos,
    SUM(CASE WHEN s.status = 0 THEN 1 ELSE 0 END) AS inativos
FROM fazenda f
LEFT JOIN plantacao p ON f.id_fazenda = p.id_fazenda
LEFT JOIN sensor s ON p.id_plantacao = s.fkPlantacao
GROUP BY f.id_fazenda, f.nome;

CREATE VIEW vwInstrucaoPorEmpresa AS
SELECT
    e.nome AS empresa,
    COUNT(u.id_usuario) AS total
FROM empresa e
LEFT JOIN usuario u ON e.id_empresa = u.empresa_id_empresa
GROUP BY e.id_empresa, e.nome;

CREATE VIEW vwUsuario AS
SELECT
    id_usuario AS id,
    nome,
    email,
    senha,
    (SELECT COUNT(*) FROM link WHERE id_usuario = usuario.id_usuario AND cargo = 'Administrador') AS isAdmin
FROM usuario;

CREATE VIEW vwBuscarDadosGrafico AS
SELECT
    id_leitura_sensor AS id,
    distancia_lida_cm AS distancia,
    altura_instalacao,
    id_sensor,
    DATE_FORMAT(data_hora, '%H:%i:%s') AS momento_grafico,
    fkSensor
FROM leitura_sensor
JOIN sensor ON fkSensor = id_sensor
ORDER BY id DESC;

CREATE VIEW vwParametrosLavoura AS
SELECT
    fkPlantacao,
    fase_atual_dam,
    potencial_maximo_kgha
FROM parametros_lavoura;

CREATE VIEW vwDadosColheita AS
SELECT
    fkPlantacao,
    dam_dias,
    produtividade_kgha,
    perda_acumulada_kg,
    percentual_perda,
    custo_secagem,
    custo_total
FROM dados_colheita
ORDER BY dam_dias ASC;

CREATE VIEW vwKpiAdmin AS
SELECT
    (SELECT COUNT(*) FROM usuario)                 AS totalUsuarios,
    (SELECT COUNT(*) FROM empresa)                 AS totalEmpresas,
    (SELECT COUNT(*) FROM fazenda)                 AS totalFazendas,
    (SELECT COUNT(*) FROM sensor)                  AS totalSensores,
    (SELECT COUNT(*) FROM sensor WHERE status = 1) AS sensoresAtivos,
    (SELECT COUNT(*) FROM sensor WHERE status = 0) AS sensoresInativos;
    
    