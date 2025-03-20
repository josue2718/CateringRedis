
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System.Threading.Tasks;
using System;
using Catering.Entity.Models.Clientes;
using Catering.Entity.Models.Propietarios;
using Catering.Entity.Models.Reservas;
using Catering.Entity.Models.MenusEmpresas;
using Catering.Entity.Models.Empresa;
using Catering.Entity.Models.Favoritos;

public class RedisService
{
    private readonly IDatabase _redisDb;

    public RedisService(IConfiguration configuration)
    {
        // Obtenemos la cadena de conexión de Redis desde el archivo appsettings.json
        var redisConnectionString = configuration.GetConnectionString("RedisConnection");

        if (string.IsNullOrEmpty(redisConnectionString))
        {
            throw new ArgumentNullException(nameof(redisConnectionString), "La cadena de conexión de Redis no está configurada correctamente.");
        }

        // Conectamos a Redis usando la cadena de conexión obtenida
        var redisConnection = ConnectionMultiplexer.Connect(redisConnectionString);
        _redisDb = redisConnection.GetDatabase();
    }

    public async Task SetClienteAsync(Cliente cliente)
    {
        if (cliente == null)
            throw new ArgumentNullException(nameof(cliente), "El cliente no puede ser nulo.");

        // Usamos el id_cliente como parte de la clave en Redis
        var key = $"cliente:{cliente.id_cliente}";

        // Serializamos el objeto cliente a formato JSON
        var clienteJson = JsonConvert.SerializeObject(cliente);

        // Almacenamos el cliente serializado en Redis
        await _redisDb.StringSetAsync(key, clienteJson);
    }

    public async Task SetPropietarioAsync(Propietario_Empresa propietarioEmpresa)
    {
        if (propietarioEmpresa == null)
            throw new ArgumentNullException(nameof(propietarioEmpresa), "El propietario no puede ser nulo.");

        // Usamos el id_cliente como parte de la clave en Redis
        var key = $"propietario:{propietarioEmpresa.id_propietario}";

        // Serializamos el objeto cliente a formato JSON
        var propietarioEmpresaJson = JsonConvert.SerializeObject(propietarioEmpresa);

        // Almacenamos el cliente serializado en Redis
        await _redisDb.StringSetAsync(key, propietarioEmpresaJson);
    }
public async Task SetEmpresaAsync(Empresas empresa)
{
    if (empresa == null)
        throw new ArgumentNullException(nameof(empresa), "la empresa e no puede ser nulo.");

    // Usamos el id_cliente como parte de la clave en Redis
    var key = $"empresa:{empresa.id_empresa}";

    // Serializamos el objeto cliente a formato JSON
    var empresaJson = JsonConvert.SerializeObject(empresa);

    // Almacenamos el cliente serializado en Redis
    await _redisDb.StringSetAsync(key, empresaJson);
}

    public async Task SetReservaAsync(Reserva reserva)
    {
        if (reserva == null)
            throw new ArgumentNullException(nameof(reserva)," la reserva no puede ser nulo.");

        // Usamos el id_cliente como parte de la clave en Redis
        var key = $"reserva:{reserva.id_reserva}";

        // Serializamos el objeto cliente a formato JSON
        var reservaJson = JsonConvert.SerializeObject(reserva);

        // Almacenamos el cliente serializado en Redis
        await _redisDb.StringSetAsync(key, reservaJson);
    }


    public async Task SetMenusEmpresaAsync(Menus_Empresas menus)
    {
        if (menus == null)
            throw new ArgumentNullException(nameof(menus), "El menu de la empresa no puede ser nulo.");

        // Usamos el id_cliente como parte de la clave en Redis
        var key = $"menusempresa:{menus.id_menu_empresa}";

        // Serializamos el objeto cliente a formato JSON
        var menusJson = JsonConvert.SerializeObject(menus);

        // Almacenamos el cliente serializado en Redis
        await _redisDb.StringSetAsync(key, menusJson);
    }

    public async Task SetDescuentosAsync(Descuentos descuento)
    {
        if (descuento == null)
            throw new ArgumentNullException(nameof(descuento), "El descuento no puede ser nulo.");

        // Usamos el id_cliente como parte de la clave en Redis
        var key = $"descuento:{descuento.id_descuento}";

        // Serializamos el objeto cliente a formato JSON
        var descuentoJson = JsonConvert.SerializeObject(descuento);

        // Almacenamos el cliente serializado en Redis
        await _redisDb.StringSetAsync(key, descuentoJson);
    }

    public async Task SetFavoritossAsync(Favorito favorito)
    {
        if (favorito == null)
            throw new ArgumentNullException(nameof(favorito), "El favorito no puede ser nulo.");

        // Usamos el id_cliente como parte de la clave en Redis
        var key = $"favoritos:{favorito.id_favorito}";

        // Serializamos el objeto cliente a formato JSON
        var favoritoJson = JsonConvert.SerializeObject(favorito);

        // Almacenamos el cliente serializado en Redis
        await _redisDb.StringSetAsync(key, favoritoJson);
    }
    public IDatabase GetDatabase()
    {
        return _redisDb;
    }
}
