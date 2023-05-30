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
#copy and paste BIOS settings below, adjust the value to whatever suits your organization.



#=============================================================
# List of Bios Settings to Configure
#=============================================================

function Set-BIOSSettings {
    try {
            Write-Log "Configuring settings with BIOS password."

			#comment out or remove functions not applicable to this model
			Set-UEFIBootOptions
			Set-LegacySupportSecureBoot
			Set-LegacyBoot
			Set-SecureBoot
			Set-FastBoot
			Set-PXEBoot
			Set-CdRomBoot
			Set-UsbBoot
			Set-BootOrder
			Set-UefiCaKey
			Set-SecureBootKeysProtection
            Set-VTx
            Set-VTd
			Set-SVMCPUVirtualization
			Set-WoL
			Set-WoLDC
			Set-WoWL
			Set-LanWlanSwitching
			Set-WlanDevice
			Set-LanController
			Set-Bluetooth
			Set-TpmState
			Set-TpmDevice
			Set-TpmActivationPolicy
			Set-TpmVersion
			Set-IntegratedCamera
			Set-IntegratedFrontCamera
			Set-IntegratedRearCamera
			Set-Fingerprint
			Set-ThunderboltPorts
			Set-ThunderboldSecurityLevel
			Set-UCSI
			Set-BatteryHealthManager
			Set-PowerControl
			Set-EmbeddedSecurityActivation
			Set-MediaCardReader
			Set-SmartCard
			Set-Graphics
			Set-IntegratedVideo
			Set-M2UsbBluetooth
			Set-RestrictUsb
			Set-NumLock
			Set-AutoBiosUpdate

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
