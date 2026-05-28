var database = require("../database/config");

function buscarParametrosLavoura(idPlantacao) {
    var instrucao = `SELECT fase_atual_dam, potencial_maximo_kgha FROM parametros_lavoura WHERE fkPlantacao = ${idPlantacao};`;
    return database.executar(instrucao);
}

function buscarDadosColheita(idPlantacao) {
    var instrucao = `SELECT dam_dias, produtividade_kgha, perda_acumulada_kg, percentual_perda, custo_secagem, custo_total FROM dados_colheita WHERE fkPlantacao = ${idPlantacao} ORDER BY dam_dias ASC;`;
    return database.executar(instrucao);
}

function buscarLeituras(idPlantacao) {
    var instrucao = `
        SELECT ls.data_hora, 
               (s.altura_instalacao * 100 - ls.distancia_lida_cm) AS altura
        FROM leitura_sensor ls
        JOIN sensor s ON ls.fkSensor = s.id
        WHERE s.fkPlantacao = ${idPlantacao}
        ORDER BY ls.data_hora ASC;
    `;
    return database.executar(instrucao);
}

module.exports = {
    buscarParametrosLavoura,
    buscarDadosColheita,
    buscarLeituras
};
