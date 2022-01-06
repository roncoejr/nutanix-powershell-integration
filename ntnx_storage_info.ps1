# /* add-type @"
# using System.Net;
# using System.Security.Cryptography.X509Certificates;
# public class TrustAllCertsPolicy : ICertificatePolicy {
#    public bool CheckValidationResult(
#        ServicePoint srvPoint, X509Certificate certificate,
#        WebRequest request, int certificateProblem) {
#            return true;
#        }
# }
#"@
# [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
#*/

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12


$PEURI = "https://...:9440"
$APIEND = "/PrismGateway/services/rest/v2.0/storage_containers"
$pc_username = ""
$pc_password = ""
$s_pc_password = ConvertTo-SecureString -String $pc_password -AsPlainText -Force
$PC_CREDS = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $pc_username, $s_pc_password

# $PC_CREDS = ""

# $PC_CREDS

try { $ContainerResponse = Invoke-RestMethod -Uri $PEURI$APIEND -SkipCertificateCheck -Authentication Basic -Credential $PC_CREDS -Method GET} catch { $e = $_.Exception; $msg = $e.Message; $depth = ">"; while ($e.InnerException) { $e = $e.InnerException; $msg += "`n$depth $($e.Message)"; $depth += ">"} $msg }


# try { $ContainerResponse = Invoke-RestMethod -Headers @{Authorization=("Basic {0}" -f $PC_CREDS)} -Uri $PEURI$APIEND -SkipCertificateCheck -Method GET} catch { $e = $_.Exception; $msg = $e.Message; $depth = ">"; while ($e.InnerException) { $e = $e.InnerException; $msg += "`n$depth $($e.Message)"; $depth += ">"} $msg }



