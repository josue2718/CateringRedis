const Redis = require("ioredis");
require('dotenv').config();  // Esto cargará las variables de tu archivo .env

// Conectar a Redis con la contraseña y puerto correcto
const redis = new Redis({
  host: process.env.REDIS_HOST,  // Usando la variable de entorno REDIS_HOST
  port: process.env.REDIS_PORT,  // Usando la variable de entorno REDIS_PORT
  password: process.env.REDIS_PASSWORD,  // Reemplaza esto con tu contraseña de Redis
  tls: {}  // Esto es importante para conexiones seguras con SSL
});

async function obtenerCliente(clienteId) {
  // Construir la clave para el cliente
  const clienteKey = `cliente:${clienteId}`;

  try {
    // Obtener los datos del cliente almacenados como string en Redis
    const clienteData = await redis.get(clienteKey);  // Usamos .get ya que los datos están en formato String

    if (clienteData) {
      const cliente = JSON.parse(clienteData); // Deserializamos el JSON almacenado en Redis
      console.log("Cliente:", cliente);
    } else {
      console.log("No se encontró el cliente con ID:", clienteId);
    }
  } catch (error) {
    console.error("Error al obtener el cliente:", error);
  }
}

// Ejecución de la función para obtener un cliente con ID específico
(async () => {
  await obtenerCliente("3");  // Cambia el ID por el cliente que quieres obtener
})();
