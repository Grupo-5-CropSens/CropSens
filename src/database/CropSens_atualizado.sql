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
	(2,1,'Administrador'),
	(3,2,'Gerente'),
	(4,2,'Operador'),
	(5,3,'Gerente'),
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

-- Semana 1
(60,'2026-06-01 08:00:00',1),

-- Semana 2
(45,'2026-06-08 08:00:00',1),

-- Semana 3
(30,'2026-06-15 08:00:00',1),

-- Semana 4
(20,'2026-06-22 08:00:00',1),

-- Semana 5
(12,'2026-06-29 08:00:00',1),

-- Semana 6
(5,'2026-07-06 08:00:00',1);

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

	-- Inserções de exemplo que ta tudo errado
	INSERT INTO parametros_lavoura 
(fase_atual_dam, potencial_maximo_kgha, fkPlantacao)
VALUES
(30, 10000.00, 1);

INSERT INTO dados_colheita
(dam_dias, produtividade_kgha, perda_acumulada_kg, percentual_perda, custo_secagem, custo_total, fkPlantacao)
VALUES
(0, 10000.00,    0.00,  0.00, 1200.00, 1200.00, 1),
(10, 9950.00,   50.00,  0.50,  700.00,  725.00, 1),
(20, 9850.00,  150.00,  1.50,  300.00,  375.00, 1),
(30, 9700.00,  300.00,  3.00,    0.00,  150.00, 1), 
(40, 9300.00,  700.00,  7.00,    0.00,  350.00, 1),
(50, 8700.00, 1300.00, 13.00,    0.00,  650.00, 1);

        
        
	SELECT * FROM usuario;
    
    
       SELECT ls.data_hora, 
               (s.altura_instalacao * 100 - ls.distancia_lida_cm) AS altura
        FROM leitura_sensor ls
        JOIN sensor s ON ls.fkSensor = s.id_sensor
        WHERE s.fkPlantacao = 1
        ORDER BY ls.data_hora ASC;
        
        SELECT ls.data_hora,
       s.altura_instalacao - ls.distancia_lida_cm AS altura_planta
FROM leitura_sensor ls
JOIN sensor s ON ls.fkSensor = s.id_sensor
WHERE s.fkPlantacao = 1
ORDER BY ls.data_hora;

SELECT * FROM sensor;



CREATE VIEW vwInstalacaoDistancia AS 
SELECT ls.data_hora,
		fkPlantacao,
            s.altura_instalacao - ls.distancia_lida_cm AS altura_planta
        FROM leitura_sensor ls
        JOIN sensor s ON ls.fkSensor = s.id_sensor
        ORDER BY ls.data_hora;
        
        SELECT * FROM vwInstalacaoDistancia WHERE fkPlantacao = 1;
        
  CREATE VIEW vwKpiAdmin AS
SELECT
    COUNT(*) AS totalUsuarios,
    (SELECT COUNT(*) FROM empresa) AS totalEmpresas,
    (SELECT COUNT(*) FROM fazenda) AS totalFazendas,
    (SELECT COUNT(*) FROM sensor) AS totalSensores,
    (SELECT COUNT(*) FROM sensor WHERE status = 1) AS sensoresAtivos,
    (SELECT COUNT(*) FROM sensor WHERE status = 0) AS sensoresInativos,
    (SELECT COUNT(*) FROM plantacao) AS totalPlantacoes
FROM usuario;
            
            SELECT * FROM vwKpiAdmin;
            
            
            CREATE VIEW vwGraficoAdmin AS
              SELECT f.nome AS fazenda, 
               COUNT(s.id_sensor) AS total,
               SUM(CASE WHEN s.status = 1 THEN 1 ELSE 0 END) AS ativos,
               SUM(CASE WHEN s.status = 0 THEN 1 ELSE 0 END) AS inativos
        FROM fazenda f
        LEFT JOIN plantacao p ON f.id_fazenda = p.id_fazenda
        LEFT JOIN sensor s ON p.id_plantacao = s.fkPlantacao
        GROUP BY f.id_fazenda, f.nome;
        
        SELECT * FROM vwGraficoAdmin;
        
        CREATE VIEW vwInstrucaoPorEmpresa AS
                SELECT e.nome AS empresa, COUNT(u.id_usuario) AS total
        FROM empresa e
        LEFT JOIN usuario u ON e.id_empresa = u.empresa_id_empresa
        GROUP BY e.id_empresa, e.nome;
        
        select * from vwInstrucaoPorEmpresa;
        
        CREATE VIEW vwUsuario AS
        SELECT id_usuario AS id, nome, email, senha,
               (SELECT COUNT(*) FROM link WHERE id_usuario = usuario.id_usuario AND cargo = 'Administrador') AS isAdmin 
        FROM usuario;
        
        SELECT * FROM vwUsuario;
        
        
        SELECT * FROM parametros_lavoura;
        
    -- DROP VIEW vwKpiAdmin;
      --  DROP VIEW vwUsuario;
       -- DROP DATABASE cropsens;
        
        
	
            