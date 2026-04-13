// Wealthreader API - Ejemplo en C# (.NET 6+)
// Obtiene activos financieros de una entidad bancaria.

using System.Text.Json;

const string apiUrl = "https://api.wealthreader.com/entities/";

var payload = new Dictionary<string, string>
{
    ["api_key"] = "TU_API_KEY",
    ["code"] = "caixabank",
    ["token"] = "TU_TOKEN",
    ["product_types"] = "accounts,portfolios",
    ["date_from"] = "2024-01-01",
};

using var client = new HttpClient();
var response = await client.PostAsync(apiUrl, new FormUrlEncodedContent(payload));
response.EnsureSuccessStatusCode();

var json = await response.Content.ReadAsStringAsync();
using var doc = JsonDocument.Parse(json);

foreach (var entity in doc.RootElement.EnumerateArray())
{
    if (entity.GetProperty("success").GetBoolean())
    {
        var info = entity.GetProperty("payload").GetProperty("user_information");
        Console.WriteLine($"Titular: {info.GetProperty("name").GetString()}");

        foreach (var acc in entity.GetProperty("payload").GetProperty("accounts").EnumerateArray())
        {
            Console.WriteLine($"  Cuenta: {acc.GetProperty("code").GetString()}  Saldo: {acc.GetProperty("balance")} {acc.GetProperty("currency").GetString()}");
        }

        foreach (var port in entity.GetProperty("payload").GetProperty("portfolios").EnumerateArray())
        {
            Console.WriteLine($"  Cartera: {port.GetProperty("name").GetString()}  Valor: {port.GetProperty("total_value")} {port.GetProperty("currency").GetString()}");
        }
    }
    else
    {
        Console.WriteLine($"Error: {entity.GetProperty("message").GetString()}");
    }
}
