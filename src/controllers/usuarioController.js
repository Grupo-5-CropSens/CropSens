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
                console.log(`\nResultados encontrados: ${resultado.length}`);

                if (resultado.length == 1) {
                    let tipoUsuario = resultado[0].isAdmin > 0 ? 'admin' : 'usuario';
                        // Determina tipo de usuário (admin se email pertencer ao domínio cropsens)
                        const emailUser = resultado[0].email || '';
                        const tipo = emailUser.endsWith('@cropsens.com') ? 'admin' : 'cliente';
                        res.json({
                            id: resultado[0].id,
                            nome: resultado[0].nome,
                            email: emailUser,
                            tipo: tipo
                        });
                } else if (resultado.length == 0) {
                    res.status(403).send("Email e/ou senha inválido(s)!");
                } else {
                    res.status(403).send("Mais de um usuário encontrado!");
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