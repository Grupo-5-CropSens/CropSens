var database = require("../database/config");

function buscarParametrosLavoura(idPlantacao) {
    var instrucao = `SELECT * FROM vwParametrosLavoura WHERE fkPlantacao = ${idPlantacao};`;
    return database.executar(instrucao);
}

function buscarDadosColheita(idPlantacao) {
    var instrucao = `SELECT * FROM vwDadosColheita WHERE fkPlantacao = ${idPlantacao};`;
    return database.executar(instrucao);
}

function buscarLeituras(idPlantacao) {
    var instrucao = `SELECT * FROM vwInstalacaoDistancia WHERE fkPlantacao = ${idPlantacao};`;
    return database.executar(instrucao);
}

function obterKpisAdmin() {
    var instrucao = `SELECT * FROM vwKpiAdmin;`;
    return database.executar(instrucao);
}

function obterGraficosAdmin() {
    var instrucaoSensoresPorFazenda = `SELECT * FROM vwGraficoAdmin;`;
    var instrucaoUsuariosPorEmpresa = `SELECT * FROM vwInstrucaoPorEmpresa;`;

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

function buscarDadosGrafico(idSensor) {
    var instrucao = `SELECT * FROM vwBuscarDadosGrafico WHERE id_sensor = ${idSensor};`;
    return database.executar(instrucao);
}

function buscarMedidasTempoReal(idSensor) {
    var instrucao = `SELECT * FROM vwBuscarDadosGrafico WHERE id_sensor = ${idSensor} LIMIT 1;`;
    return database.executar(instrucao);
}

module.exports = {
    buscarParametrosLavoura,
    buscarDadosColheita,
    buscarLeituras,
    obterKpisAdmin,
    obterGraficosAdmin,
    buscarDadosGrafico,
    buscarMedidasTempoReal
};
