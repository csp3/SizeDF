<#
.DESCRIPTION
Muestra el tamaño de directorios y archivos en una Lista 
.EXAMPLE
C:\PS> SizeDir [Ruta] 
.NOTES
Author: CSolisP
Date:   Dic 2021
#>

$global:TOTAL = @() 

#funcion que halla el tamaño de un directorio 
function size_recursivo 
{
    [CmdletBinding()]
    param (
        $Ruta = "." 
    )
 
    $ACUMULA = 0

    $COMANDO = Get-ChildItem -Path $RUTA -Force  
    
    foreach ($item in $COMANDO ) 
    {
        $FN = $item.FullName 
        if(Test-Path -Path $FN -PathType Container) 
        {
            # Write-Host $FN 
            size_recursivo $FN
        }
        else 
        {
            # Write-Host $FN 
            $ACUMULA += (Get-Item -Path $FN -Force).Length 
        }  
    } 
    
    $global:TOTAL += $ACUMULA 
}

#funcion para el tamanio total de directorio con subdirectorios y archivos 
function SizeD($Ruta = ".") 
{
    $SUMATOTAL = 0

    size_recursivo -Ruta $Ruta  

    foreach ($item in $global:TOTAL) 
    {
        $SUMATOTAL += $item 
    }

    $SUMATOTAL 
    $global:TOTAL = @() 
} 

#funcion principal 
function SizeDF 
{
    param (
        $Ruta = "." 
    )

    Write-Host "`nTYPE        SIZE          NAME"
    Write-Host "--------------------------------" 

    $COMANDO = Get-ChildItem -Path $Ruta -Force 

    $TOTALDIR = 0 
    foreach ($item in $COMANDO )  
    { 
        $FN = $item.FullName  
        
        if(Test-Path -Path $FN -PathType Container) 
        {
            $TAMANIO = SizeD -Ruta $FN   
            
            #calculando tamanio
            if($TAMANIO -lt 1024)
            {
                Write-Host -ForegroundColor Green  "dir."  ($TAMANIO/1).ToString("0.00").PadLeft(10)  "by `t"  $FN  
            }
            if($TAMANIO -ge 1024 -and $TAMANIO -lt 1048576) 
            {
                Write-Host -ForegroundColor Green  "dir."  ($TAMANIO/1kb).ToString("0.00").PadLeft(10)  "Kb `t"  $FN    
            }
            if($TAMANIO -ge 1048576 -and $TAMANIO -lt 1073741824) 
            {
                Write-Host -ForegroundColor Green  "dir."  ($TAMANIO/1mb).ToString("0.00").PadLeft(10)  "MB `t"  $FN  
            }
            if($TAMANIO -ge 1073741824) 
            {
                Write-Host -ForegroundColor Green  "dir."  ($TAMANIO/1gb).ToString("0.00").PadLeft(10)  "GB `t"  $FN  
            }
        } 
        else 
        {   
            #calculando tamanio 
            $TAMANIO = (Get-Item -Path $FN -Force).Length
            
            if($TAMANIO -lt 1024)
            {
                Write-Host  "file"  ($TAMANIO/1).ToString("0.00").PadLeft(10)  "by `t"  $FN  
            }
            if($TAMANIO -ge 1024 -and $TAMANIO -lt 1048576)
            {
                Write-Host  "file"  ($TAMANIO/1kb).ToString("0.00").PadLeft(10)  "Kb `t"  $FN  
            }
            if($TAMANIO -ge 1048576 -and $TAMANIO -lt 1073741824) 
            {
                Write-Host  "file"  ($TAMANIO/1mb).ToString("0.00").PadLeft(10)  "MB `t"  $FN  
            }
            if($TAMANIO -ge 1073741824) 
            {
                Write-Host  "file"  ($TAMANIO/1gb).ToString("0.00").PadLeft(10)  "GB `t"  $FN   
            }
        } 
        ;
        $TOTALDIR += $TAMANIO 
    }
    ; 
    #mostrando resultado
    if ($TOTALDIR -lt 2014) 
    {
        Write-Host  -ForegroundColor Green "`nTOTAL = "  ($TOTALDIR/1).ToString("0.00").PadLeft(5)  "by`n "     
    }
    if ($TOTALDIR -ge 1024 -and $TOTALDIR -lt 1048576) 
    {
        Write-Host  -ForegroundColor Green "`nTOTAL = "  ($TOTALDIR/1kb).ToString("0.00").PadLeft(5)  "Kb`n "     
    }
    if ($TOTALDIR -ge 1048576 -and $TOTALDIR -lt 1073741824)
    {
        Write-Host  -ForegroundColor Green "`nTOTAL = "  ($TOTALDIR/1mb).ToString("0.00").PadLeft(5)  "MB`n " 
    }
    if ($TOTALDIR -ge 1073741824)
    {
        Write-Host  -ForegroundColor Green "`nTOTAL = "  ($TOTALDIR/1gb).ToString("0.00").PadLeft(5)  "GB`n " 
    }
}
