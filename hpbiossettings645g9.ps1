<#
.DESCRIPTION
	Powershell script which uses the HP Client Management Script Library (CMSL) to enforce BIOS settings.

    .Author(s):
        Sabir Ali - (PS-CS), HP Inc.
        Personal Blog: www.techuisitive.com

        Michelle Mejia - PC Delivery Tower, HP Inc.

.Prerequisites:
	The script requires HP CMSL installed from: https://www.hp.com/us-en/solutions/client-management-solutions/download.html

.NOTES
	changelog:
	23-04-28 - deboodtw - v1.0.8 Modified script for Workspace ONE UEM
#>

#=============================================================
# Parameters
#=============================================================
$version = "1.0.8"

#replace with your company name
$CompanyName = "CompanyName"

$logpath = "C:\ProgramData\AirWatch\UnifiedAgent\Logs"
$logfile = "C:\ProgramData\AirWatch\UnifiedAgent\Logs\bios.log"
$regTagPath = "HKLM:\SOFTWARE\$CompanyName\BIOSSettings"

#=============================================================
# Create Log Path
#=============================================================
if(-not (Test-Path $logpath)){
    New-Item -ItemType Directory -Path $logpath -Force
}
function Write-Log {
    param($msg)
    "$(Get-Date -Format G) :$msg" | Out-File -FilePath $logfile -Append -Force
}

#=============================================================
# Get BIOS Setup Password from file
#=============================================================

function Get-BIOSPassword {
    $KeyFile = "AES.key"
    $PasswordFile = "Password.txt"
    $key = Get-Content $KeyFile
    $securestring = Get-Content $PasswordFile | ConvertTo-SecureString -Key $key

    $decrypted = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securestring)
    $clearpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($decrypted)

	return $clearpassword
}

#=============================================================
# Suspend Bitlocker
#=============================================================

function Get-Bitlocker-Status {
    try {
        $Output = Get-BitlockerVolume -MountPoint "C:" | Select-Object -ExpandProperty ProtectionStatus
        if ($Output -eq "Off") {
            Write-Log "Bitlocker encryption is not enabled."
        }
        else {
            Write-Log "Bitlocker encryption is enabled, suspending Bitlocker."
            Suspend-BitLocker -MountPoint "C:" -RebootCount 1 | Out-Null
        }
    }
    catch {
        Write-Log $_.Exception.Message

        $ErrorMessage = $_.Exception.Message
        $ExitCode = 343
        Add-RegistryCode -ExitCode $ExitCode -ErrorMessage $ErrorMessage
        Add-RegistryHistory
        Exit 343
    }
}

#=============================================================
# Configure BIOS Setup Password
#=============================================================
#function to replace an old, insecure password with a new, more complex one.
function Set-BIOSPassword{
	if (Get-HPBIOSSetupPasswordIsSet) {
		#overwrite legacy SCCM password with new complex password
		Set-HPBIOSSetupPassword -Password 'abc123' -NewPassword $BIOSpassword -ErrorAction SilentlyContinue
	}
	else {
		#for new, out of the box devices
		Set-HPBIOSSetupPassword -NewPassword $BIOSpassword
	}
}

#=============================================================
# Set BIOS settings
#=============================================================

# Set Secure Boot to Enable
function Set-SecureBoot {
	if ((Get-HPBIOSSettingValue "Secure Boot") -ne "Enable") {
		Write-Log "Setting Secure Boot to Enable."
		Set-HPBIOSSettingValue -Name "Secure Boot" -Value "Enable" -Password $BIOSpassword
	}
	else {
		Write-Log "Secure Boot is already set to Enable."
	}
}

# Set Fast Boot to Enable
function Set-FastBoot {
	if ((Get-HPBIOSSettingValue "Fast Boot") -ne "Enable" ) {
		Write-Log "Setting Fast Boot to Enable."
		Set-HPBIOSSettingValue -Name "Fast Boot" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Fast Boot is already Enabled."
	}
}

# Set Network (PXE) Boot to Enable
function Set-PXEBoot {
	if ((Get-HPBIOSSettingValue "Network (PXE) Boot") -ne "Enable" ) {
		Write-Log "Setting Network (PXE) Boot to Enable."
		Set-HPBIOSSettingValue -Name "Network (PXE) Boot" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Network (PXE) Boot is already set to Enable."
	}
}

# Set UEFI Boot Order to HDD:M.2:1,HDD:USB:1,NETWORK IPV4:EMBEDDED:1,NETWORK IPV6:EMBEDDED:1,NETWORK IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1
function Set-BootOrder {
	if ((Get-HPBIOSSettingValue "UEFI Boot Order") -ne "HDD:M.2:1,HDD:USB:1,NETWORK IPV4:EMBEDDED:1,NETWORK IPV6:EMBEDDED:1,NETWORK IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1" ) {
		Write-Log "Setting UEFI Boot Order to HDD:M.2:1,HDD:USB:1,NETWORK IPV4:EMBEDDED:1,NETWORK IPV6:EMBEDDED:1,NETWORK IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1"
		Set-HPBIOSSettingValue -Name "UEFI Boot Order" -Value "HDD:M.2:1,HDD:USB:1,NETWORK IPV4:EMBEDDED:1,NETWORK IPV6:EMBEDDED:1,NETWORK IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1" -password $BIOSpassword
	}
	else {
		Write-Log "UEFI Boot Order is already set to HDD:M.2:1,HDD:USB:1,NETWORK IPV4:EMBEDDED:1,NETWORK IPV6:EMBEDDED:1,NETWORK IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1"
	}
}

# Set Enable MS UEFI CA key to Yes
function Set-UefiCaKey {
	if ((Get-HPBIOSSettingValue "Enable MS UEFI CA key") -ne "Yes" ) {
		Write-Log "Setting Enable MS UEFI CA key to Yes."
		Set-HPBIOSSettingValue -Name "Enable MS UEFI CA key" -Value "Yes" -password $BIOSpassword
	}
	else {
		Write-Log "Enable MS UEFI CA key is already set to Yes."
	}
}

# Set Sure Start Secure Boot Keys Protection to Enable
function Set-SecureBootKeysProtection {
	if ((Get-HPBIOSSettingValue "Sure Start Secure Boot Keys Protection") -ne "Enable" ) {
		Write-Log "Setting Sure Start Secure Boot Keys Protection to Enable."
		Set-HPBIOSSettingValue -Name "Sure Start Secure Boot Keys Protection" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Sure Start Secure Boot Keys Protection is already set to Enable."
	}
}

# Set SVM CPU Virtualization to Enable
function Set-SVMCPUVirtualization {
	if ((Get-HPBIOSSettingValue "SVM CPU Virtualization") -ne "Enable" ) {
		Write-Log "Setting SVM CPU Virtualization to Enable."
		Set-HPBIOSSettingValue -Name "SVM CPU Virtualization" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "SVM CPU Virtualization is already Enabled."
	}
}

# Set Wake On LAN to Boot to Hard Drive
function Set-WoL {
	if ((Get-HPBIOSSettingValue "Wake On LAN") -ne "Boot to Hard Drive" ) {
		Write-Log "Setting Wake On LAN to Boot to Hard Drive."
		Set-HPBIOSSettingValue -Name "Wake On LAN" -Value "Boot to Hard Drive" -password $BIOSpassword
	}
	else {
		Write-Log "Wake On LAN is already set to Boot to Hard Drive."
	}
}

# Set LAN / WLAN Auto Switching to Enable
function Set-LanWlanSwitching {
	if ((Get-HPBIOSSettingValue "LAN / WLAN Auto Switching") -ne "Enable" ) {
		Write-Log "Setting LAN / WLAN Auto Switching to Enable."
		Set-HPBIOSSettingValue -Name "LAN / WLAN Auto Switching" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "LAN / WLAN Auto Switching is already Enabled."
	}
}

# Set Wireless Network Device (WLAN) to Enable
function Set-WlanDevice {
	if ((Get-HPBIOSSettingValue "Wireless Network Device (WLAN)") -ne "Enable" ) {
		Write-Log "Setting Wireless Network Device (WLAN) to Enable."
		Set-HPBIOSSettingValue -Name "Wireless Network Device (WLAN)" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Wireless Network Device (WLAN) is already Enabled."
	}
}

# Set Bluetooth to Enable
function Set-Bluetooth {
	if ((Get-HPBIOSSettingValue "Bluetooth") -ne "Enable" ) {
		Write-Log "Setting Bluetooth to Enable."
		Set-HPBIOSSettingValue -Name "Bluetooth" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Bluetooth is already Enabled."
	}
}

# Set TPM State to Enable
function Set-TpmState {
	if ((Get-HPBIOSSettingValue "TPM State") -ne "Enable" ) {
		Write-Log "Setting TPM State to Enable."
		Set-HPBIOSSettingValue -Name "TPM State" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "TPM State is already Enabled."
	}
}

# Set TPM Device to Available
function Set-TpmDevice {
	if ((Get-HPBIOSSettingValue "TPM Device") -ne "Available" ) {
		Write-Log "Setting TPM Device to Available."
		Set-HPBIOSSettingValue -Name "TPM Device" -Value "Available" -password $BIOSpassword
	}
	else {
		Write-Log "TPM Device is already Available."
	}
}

# Set TPM Activation Policy to No prompts
function Set-TpmActivationPolicy {
	if ((Get-HPBIOSSettingValue "TPM Activation Policy") -ne "No prompts" ) {
		Write-Log "Setting TPM Activation Policy to No prompts."
		Set-HPBIOSSettingValue -Name "TPM Activation Policy" -Value "No prompts" -password $BIOSpassword
	}
	else {
		Write-Log "TPM Activation Policy is already set to No prompts."
	}
}

# Set Integrated Camera to Enable
function Set-IntegratedCamera {
	if ((Get-HPBIOSSettingValue "Integrated Camera") -ne "Enable" ) {
		Write-Log "Setting Integrated Camera to Enable."
		Set-HPBIOSSettingValue -Name "Integrated Camera" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Integrated Camera is already Enabled."
	}
}

# Set Fingerprint Device to Enable
function Set-Fingerprint {
	if ((Get-HPBIOSSettingValue "Fingerprint Device") -ne "Enable" ) {
		Write-Log "Setting Fingerprint Device to Enable."
		Set-HPBIOSSettingValue -Name "Fingerprint Device" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Fingerprint Device is already Enabled."
	}
}

# Set USB Type-C Connector System Software Interface (UCSI) to Enable
function Set-UCSI {
	if ((Get-HPBIOSSettingValue "USB Type-C Connector System Software Interface (UCSI)") -ne "Enable" ) {
		Write-Log "Setting USB Type-C Connector System Software Interface (UCSI) to Enable."
		Set-HPBIOSSettingValue -Name "USB Type-C Connector System Software Interface (UCSI)" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "USB Type-C Connector System Software Interface (UCSI) is already Enabled."
	}
}

# Set Battery Health Manager to Maximize my battery health
function Set-BatteryHealthManager {
	if ((Get-HPBIOSSettingValue "Battery Health Manager") -ne "Maximize my battery health" ) {
		Write-Log "Setting Battery Health Manager to Maximize my battery health."
		Set-HPBIOSSettingValue -Name "Battery Health Manager" -Value "Maximize my battery health" -password $BIOSpassword
	}
	else {
		Write-Log "Battery Health Manager is already set to Maximize my battery health."
	}
}
# Set Smart Card to Enable
function Set-SmartCard {
	if ((Get-HPBIOSSettingValue "Smart Card") -ne "Enable" ) {
		Write-Log "Setting Smart Card to Enable."
		Set-HPBIOSSettingValue -Name "Smart Card" -Value "Enable" -password $BIOSpassword  
	}
	else {
		Write-Log "Smart Card is already set to Enable."
	}
}

#=============================================================
# List of Bios Settings to Configure
#=============================================================

function Set-BIOSSettings {
    try {
            Write-Log "Configuring settings with BIOS password."

			Set-SecureBoot
			Set-FastBoot
			Set-PXEBoot
			Set-BootOrder
			Set-UefiCaKey
			Set-SecureBootKeysProtection
			Set-SVMCPUVirtualization
			Set-WoL
			Set-LanWlanSwitching
			Set-WlanDevice
			Set-Bluetooth
			Set-TpmState
			Set-TpmDevice
			Set-TpmActivationPolicy
			Set-IntegratedCamera
			Set-Fingerprint
			Set-UCSI
			Set-BatteryHealthManager
            Set-SmartCard

            Write-Log "BIOS settings are set with BIOS Password."
            return $true
        }
    catch {
        if ($_.Exception.Message -eq "Access denied or incorrect password")
        {
            Write-Log "BIOS password incorrect, could not configure BIOS settings."

            $ErrorMessage = "BIOS password is incorrect"
            $ExitCode = 216
            Add-RegistryCode -ExitCode $ExitCode -ErrorMessage $ErrorMessage
            Add-RegistryHistory
            Exit 216
        }
        Write-Log $_.Exception

        $ErrorMessage = $_.Exception.Message
        $ExitCode = 343
        Add-RegistryCode -ExitCode $ExitCode -ErrorMessage $ErrorMessage
        Add-RegistryHistory
        Exit 343
    }
}

#=============================================================
# Create Logging Regkey for time
#=============================================================

function Add-RegistryHistory {
    Param(
        [Parameter(Mandatory = $false)]
        [boolean] $Result
    )
    try {
        if (!(Test-Path $regTagpath)) {
            New-Item -Path $regTagPath -Force
        }

        $UpdateBIOSSetting = $Result
        # The last date and time the BIOS settings script was run regardless if it was successful or not
        $lastExecutionTime = Get-Date -format "MM/dd/yyyy HH:mm"
        Set-ItemProperty -Path $regTagPath -Name "LastExecutionTime" -Value $lastExecutionTime -Force

        if ($UpdateBIOSSetting -eq $true) {
            Set-ItemProperty -Path $regTagPath -Name "ExitCode" -Value "0" -Force
			Set-ItemProperty -Path $regTagPath -Name "ErrorMessage" -Value "" -Force
			Remove-Item * -Force -ErrorAction SilentlyContinue
        }
    }
    catch {
        Write-Log $_.Exception

        $ErrorMessage = $_.Exception
        $ExitCode = 343
        Add-RegistryCode -ExitCode $ExitCode -ErrorMessage $ErrorMessage
        Exit 343
    }
}

#=============================================================
# Create Logging Regkey for exit code and error message
#=============================================================

function Add-RegistryCode {
    Param(
        [Parameter(Mandatory = $true)]
        [string] $ExitCode,
        [Parameter(Mandatory = $false)]
        [string] $ErrorMessage
    )

    if (!(Test-Path $regTagpath)) { New-Item -Path $regTagPath -Force }

	New-ItemProperty -Path $regTagPath -Name "ExitCode" -Value $ExitCode -Force
	New-ItemProperty -Path $regTagPath -Name "ErrorMessage" -Value $ErrorMessage -Force

}

#=============================================================
# Script commands start here
#=============================================================

Write-Log "Running script version $version"
$BIOSpassword = Get-BIOSPassword
Set-BIOSPassword

Get-Bitlocker-Status

$Result = Set-BIOSSettings
Add-RegistryHistory -Result $Result