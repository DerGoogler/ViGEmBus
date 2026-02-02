Param(
    [Parameter(Mandatory=$true)]
    [string]$BuildVersion,
    [Parameter(Mandatory=$false)]
    [string]$Path = "./artifacts",
    [Parameter(Mandatory=$false)]
    [Switch]$NoSigning
) #end param

$signTool = "C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\signtool.exe"
$timestampUrl = "http://timestamp.digicert.com"
$certName = "Nefarius Software Solutions e.U."

# List of files to sign
$files = "`".\artifacts\disk1\*.cab`" "

if ($NoSigning -eq $false) {
    # sign with only one certificate
    Invoke-Expression "& `"$signTool`" sign /v /as /n `"$certName`" /tr $timestampUrl /fd sha256 /td sha256 $files"
}

# Print helper job names for sign portal
"ViGemBus x86 v$BuildVersion $(Get-Date -Format "dd.MM.yyyy")"
"ViGemBus x64 v$BuildVersion $(Get-Date -Format "dd.MM.yyyy")"
"ViGemBus ARM64 v$BuildVersion $(Get-Date -Format "dd.MM.yyyy")"
