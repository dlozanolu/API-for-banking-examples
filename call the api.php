<?php
$postString = "servicekey=<servicekey>&service=<bank name>&documentType=1&user=<username>&pass=<password>&pass2=&products=GLOBAL&startdate=01-01-2016&account_id=0";
$json = getJson($postString);

$array = json_decode($json,true);
print_r ($array);

function getJson($postString=''){
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
  curl_setopt($ch, CURLOPT_URL, 'https://www.afterbanks.com/endpoint/');
  curl_setopt($ch, CURLOPT_ENCODING, 'gzip,deflate'); 
  curl_setopt($ch, CURLOPT_POST, 1);
  curl_setopt($ch, CURLOPT_POSTFIELDS,$postString);
  $response = curl_exec($ch);
  curl_close($ch);
  
  return $response;
}
?>
