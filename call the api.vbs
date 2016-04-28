sUrl = "https://www.afterbanks.com/endpoint/"
sRequest = “servicekey=<servicekey>&service=<bank name>&documentType=1&user=<username>&pass=<password>&pass2=&products=GLOBAL&startdate=01-01-2016&account_id=0"

wscript.echo HTTPPost (sUrl, sRequest)

Function HTTPPost(sUrl, sRequest)
  set oHTTP = CreateObject("Microsoft.XMLHTTP")
  oHTTP.open "POST", sUrl,false
  oHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  oHTTP.setRequestHeader "Content-Length", Len(sRequest)
  oHTTP.send sRequest
  HTTPPost = oHTTP.responseText
End Function
