<#
    .NOTES
        Powershell script to generate 256-bit AES encryption key and Password file.
    
    Prerequisites:
        Modify the $Password variable with the BIOS Setup password then run the script to generate the Password.txt file and AES key.
#>

$KeyFile = "AES.key"
$Key = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
$Key | out-file $KeyFile

$File = "Password.txt"
$Key = Get-Content $KeyFile
$Password = "P@ssword1" | ConvertTo-SecureString -AsPlainText -Force
$Password | ConvertFrom-SecureString -key $key | Out-File $File