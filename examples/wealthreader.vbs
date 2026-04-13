sUrl = "https://api.wealthreader.com/entities/"
sRequest = "api_key=TU_API_KEY&code=caixabank&token=TU_TOKEN&product_types=accounts,portfolios&date_from=2024-01-01"

WScript.Echo HTTPPost(sUrl, sRequest)

Function HTTPPost(sUrl, sRequest)
  Set oHTTP = CreateObject("MSXML2.XMLHTTP")
  oHTTP.open "POST", sUrl, False
  oHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  oHTTP.send sRequest
  HTTPPost = oHTTP.responseText
End Function
