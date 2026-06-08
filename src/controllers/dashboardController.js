var dashboardModel = require("../models/dashboardModel");

function buscarDados(req, res) {
    var idPlantacao = req.params.idPlantacao;

    if (idPlantacao == undefined) {
        res.status(400).send("Seu idPlantacao está undefined!");
        return;
    }

    let respostaApi = {};

    dashboardModel.buscarParametrosLavoura(idPlantacao)
        .then(function (resultadoParametros) {
            if (resultadoParametros.length > 0) {
                respostaApi.parametros = resultadoParametros[0];
                return dashboardModel.buscarDadosColheita(idPlantacao);
            } else {
                res.status(204).send("Nenhum parâmetro encontrado!");
                throw new Error("Parâmetros não encontrados");
            }
        })
        .then(function (resultadoColheita) {
            respostaApi.dadosColheita = resultadoColheita;
            return dashboardModel.buscarLeituras(idPlantacao);
        })
        .then(function (resultadoLeituras) {
            respostaApi.leituras = resultadoLeituras;
            
            // Format arrays for frontend
            let formatado = {
                faseAtualDam: respostaApi.parametros.fase_atual_dam,
                potencialMaximo: parseFloat(respostaApi.parametros.potencial_maximo_kgha),
                diasDAM: [],
                produtividadeReal: [],
                perdaAcumulada: [],
                percentualPerda: [],
                custoSecagem: [],
                custoTotalDam: [],
                altura: [],
                crescimento: [],
                eficiencia: []
            };

            for (let row of respostaApi.dadosColheita) {
                formatado.diasDAM.push(row.dam_dias);
                formatado.produtividadeReal.push(parseFloat(row.produtividade_kgha));
                formatado.perdaAcumulada.push(parseFloat(row.perda_acumulada_kg));
                formatado.percentualPerda.push(parseFloat(row.percentual_perda));
                formatado.custoSecagem.push(parseFloat(row.custo_secagem));
                formatado.custoTotalDam.push(parseFloat(row.custo_total));
            }

            // Calculate height and efficiency based on readings
            let crescimentoIdeal = [60, 80, 120, 169, 190, 224.6]; // Simulação de modelo de semente

            for (let i = 0; i < respostaApi.leituras.length; i++) {
                let alturaCm = parseFloat(respostaApi.leituras[i].altura_planta);
                formatado.altura.push(alturaCm);
                
                // Crescimento semana a semana (percentual em relação à anterior)
                if (i === 0) {
                    formatado.crescimento.push(null);
                } else {
                    let calc = (alturaCm - formatado.altura[i - 1]) / formatado.altura[i - 1] * 100;
                    formatado.crescimento.push(Number(calc.toFixed(1)));
                }

                // Eficiência em relação à curva ideal
                let ideal = crescimentoIdeal[i] || crescimentoIdeal[crescimentoIdeal.length - 1];
                let ef = (alturaCm / ideal) * 100;
                formatado.eficiencia.push(parseFloat(ef.toFixed(1)));
            }

            res.json(formatado);
        })
        .catch(function (erro) {
            if (erro.message !== "Parâmetros não encontrados") {
                console.log(erro);
                console.log("Houve um erro ao buscar os dados do dashboard.", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        });
}

function buscarDadosAdmin(req, res) {
    Promise.all([
        dashboardModel.obterKpisAdmin(),
        dashboardModel.obterGraficosAdmin()
    ]).then(function (resultados) {
        let kpis = resultados[0][0];
        let graficos = resultados[1];

        res.json({
            kpis: kpis,
            graficos: {
                sensoresPorFazenda: graficos.sensoresPorFazenda,
                usuariosPorEmpresa: graficos.usuariosPorEmpresa
            }
        });
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage || erro.message);
    });
}

module.exports = {
    buscarDados,
    buscarDadosAdmin
};
