var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/dados/:idPlantacao", function (req, res) {
    dashboardController.buscarDados(req, res);
});

router.get("/dadosAdmin", function (req, res) {
    dashboardController.buscarDadosAdmin(req, res);
});

router.get("/dadosGrafico/:idSensor", function (req, res) {
    dashboardController.buscarDadosGrafico(req, res);
});

router.get("/tempo-real/:idSensor", function (req, res) {
    dashboardController.buscarMedidasTempoReal(req, res);
});

module.exports = router;
