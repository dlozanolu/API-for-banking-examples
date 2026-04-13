<?php
$payload = [
  "api_key" => "TU_API_KEY",
  "code" => "caixabank",
  "token" => "TU_TOKEN",
  "product_types" => "accounts,portfolios",
  "date_from" => "2024-01-01",
];

$json = callWealthreader($payload);
$array = json_decode($json, true);
print_r($array);

function callWealthreader(array $payload): string {
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
  curl_setopt($ch, CURLOPT_URL, "https://api.wealthreader.com/entities/");
  curl_setopt($ch, CURLOPT_POST, true);
  curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($payload));
  curl_setopt($ch, CURLOPT_HTTPHEADER, ["Content-Type: application/x-www-form-urlencoded"]);

  $response = curl_exec($ch);
  if ($response === false) {
    $error = curl_error($ch);
    curl_close($ch);
    throw new RuntimeException("Error cURL: " . $error);
  }

  curl_close($ch);
  return $response;
}
?>
