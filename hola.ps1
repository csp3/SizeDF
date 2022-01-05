
# function mos 
# {
#     while (1) 
#     {
#         Write-Host -NoNewline "|`b"
#         Start-Sleep -Milliseconds 600 
#         Write-Host -NoNewline "-`b"
#         Start-Sleep -Milliseconds 600  
#     }
# }


clear-host 
$a = get-computerinfo 

# fabricante 
Write-Host "Fabricante:`t`t" $a.CsManufacturer 

# fabricante modelo  
Write-Host "Modelo del Fabricante:`t" $a.CsModel 

# fabricante SKU 
Write-Host "SKU del fabricante:`t" $a.CsSystemSKUNumber 

<#---------------#>

Write-Host "`nWINDOWS"
# WINDOWS edicion  

Write-Host "Edición:`t`t" $a.WindowsEditionId  
  
# WINDOWS tipo de instalación 
Write-Host "Tipo instalado:`t`t" $a.WindowsInstallationType 

# WINDOWS fecha de instalacion  
Write-Host "Fecha de Instalación:`t" $a.WindowsInstallDateFromRegistry   
 
# WINDOWS nombre de producto 
Write-Host "Nombre del Producto:`t" $a.WindowsProductName 
 
# WINDOWS version 
Write-Host "Versión Windows:`t" $a.WindowsVersion  

# WINDOWS arquitectura
Write-Host "Arquitectura:`t`t" $a.OsArchitecture 

# <#--------#>

Write-Host "`nBIOS"
# BIOS descripcion 
Write-Host "Descripción:`t`t" $a.BiosDescription 

# BIOS fabricante  
Write-Host "Fabricante:`t`t" $a.BiosManufacturer 

# <#----------#>

Write-Host "`nSISTEMA OPERATIVO"
# HOST usuario registrado
Write-Host "Uusario Registrado:`t" $a.OsRegisteredUser 

# Número de serie
Write-Host "Número de serie:`t" $a.OsSerialNumber 

# Teclado 
Write-Host "Teclado:`t`t" $a.KeyboardLayout 

# Zona horaria 
Write-Host "Zona horaria:`t`t" $a.TimeZone 

# Logon server
write-host "Logon server:`t`t" $a.LogonServer  

# HOST name 
Write-Host "Nombre de Host:`t`t" $a.CsDNSHostName 

# HOST domain 
Write-Host "Dominio:`t`t" $a.CsDomain 

# HOST rol de dominio 
Write-Host "Rol de dominio:`t`t" $a.CsDomainRole 

# HOST grupo de trabajo 
Write-Host "Grupo de trabajo:`t" $a.CsWorkgroup 

# HOST tiene hypervisor 
Write-Host "Hypervisor:`t`t" $a.CsHypervisorPresent 

# <#---------#>

# Sistema Operativo fecha de instalación 
Write-Host "Fecha de instalación:`t" $a.OsInstallDate  

# Sistema Operativo tipo
Write-Host "Tipo:`t`t`t" $a.OsType 

# Sistema Operativo versión 
Write-Host "Versión:`t`t" $a.OsVersion 

# Sistema  Operativo número compilación 
Write-Host "Compilación:`t`t" $a.OsBuildNumber 

# #Sistema Operativo booteo 
Write-Host "Disp. Booteo:`t`t" $a.OsBootDevice 
 
# #Sistema Operativo dispositivo  
Write-Host "Disp. Sistema:`t`t" $a.OsSystemDevice 

# Sistema Operativo idioma local 
Write-Host "Idioma local:`t`t" $a.OsLocale 

# Sistema Operativo fecha local 
Write-Host "Fecha local:`t`t" $a.OsLocalDateTime 
 
# Sistema Operativo último encendido 
Write-Host "Encendida el:`t`t" $a.OsLastBootUpTime 

<#--------#>

Write-Host "`nRAM - MEMORY"
# #RAM instalada 
Write-Host "RAM instalada:`t`t" ($a.CsTotalPhysicalMemory/1gb) "GB"   

# #Memoria Virtual total
Write-Host "Memoria Virtual:`t" ($a.OsTotalVirtualMemorySize/1mb) "MB"  

# #Ruta de Archivos de Paginación 
Write-Host "Arch. Paginación:`t" $a.OsPagingFiles 

<#----------#>

Write-Host "`nRED"
# #adaptadores de red 
foreach ($item in $a.CsNetworkAdapters ) 
{
    Write-Host "Descripción:`t`t" $item.connectionid " - " $item.description
}

<#--------------#>

Write-Host "`nPROCESADOR"
# procesador caracteristicas  
foreach ($item in $a.CsProcessors) 
{
    Write-Host "Descripción:`t`t" $item.name 
}
Write-Host "Núm. Procesadores:`t" $a.CsNumberOfProcessors  
Write-Host "Núm. Procesadores Log.:`t" $a.CsNumberOfLogicalProcessors

" "
