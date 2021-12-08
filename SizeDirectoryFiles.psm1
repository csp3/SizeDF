<#
.DESCRIPTION
Muestra el tamaño de directorios y archivos en una Lista 
.EXAMPLE
C:\PS> SizeDir [Ocultos] 
.NOTES
Author: CSolisP
Date:   Dic 2021
#>

$global:TOTAL = @() 

function size_recursivo 
{
    [CmdletBinding()]
    param (
        $RUTA = ".",
        $Ocultados = ""
    )
 
    $ACUMULA = 0

    if($Ocultados -eq "Ocultos")
    {
        $COMANDO = Get-ChildItem $RUTA -Force  
    }
    else 
    {
        $COMANDO = Get-ChildItem $RUTA 
    }

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
            $ACUMULA += (Get-Item $FN).Length 
        }  
    } 
    
    $global:TOTAL  += $ACUMULA 
}

function SizeDir($Ocul = "") 
{
    $SUMATOTAL = 0

    if ($Ocul -eq "Ocultos") 
    {
        size_recursivo "." "Ocultos"
    } 
    else 
    {
        size_recursivo "." 
    }

    foreach ($item in $global:TOTAL) 
    {
        $SUMATOTAL += $item 
    }

    Write-Host "TOTAL = " $SUMATOTAL 
    $global:TOTAL = @() 
} 
