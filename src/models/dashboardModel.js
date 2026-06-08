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
         SELECT * FROM vwInstalacaoDistancia WHERE fkPlantacao = ${idPlantacao}
    `;
    return database.executar(instrucao);
    console.log(leituras)
}

function obterKpisAdmin() {
    var instrucao = `
        SELECT * FROM vwKpiAdmin;
            
    `;
    return database.executar(instrucao);
}

function obterGraficosAdmin() {
    var instrucaoSensoresPorFazenda = `
        SELECT * FROM vwGraficoAdmin;
    `;
    
    var instrucaoUsuariosPorEmpresa = `
        select * from vwInstrucaoPorEmpresa;
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
