var express = require("express");
var router = express.Router();
var path = require("path");

router.get("/", function (req, res) {
    // Aponta para dentro da pasta html onde está o seu index
    res.sendFile(path.join(__dirname, "../../public/index.html"));
});

module.exports = router;