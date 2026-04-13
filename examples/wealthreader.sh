#!/usr/bin/env bash
# Wealthreader API - Ejemplo en cURL / Bash
# Obtiene activos financieros de una entidad bancaria.

API_KEY="TU_API_KEY"
TOKEN="TU_TOKEN"
ENTITY="caixabank"

curl -s -X POST "https://api.wealthreader.com/entities/" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "api_key=${API_KEY}&code=${ENTITY}&token=${TOKEN}&product_types=accounts,portfolios&date_from=2024-01-01" \
  | python3 -m json.tool
