var usuarioModel = require("../models/usuarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else {
        usuarioModel.autenticar(email, senha)
            .then(function (resultado) {
                if (resultado.length >= 1) {
                    const emailUser = resultado[0].email || '';
                    // Determina perfil de acesso: admin se e-mail for do domínio @cropsens.com
                    const tipo = emailUser.endsWith('@cropsens.com') ? 'admin' : 'cliente';
                    res.json({
                        id: resultado[0].id,
                        nome: resultado[0].nome,
                        email: emailUser,
                        tipo: tipo,
                        idPlantacao: resultado[0].id_plantacao || 1
                    });
                } else if (resultado.length == 0) {
                    res.status(403).send("Email e/ou senha inválido(s)!");
                }
            })
            .catch(function (erro) {
                console.log("\nErro ao autenticar:", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            });
    }
}

function cadastrar(req, res) {
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else {
        usuarioModel.cadastrar(nome, email, senha)
            .then(function (resultado) {
                res.status(201).json(resultado);
            })
            .catch(function (erro) {
                console.log("\nErro ao cadastrar:", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            });
    }
}

module.exports = {
    autenticar,
    cadastrar
};