<p align="center">
  <strong>Wealthreader API</strong><br>
  Ejemplos de integración en múltiples lenguajes
</p>

<p align="center">
  <a href="https://www.wealthreader.com/api-reference/es/">Documentación</a> ·
  <a href="https://docs-es.wealthreader.com/">Guía del Widget</a> ·
  <a href="mailto:support@wealthreader.com">Contacto</a>
</p>

---

## Qué es Wealthreader

Wealthreader amplía la información que ofrecen las APIs regulatorias PSD2 con acceso en tiempo real a activos patrimoniales adicionales: carteras de inversión, tarjetas, seguros, préstamos, criptoactivos y más, en cualquier entidad del mundo.

La API está pensada para integraciones vía **widget Javascript**, donde las credenciales del banco se tokenizan y se usa un `token` para consultar datos.

## Inicio rápido

```
1. Solicita tu api_key  →  support@wealthreader.com
2. Registra tu dominio  →  POST /domains/
3. Integra el widget    →  docs-es.wealthreader.com
4. Consulta activos     →  POST /entities/
```

## Base URL

```
https://api.wealthreader.com/
```

## Autenticación

| Parámetro | Descripción |
|-----------|-------------|
| `api_key` | Identifica al cliente. Se envía en el body de cada petición. |
| `token`   | Identifica la credencial custodiada, generada por el widget. |

Los parámetros se envían como `application/x-www-form-urlencoded` en los endpoints core.

## Ejemplos por lenguaje

Todos los ejemplos llaman a `POST /entities/` para obtener activos financieros. Se encuentran en la carpeta [`examples/`](examples/).

| Lenguaje | Archivo | Requisitos |
|----------|---------|------------|
| cURL / Bash | [`wealthreader.sh`](examples/wealthreader.sh) | bash, curl |
| Python | [`wealthreader.py`](examples/wealthreader.py) | Python 3.7+, `requests` |
| JavaScript | [`wealthreader.js`](examples/wealthreader.js) | Node.js 18+ (fetch nativo) |
| PHP | [`wealthreader.php`](examples/wealthreader.php) | PHP 7.4+ con cURL |
| C# | [`wealthreader.cs`](examples/wealthreader.cs) | .NET 6+ |
| Java | [`WealthReader.java`](examples/WealthReader.java) | Java 11+ |
| Ruby | [`wealthreader.rb`](examples/wealthreader.rb) | Ruby 2.7+ |
| VBScript | [`wealthreader.vbs`](examples/wealthreader.vbs) | Windows (cscript) |

### Ejemplo rápido (cURL)

```bash
curl -s -X POST "https://api.wealthreader.com/entities/" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "api_key=TU_API_KEY&code=caixabank&token=TU_TOKEN&product_types=accounts,portfolios&date_from=2024-01-01"
```

### Ejemplo rápido (Python)

```python
import requests

response = requests.post("https://api.wealthreader.com/entities/", data={
    "api_key": "TU_API_KEY",
    "code": "caixabank",
    "token": "TU_TOKEN",
    "product_types": "accounts,portfolios",
    "date_from": "2024-01-01",
})
print(response.json())
```

## Referencia de endpoints

### Core

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| `POST` | `/entities/` | Obtiene activos financieros y composición de carteras |
| `POST` | `/tokens/` | Lista tokens asociados a una `api_key` |
| `POST` | `/tokens/revoke/` | Revoca un token |
| `POST` | `/tokens/reasign/` | Reasigna un token a otra `api_key` |
| `POST` | `/domains/` | Da de alta dominios y URL de callback |
| `GET`  | `/error-codes/` | Lista códigos de error |
| `GET`  | `/warning-codes/` | Lista códigos de warning |

### Avanzados

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| `GET`  | `/entities/` | Listado de entidades soportadas (`show_only_tested=1` en producción) |
| `POST` | `/verify/iban-ownership/` | Verifica titularidad de IBAN |
| `POST` | `/user/register/` | Registra usuarios |
| `POST` | `/user/check/` | Consulta estado y enlaces de acceso |
| `POST` | `/user/revoke/` | Da de baja usuarios |
| `POST` | `/batch/load/` | Carga conexiones en batch (requiere entorno dedicado) |
| `POST` | `/batch/fetch/statistics/` | Estadísticas de un batch |
| `POST` | `/batch/fetch/result/` | Resultado de una conexión del batch |

## Gestión de errores

Para una gestión correcta de reintentos, consulta los endpoints de códigos:

```bash
# Códigos de error en español
curl "https://api.wealthreader.com/error-codes/?lang=es"

# Códigos de warning
curl "https://api.wealthreader.com/warning-codes/?lang=es"
```

> **Importante:** No todos los errores deben tratarse igual. Un error de contraseña incorrecta no debe reintentarse con los mismos parámetros, pero un error de mantenimiento de la entidad sí puede reintentarse.

## Datos de prueba (Mock)

Para desarrollo y testing, usa los tokens mock en el parámetro `token`:

| Token | Comportamiento |
|-------|---------------|
| `MOCKDATA` | Respuesta OK con datos de ejemplo |
| `MOCKOTP` | Respuesta con desafío OTP |
| `MOCKLOGINKO` | Respuesta con error de login |

## Estructura del repositorio

```
API-for-banking-examples/
├── README.md
└── examples/
    ├── wealthreader.sh       # cURL / Bash
    ├── wealthreader.py       # Python
    ├── wealthreader.js       # Node.js
    ├── wealthreader.php      # PHP
    ├── wealthreader.cs       # C#
    ├── WealthReader.java     # Java
    ├── wealthreader.rb       # Ruby
    └── wealthreader.vbs      # VBScript
```

## Recursos

| Recurso | Enlace |
|---------|--------|
| API Reference | https://www.wealthreader.com/api-reference/es/ |
| Guía del Widget Javascript | https://docs-es.wealthreader.com/ |
| Contacto técnico | support@wealthreader.com |

---

<p align="center">
  <sub>¿Dudas sobre la integración? Solicita una sesión técnica con el equipo de Wealthreader.</sub>
</p>
