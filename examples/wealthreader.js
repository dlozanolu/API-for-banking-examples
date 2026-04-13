/**
 * Wealthreader API - Ejemplo en Node.js
 * Obtiene activos financieros de una entidad bancaria.
 * Compatible con Node.js 18+ (fetch nativo) o navegador.
 */

const API_URL = "https://api.wealthreader.com/entities/";

const payload = new URLSearchParams({
  api_key: "TU_API_KEY",
  code: "caixabank",
  token: "TU_TOKEN",
  product_types: "accounts,portfolios",
  date_from: "2024-01-01",
});

async function getEntities() {
  const response = await fetch(API_URL, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: payload.toString(),
  });

  if (!response.ok) {
    throw new Error(`HTTP ${response.status}: ${response.statusText}`);
  }

  const data = await response.json();

  for (const entity of data) {
    if (entity.success) {
      const info = entity.payload.user_information ?? {};
      console.log(`Titular: ${info.name ?? "N/A"}`);

      for (const acc of entity.payload.accounts ?? []) {
        console.log(`  Cuenta: ${acc.code}  Saldo: ${acc.balance ?? "N/A"} ${acc.currency ?? ""}`);
      }
      for (const port of entity.payload.portfolios ?? []) {
        console.log(`  Cartera: ${port.name}  Valor: ${port.total_value ?? "N/A"} ${port.currency ?? ""}`);
      }
    } else {
      console.error(`Error: ${entity.message ?? "desconocido"}`);
    }
  }
}

getEntities().catch(console.error);
