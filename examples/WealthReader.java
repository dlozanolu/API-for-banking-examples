// Wealthreader API - Ejemplo en Java 11+
// Obtiene activos financieros de una entidad bancaria.

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.stream.Collectors;

public class WealthReader {

    private static final String API_URL = "https://api.wealthreader.com/entities/";

    public static void main(String[] args) throws Exception {
        Map<String, String> params = Map.of(
            "api_key", "TU_API_KEY",
            "code", "caixabank",
            "token", "TU_TOKEN",
            "product_types", "accounts,portfolios",
            "date_from", "2024-01-01"
        );

        String body = params.entrySet().stream()
            .map(e -> URLEncoder.encode(e.getKey(), StandardCharsets.UTF_8) + "="
                     + URLEncoder.encode(e.getValue(), StandardCharsets.UTF_8))
            .collect(Collectors.joining("&"));

        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(API_URL))
            .header("Content-Type", "application/x-www-form-urlencoded")
            .POST(HttpRequest.BodyPublishers.ofString(body))
            .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() == 200) {
            System.out.println(response.body());
        } else {
            System.err.println("Error HTTP " + response.statusCode() + ": " + response.body());
        }
    }
}
