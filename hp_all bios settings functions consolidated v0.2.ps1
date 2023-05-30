# Set UEFI Boot Options to Enable
function Set-UEFIBootOptions {
	if ((Get-HPBIOSSettingValue "UEFI Boot Options") -ne "Enable" ) {
		Write-Log "Setting UEFI Boot Options to Enable."
		Set-HPBIOSSettingValue -Name "UEFI Boot Options" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "UEFI Boot Options is already Enabled."
	}
}

# Set Configure Legacy Support and Secure Boot to Legacy Support Disable and Secure Boot Enable
function Set-LegacySupportSecureBoot {
	if ((Get-HPBIOSSettingValue "Configure Legacy Support and Secure Boot") -ne "Legacy Support Disable and Secure Boot Enable") {
		Write-Log "Setting Configure Legacy Support and Secure Boot to Legacy Support Disable and Secure Boot Enable."
		Set-HPBIOSSettingValue -Name "Configure Legacy Support and Secure Boot" -Value "Legacy Support Disable and Secure Boot Enable" -Password $BIOSpassword
		}

	else {
		Write-Log "Configure Legacy Support and Secure Boot is already set to Legacy Support Disable and Secure Boot Enable."
	}
}

# Set Legacy Boot Options to Enable
function Set-LegacyBoot {
	if ((Get-HPBIOSSettingValue "Legacy Boot Options") -ne "Enable" ) {
		Write-Log "Setting Legacy Boot Options to Enable."
		Set-HPBIOSSettingValue -Name "Legacy Boot Options" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Legacy Boot Options is already Enabled."
	}
}

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

# Set CD-ROM Boot to Enable
function Set-LanController {
	if ((Get-HPBIOSSettingValue "CD-ROM Boot") -ne "Enable" ) {
		Write-Log "Setting CD-ROM Boot to Enable."
		Set-HPBIOSSettingValue -Name "CD-ROM Boot" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "CD-ROM Boot is already Enabled."
	}
}

# Set USB Storage Boot to Enable
function Set-UsbBoot {
	if ((Get-HPBIOSSettingValue "USB Storage Boot") -ne "Enable" ) {
		Write-Log "Setting USB Storage Boot to Enable."
		Set-HPBIOSSettingValue -Name "USB Storage Boot" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "USB Storage Boot is already Enabled."
	}
}

# Set UEFI Boot Order to HDD:M.2:1,HDD:USB:1,NETWORK IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1
function Set-BootOrder {
	if ((Get-HPBIOSSettingValue "UEFI Boot Order") -ne "HDD:M.2:1,HDD:USB:1,NETWORK IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1" ) {
		Write-Log "Setting UEFI Boot Order to HDD:M.2:1,HDD:USB:1,NETWORK IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1"
		Set-HPBIOSSettingValue -Name "UEFI Boot Order" -Value "HDD:M.2:1,HDD:USB:1,NETWORK IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1" -password $BIOSpassword
	}
	else {
		Write-Log "UEFI Boot Order is already set to HDD:M.2:1,HDD:USB:1,NETWORK IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1"
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

# Set Virtualization Technology (VTx) to Enable
function Set-VTx {
	if ((Get-HPBIOSSettingValue "Virtualization Technology (VTx)") -ne "Enable") {
		Write-Log "Setting Virtualization Technology (VTx) to Enable."
		Set-HPBIOSSettingValue -Name "Virtualization Technology (VTx)" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Virtualization Technology (VTx) is already Enabled."
	}
}

# Set Virtualization Technology for Directed I/O (VTd) to Enable
function Set-VTd {
	if ((Get-HPBIOSSettingValue "Virtualization Technology for Directed I/O (VTd)") -ne "Enable") {
		Write-Log "Setting Virtualization Technology for Directed I/O (VTd) to Enable."
		Set-HPBIOSSettingValue -Name "Virtualization Technology for Directed I/O (VTd)" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Virtualization Technology for Directed I/O (VTd) is already Enabled."
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

# Set Wake on LAN on DC mode to Enable
function Set-WoLDC {
	if ((Get-HPBIOSSettingValue "Wake on LAN on DC mode") -ne "Enable" ) {
		Write-Log "Setting Wake on LAN on DC mode to Enable."
		Set-HPBIOSSettingValue -Name "Wake on LAN on DC mode" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Wake on LAN on DC mode is already set to Enable."
	}
}

# Set Wake on WLAN to Disable
function Set-WoWL {
	if ((Get-HPBIOSSettingValue "Wake on WLAN") -ne "Disable" ) {
		Write-Log "Setting Wake on WLAN to Disable."
		Set-HPBIOSSettingValue -Name "Wake on WLAN" -Value "Disable" -password $BIOSpassword
	}
	else {
		Write-Log "Wake on WLAN is already Disabled."
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

# Set Embedded LAN controller to Enable
function Set-LanController {
	if ((Get-HPBIOSSettingValue "Embedded LAN controller") -ne "Enable" ) {
		Write-Log "Setting Embedded LAN controller to Enable."
		Set-HPBIOSSettingValue -Name "Embedded LAN controller" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Embedded LAN controller is already Enabled."
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

# Set M.2 USB / Bluetooth to Enable
function Set-M2UsbBluetooth {
	if ((Get-HPBIOSSettingValue "M.2 USB / Bluetooth") -ne "Enable" ) {
		Write-Log "Setting M.2 USB / Bluetooth to Enable."
		Set-HPBIOSSettingValue -Name "M.2 USB / Bluetooth" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "M.2 USB / Bluetooth is already Enabled."
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

# Set TPM Specification Version to 2.0
function Set-TpmVersion {
	if ((Get-HPBIOSSettingValue "TPM Specification Version") -ne "2.0" ) {
		Write-Log "Setting TPM Specification Version to 2.0."
		Set-HPBIOSSettingValue -Name "TPM Specification Version" -Value "2.0" -password $BIOSpassword
	}
	else {
		Write-Log "TPM Specification Version is already 2.0."
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

# Set Integrated Front Camera to Enable
function Set-IntegratedFrontCamera {
	if ((Get-HPBIOSSettingValue "Integrated Front Camera") -ne "Enable" ) {
		Write-Log "Setting Integrated Front Camera to Enable."
		Set-HPBIOSSettingValue -Name "Integrated Front Camera" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Integrated Front Camera is already Enabled."
	}
}

# Set Integrated Rear Camera to Enable
function Set-IntegratedRearCamera {
	if ((Get-HPBIOSSettingValue "Integrated Rear Camera") -ne "Enable" ) {
		Write-Log "Setting Integrated Rear Camera to Enable."
		Set-HPBIOSSettingValue -Name "Integrated Rear Camera" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Integrated Rear Camera is already Enabled."
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

# Set Thunderbolt Type-C Ports to Enable
function Set-ThunderboltPorts {
	if ((Get-HPBIOSSettingValue "Thunderbolt Type-C Ports") -ne "Enable" ) {
		Write-Log "Setting Thunderbolt Type-C Ports to Enable."
		Set-HPBIOSSettingValue -Name "Thunderbolt Type-C Ports" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Thunderbolt Type-C Ports is already set to Enable."
	}
}

# Set Thunderbolt Security Level to PCIe and DisplayPort - No Security
function Set-ThunderboldSecurityLevel {
	if ((Get-HPBIOSSettingValue "Thunderbolt Security Level") -ne "PCIe and DisplayPort - No Security" ) {
		Write-Log "Setting Thunderbolt Security Level to PCIe and DisplayPort - No Security."
		Set-HPBIOSSettingValue -Name "Thunderbolt Security Level" -Value "PCIe and DisplayPort - No Security" -password $BIOSpassword
	}
	else {
		Write-Log "Thunderbolt Security Level is already set to PCIe and DisplayPort - No Security."
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

# Set Power Control to Disable
function Set-PowerControl {
	if ((Get-HPBIOSSettingValue "Power Control") -ne "Disable" ) {
		Write-Log "Setting Power Control to Disable."
		Set-HPBIOSSettingValue -Name "Power Control" -Value "Disable" -password $BIOSpassword
	}
	else {
		Write-Log "Power Control is already Disabled."
	}
}

# Set Embedded Security Activation Policy to No prompts
function Set-EmbeddedSecurityActivation {
	if ((Get-HPBIOSSettingValue "Embedded Security Activation Policy") -ne "No prompts" ) {
		Write-Log "Setting Embedded Security Activation Policy to No prompts."
		Set-HPBIOSSettingValue -Name "Embedded Security Activation Policy" -Value "No prompts" -password $BIOSpassword
	}
	else {
		Write-Log "Embedded Security Activation Policy is already set to No prompts."
	}
}

# Set Media Card Reader to Enable
function Set-MediaCardReader {
	if ((Get-HPBIOSSettingValue "Media Card Reader") -ne "Enable" ) {
		Write-Log "Setting Media Card Reader to Enable."
		Set-HPBIOSSettingValue -Name "Media Card Reader" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Media Card Reader is already set to Enable."
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

# Set Graphics to Discrete Graphics
function Set-Graphics {
	if ((Get-HPBIOSSettingValue "Graphics") -ne "Discrete Graphics" ) {
		Write-Log "Setting Graphics to Discrete Graphics."
		Set-HPBIOSSettingValue -Name "Graphics" -Value "Discrete Graphics" -password $BIOSpassword
	}
	else {
		Write-Log "Graphics is already set to Discrete Graphics."
	}
}

# Set Integrated Video to Enable
function Set-IntegratedVideo {
	if ((Get-HPBIOSSettingValue "Integrated Video") -ne "Enable" ) {
		Write-Log "Setting Integrated Video to Enable."
		Set-HPBIOSSettingValue -Name "Integrated Video" -Value "Enable" -password $BIOSpassword
	}
	else {
		Write-Log "Integrated Video is already set to Enable."
	}
}

# Set Restrict USB Devices to Allow all USB Devices
function Set-RestrictUsb {
	if ((Get-HPBIOSSettingValue "Restrict USB Devices") -ne "Allow all USB Devices" ) {
		Write-Log "Setting Restrict USB Devices to Allow all USB Devices."
		Set-HPBIOSSettingValue -Name "Restrict USB Devices" -Value "Allow all USB Devices" -password $BIOSpassword
	}
	else {
		Write-Log "Restrict USB Devices is already set to Allow all USB Devices."
	}
}

# Set NumLock on at boot to Disable
function Set-NumLock {
	if ((Get-HPBIOSSettingValue "NumLock on at boot") -ne "Disable" ) {
		Write-Log "Setting NumLock on at boot to Disable."
		Set-HPBIOSSettingValue -Name "NumLock on at boot" -Value "Disable" -password $BIOSpassword
	}
	else {
		Write-Log "NumLock on at boot is already Disabled."
	}
}

# Set Automatic BIOS Update Setting to Disable
function Set-AutoBiosUpdate {
	if ((Get-HPBIOSSettingValue "Automatic BIOS Update Setting") -ne "Disable" ) {
		Write-Log "Setting Automatic BIOS Update Setting to Disable."
		Set-HPBIOSSettingValue -Name "Automatic BIOS Update Setting" -Value "Disable" -password $BIOSpassword
	}
	else {
		Write-Log "Automatic BIOS Update Setting is already Disabled."
	}
}
