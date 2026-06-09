const path = require("path");
require("dotenv").config({ path: "./.env.dev" });
process.env.AMBIENTE_PROCESSO = "desenvolvimento";

const config = require("./src/database/config");

async function check() {
    try {
        const tables = await config.executar("SHOW TABLES;");
        console.log("Tables/Views in DB:", tables.map(t => Object.values(t)[0]));
    } catch (err) {
        console.error("Query failed:", err);
    }
}

check();
