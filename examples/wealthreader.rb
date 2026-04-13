# Wealthreader API - Ejemplo en Ruby
# Obtiene activos financieros de una entidad bancaria.

require "net/http"
require "uri"
require "json"

API_URL = URI("https://api.wealthreader.com/entities/")

payload = {
  "api_key"       => "TU_API_KEY",
  "code"          => "caixabank",
  "token"         => "TU_TOKEN",
  "product_types" => "accounts,portfolios",
  "date_from"     => "2024-01-01",
}

response = Net::HTTP.post_form(API_URL, payload)

unless response.is_a?(Net::HTTPSuccess)
  abort "Error HTTP #{response.code}: #{response.body}"
end

data = JSON.parse(response.body)
data.each do |entity|
  if entity["success"]
    info = entity.dig("payload", "user_information") || {}
    puts "Titular: #{info['name'] || 'N/A'}"

    (entity.dig("payload", "accounts") || []).each do |acc|
      puts "  Cuenta: #{acc['code']}  Saldo: #{acc['balance'] || 'N/A'} #{acc['currency']}"
    end

    (entity.dig("payload", "portfolios") || []).each do |port|
      puts "  Cartera: #{port['name']}  Valor: #{port['total_value'] || 'N/A'} #{port['currency']}"
    end
  else
    puts "Error: #{entity['message'] || 'desconocido'}"
  end
end
