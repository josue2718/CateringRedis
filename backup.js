const Redis = require("ioredis");
require("dotenv").config();
const fs = require("fs");

const redis = new Redis({
  host: process.env.REDIS_HOST,
  port: process.env.REDIS_PORT,
  password: process.env.REDIS_PASSWORD,
  tls: {},
});



async function backupRedisData() {
  try {
    const claves = await redis.keys("*");
    if (claves.length === 0) {
      console.log("No hay datos almacenados en Redis.");
      return;
    }

    const data = {};
    const valores = await Promise.all(claves.map((key) => redis.get(key)));
    claves.forEach((key, index) => {
      data[key] = valores[index];
    });

    fs.writeFileSync("redis-backup.json", JSON.stringify(data, null, 2));
    console.log("Respaldo completado exitosamente.");
  } catch (err) {
    console.error("Error al realizar el respaldo:", err);
  }
}


// Función para cargar los datos de un archivo JSON en Redis
async function restoreRedisData() {
    try {
      // Leer el archivo de respaldo
      const data = JSON.parse(fs.readFileSync("redis-backup.json", "utf8"));
      
      // Cargar los datos en Redis
      for (const key in data) {
        await redis.set(key, data[key]);
      }
  
      console.log("Datos restaurados exitosamente en Redis.");
    } catch (err) {
      console.error("Error al restaurar los datos:", err);
    }
  }

  
(async () => {
  try {
    await backupRedisData()
    //await redis.flushall();
  } catch (error) {
    console.error("Error en el proceso de respaldo:", error);
  } finally {
    await redis.quit();
    process.exit(0);
  }
})();
