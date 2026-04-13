"""
Wealthreader API - Ejemplo en Python
Obtiene activos financieros de una entidad bancaria.
Requiere: pip install requests
"""

import requests

API_URL = "https://api.wealthreader.com/entities/"

payload = {
    "api_key": "TU_API_KEY",
    "code": "caixabank",
    "token": "TU_TOKEN",
    "product_types": "accounts,portfolios",
    "date_from": "2024-01-01",
}

response = requests.post(API_URL, data=payload)
response.raise_for_status()

data = response.json()
for entity in data:
    if entity.get("success"):
        info = entity["payload"].get("user_information", {})
        print(f"Titular: {info.get('name', 'N/A')}")

        for account in entity["payload"].get("accounts", []):
            print(f"  Cuenta: {account['code']}  Saldo: {account.get('balance', 'N/A')} {account.get('currency', '')}")

        for portfolio in entity["payload"].get("portfolios", []):
            print(f"  Cartera: {portfolio['name']}  Valor: {portfolio.get('total_value', 'N/A')} {portfolio.get('currency', '')}")
    else:
        print(f"Error: {entity.get('message', 'desconocido')}")
