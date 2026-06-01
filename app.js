
var ambiente_processo = 'desenvolvimento'; // Altere para 'producao' se for usar banco remoto
var caminho_env = ambiente_processo === 'producao' ? '.env' : '.env.dev';
require("dotenv").config({ path: caminho_env });

const express = require("express");
const cors = require("cors");
const path = require("path");
const { GoogleGenAI } = require("@google/genai");

const app = express();
const PORTA_APP = process.env.APP_PORT || 3333;
const HOST_APP = process.env.APP_HOST || "localhost";


const chatIA = new GoogleGenAI({ apiKey: process.env.MINHA_CHAVE });

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cors());
app.use(express.static(path.join(__dirname, "public")));


var indexRouter = require("./src/routes/index");
var usuarioRouter = require("./src/routes/usuarios");
var avisosRouter = require("./src/routes/avisos");
var medidasRouter = require("./src/routes/medidas");
var aquariosRouter = require("./src/routes/aquarios");
var empresasRouter = require("./src/routes/empresas");

app.use("/", indexRouter);
app.use("/usuarios", usuarioRouter);
app.use("/avisos", avisosRouter);
app.use("/medidas", medidasRouter);
app.use("/aquarios", aquariosRouter);
app.use("/empresas", empresasRouter);

app.post("/perguntar", async (req, res) => {
    const pergunta = req.body.pergunta;
    try {
        const resultado = await gerarResposta(pergunta);
        res.json({ resultado });
    } catch (error) {
        res.status(500).json({ error: 'Erro interno do servidor ao consultar a IA' });
    }
});

async function gerarResposta(mensagem) {
    try {
        const modeloIA = chatIA.models.generateContent({
            model: "gemini-2.5-flash",
            contents: `Em um parágrafo responda: ${mensagem}`
        });
        const resposta = (await modeloIA).text;
        const tokens = (await modeloIA).usageMetadata;

        console.log("\n[BobIA] Resposta gerada com sucesso!");
        console.log("Uso de Tokens:", tokens);
        return resposta;
    } catch (error) {
        console.error("[BobIA] Erro na IA:", error);
        throw error;
    }
}


app.listen(PORTA_APP, function () {
    console.log(`
    ##   ##  ######   #####             ####       ##     ######     ##              ##  ##    ####    ######  
    ##   ##  ##       ##  ##            ## ##     ####      ##      ####             ##  ##     ##         ##  
    ##   ##  ##       ##  ##            ##  ##   ##  ##     ##     ##  ##            ##  ##     ##        ##   
    ## # ##  ####     #####    ######   ##  ##   ######     ##     ######   ######   ##  ##     ##       ##    
    #######  ##       ##  ##            ##  ##   ##  ##     ##     ##  ##            ##  ##     ##      ##     
    ### ###  ##       ##  ##            ## ##    ##  ##     ##     ##  ##             ####      ##     ##      
    ##   ##  ######   #####             ####     ##  ##     ##     ##  ##              ##      ####    ######  



     ######                ###    #    
        #     #  ####  #####   #    # #   
        #     # #    # #    #  #   #   #  
        ######  #    # #####   #  #     # 
        #     # #    # #    #  #  ####### 
        #     # #    # #    #  #  #     # 
        ######   ####  #####  ### #     # 
    \n\n                             
    Servidor integrado (Site + BobIA) rodando com sucesso!
    Acesse o link para visualizar: http://${HOST_APP}:${PORTA_APP}
    
    Ambiente atual: .:${ambiente_processo}:.
    Se .:desenvolvimento:. você está se conectando ao banco local.
    Se .:producao:. você está se conectando ao banco remoto.
    `);
});
