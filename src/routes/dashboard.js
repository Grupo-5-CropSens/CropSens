var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/dados/:idPlantacao", function (req, res) {
    dashboardController.buscarDados(req, res);
});

module.exports = router;
