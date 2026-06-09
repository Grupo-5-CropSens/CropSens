var database = require("../database/config");

function autenticar(email, senha) {
    // Busca o usuário e já traz o id_plantacao da sua fazenda via tabela link → plantacao
    var instrucaoSql = `
        SELECT 
            u.id_usuario AS id,
            u.nome,
            u.email,
            u.senha,
            p.id_plantacao
        FROM usuario u
        LEFT JOIN link l ON l.id_usuario = u.id_usuario
        LEFT JOIN plantacao p ON p.id_fazenda = l.id_fazenda
        WHERE u.email = '${email}' AND u.senha = '${senha}'
        LIMIT 1;
    `;
    return database.executar(instrucaoSql);
}

function cadastrar(nome, email, senha) {
    var instrucaoSql = `
        INSERT INTO usuario (nome, email, senha) 
        VALUES ('${nome}', '${email}', '${senha}');
    `;
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar
};