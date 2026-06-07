var database = require("../database/config");

function buscarParametrosLavoura(idPlantacao) {
    var instrucao = `SELECT fase_atual_dam, potencial_maximo_kgha FROM parametros_lavoura WHERE fkPlantacao = ${idPlantacao};`;
    return database.executar(instrucao);
}

function buscarDadosColheita(idPlantacao) {
    var instrucao = `SELECT dam_dias, produtividade_kgha, perda_acumulada_kg, percentual_perda, custo_secagem, custo_total FROM dados_colheita WHERE fkPlantacao = ${idPlantacao} ORDER BY dam_dias ASC;`;
    return database.executar(instrucao);
}

//join aqui tava cagado
function buscarLeituras(idPlantacao) {
    var instrucao = `
        SELECT ls.data_hora, 
               (s.altura_instalacao * 100 - ls.distancia_lida_cm) AS altura
        FROM leitura_sensor ls
        JOIN sensor s ON ls.fkSensor = s.id_sensor
        WHERE s.fkPlantacao = ${idPlantacao}
        ORDER BY ls.data_hora ASC;
    `;
    return database.executar(instrucao);
}

function obterKpisAdmin() {
    var instrucao = `
        SELECT 
            (SELECT COUNT(*) FROM usuario) AS totalUsuarios,
            (SELECT COUNT(*) FROM empresa) AS totalEmpresas,
            (SELECT COUNT(*) FROM fazenda) AS totalFazendas,
            (SELECT COUNT(*) FROM sensor) AS totalSensores,
            (SELECT COUNT(*) FROM sensor WHERE status = 1) AS sensoresAtivos,
            (SELECT COUNT(*) FROM sensor WHERE status = 0) AS sensoresInativos,
            (SELECT COUNT(*) FROM plantacao) AS totalPlantacoes;
    `;
    return database.executar(instrucao);
}

function obterGraficosAdmin() {
    var instrucaoSensoresPorFazenda = `
        SELECT f.nome AS fazenda, 
               COUNT(s.id_sensor) AS total,
               SUM(CASE WHEN s.status = 1 THEN 1 ELSE 0 END) AS ativos,
               SUM(CASE WHEN s.status = 0 THEN 1 ELSE 0 END) AS inativos
        FROM fazenda f
        LEFT JOIN plantacao p ON f.id_fazenda = p.id_fazenda
        LEFT JOIN sensor s ON p.id_plantacao = s.fkPlantacao
        GROUP BY f.id_fazenda, f.nome;
    `;
    
    var instrucaoUsuariosPorEmpresa = `
        SELECT e.nome AS empresa, COUNT(u.id_usuario) AS total
        FROM empresa e
        LEFT JOIN usuario u ON e.id_empresa = u.empresa_id_empresa
        GROUP BY e.id_empresa, e.nome;
    `;

    return Promise.all([
        database.executar(instrucaoSensoresPorFazenda),
        database.executar(instrucaoUsuariosPorEmpresa)
    ]).then(function (results) {
        return {
            sensoresPorFazenda: results[0],
            usuariosPorEmpresa: results[1]
        };
    });
}

module.exports = {
    buscarParametrosLavoura,
    buscarDadosColheita,
    buscarLeituras,
    obterKpisAdmin,
    obterGraficosAdmin
};
