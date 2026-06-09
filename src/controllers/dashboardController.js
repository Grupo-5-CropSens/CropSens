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

            let formatado = {
                faseAtualDam:    respostaApi.parametros.fase_atual_dam,
                potencialMaximo: parseFloat(respostaApi.parametros.potencial_maximo_kgha),
                diasDAM:          [],
                produtividadeReal: [],
                perdaAcumulada:   [],
                percentualPerda:  [],
                custoSecagem:     [],
                custoTotalDam:    [],
                altura:           [],
                crescimento:      [],
                eficiencia:       [],
                leituras:         respostaApi.leituras
            };

            for (let row of respostaApi.dadosColheita) {
                formatado.diasDAM.push(row.dam_dias);
                formatado.produtividadeReal.push(parseFloat(row.produtividade_kgha));
                formatado.perdaAcumulada.push(parseFloat(row.perda_acumulada_kg));
                formatado.percentualPerda.push(parseFloat(row.percentual_perda));
                formatado.custoSecagem.push(parseFloat(row.custo_secagem));
                formatado.custoTotalDam.push(parseFloat(row.custo_total));
            }

            // Simulação de modelo de semente (curva de crescimento ideal)
            let crescimentoIdeal = [60, 80, 120, 169, 190, 224.6];

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

                let ideal = crescimentoIdeal[i] || crescimentoIdeal[crescimentoIdeal.length - 1];
                let ef = (alturaCm / ideal) * 100;
                formatado.eficiencia.push(parseFloat(ef.toFixed(1)));
            }

            // Campos resumo calculados pelo servidor — usados diretamente nos KPI cards do frontend
            let custoMinimoVal = formatado.custoTotalDam.length > 0 ? Math.min(...formatado.custoTotalDam) : 0;
            let indicePontoOtimo = formatado.custoTotalDam.indexOf(custoMinimoVal);

            formatado.custoMinimo     = parseFloat(custoMinimoVal.toFixed(2));
            formatado.damPontoOtimo   = formatado.diasDAM[indicePontoOtimo] || 0;
            formatado.faseAtualIndex  = formatado.diasDAM.indexOf(formatado.faseAtualDam);
            if (formatado.faseAtualIndex === -1) formatado.faseAtualIndex = 0;

            formatado.ultimaAltura     = parseFloat((formatado.altura[formatado.altura.length - 1] || 0).toFixed(1));
            formatado.ultimaEficiencia = parseFloat((formatado.eficiencia[formatado.eficiencia.length - 1] || 0).toFixed(1));

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

function buscarDadosGrafico(req, res) {
    var idSensor = req.params.idSensor;

    dashboardModel.buscarDadosGrafico(idSensor).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarMedidasTempoReal(req, res) {
    var idSensor = req.params.idSensor;

    dashboardModel.buscarMedidasTempoReal(idSensor).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas em tempo real.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    buscarDados,
    buscarDadosAdmin,
    buscarDadosGrafico,
    buscarMedidasTempoReal
};
