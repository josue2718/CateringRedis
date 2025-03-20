const Redis = require("ioredis");
require("dotenv").config();
const fs = require("fs");

const redis = new Redis({
  host: process.env.REDIS_HOST,
  port: process.env.REDIS_PORT,
  password: process.env.REDIS_PASSWORD,
  tls: {},
});

async function obtenerDatosPorClave(prefijo, nombreEntidad) {
  try {
    const claves = await redis.keys(`${prefijo}:*`);

    if (claves.length === 0) {
      console.log(`No hay ${nombreEntidad} almacenados.`);
      return;
    }

    const datos = await Promise.all(claves.map((key) => redis.get(key)));
    const objetos = datos.map((data) => {
      try {
        // Intentamos parsear los datos
        const parsedData = JSON.parse(data);
        // Mostramos los datos convertidos
        return JSON.stringify(parsedData, null, 2);
      } catch (e) {
        // Si no se puede parsear, simplemente mostramos el valor sin modificación
        return data;
      }
    });

    // Mostrar todos los datos con una presentación legible
    console.log(`Todos los ${nombreEntidad}:`, objetos.join('\n'));
  } catch (error) {
    console.error(`Error al obtener todos los ${nombreEntidad}:`, error);
  }
}



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

(async () => {
  try {
   // await obtenerDatosPorClave("cliente", "clientes");
   //await obtenerDatosPorClave("propietario", "propietarios");
   await obtenerDatosPorClave("empresa", "empresas");
   //await obtenerDatosPorClave("menusempresa", "menús");
    //await obtenerDatosPorClave("descuento", "descuentos");
   //
   //await obtenerDatosPorClave("favoritos", "favoritos");
   // await obtenerDatosPorClave("reserva", "reservas");

  } catch (error) {
    console.error("Error en el proceso de respaldo:", error);
  } finally {
    await redis.quit();
    process.exit(0);
  }
})();
