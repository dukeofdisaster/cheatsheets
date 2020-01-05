function check_ssl($fqdn, $port) {
    $tcpsocket = New-Object Net.Sockets.TcpClient($fqdn, $port)
    $tcpstream = $tcpsocket.GetStream()
    $sslStream = New-Object Net.Security.SslStream($tcpstream, $false)
    $sslStream.AuthenticateAsClient($fqdn)
    $certinfo = New-Object security.cryptography.x509certificates.x509certificate2($sslStream.RemoteCertificate)
    # look at $tcpsocket.Client.RemoteEndPoint to see Server IP the client is using for connection
    $certinfo | fl
    $certinfo.Extensions | where {$_.Oid.FriendlyName -like 'subject alt*'} | `
      foreach { $_.Oid.FriendlyName; $_.Format($true) }
    $tcpsocket.Close() # Dispose() missing from older .NET, use Close()
}

$target = Read-Host -Prompt "[-]Enter fqdn of target server: "
function main() { check_ssl -fqdn $target -port 443 }
main

