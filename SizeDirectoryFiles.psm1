<#
.DESCRIPTION
Muestra el tamaño de directorios y archivos en una Lista 
.EXAMPLE
C:\PS> SizeDF [Ocultos] 
.NOTES
Author: CSolisP
Date:   Dic 2021
#>

function sizedf {
    [CmdLetBinding()]
    Param (
        [Parameter()]
        [ValidateSet("Ocultos", "")]
        $Ocultados = "" 
    )

    Write-Host "`nTYPE        SIZE          NAME"
    Write-Host "________________________________" 
    
    if($Ocultados -eq "Ocultos")
    {
        $COMANDO = Get-ChildItem -Force  
    }
    else 
    {
        $COMANDO = Get-ChildItem 
    }

    $TAMANIO = 0
    $TOTAL = 0
    $COMANDO | ForEach-Object { 
        if(Test-Path -Path $_.Name -PathType Container) 
        {
            try {
                $TAMANIO = (Get-ChildItem $_.Name -Force -Recurse | Measure-Object  -Sum {$_.Length} -ErrorAction Stop )   
                $TAMANIO = $TAMANIO.Sum 
                -ErrorAction Stop
            }
            catch {
                $TAMANIO=0
            }
            
            #calculando tamanio
            if($TAMANIO -lt 1024)
            {
                Write-Host -ForegroundColor Green  "dir."  ($TAMANIO/1).ToString("0.00").PadLeft(10)  "by `t"  $_.Name 
            }
            if($TAMANIO -ge 1024 -and $TAMANIO -lt 1048576) 
            {
                Write-Host -ForegroundColor Green  "dir."  ($TAMANIO/1kb).ToString("0.00").PadLeft(10)  "Kb `t"  $_.Name   
            }
            if($TAMANIO -ge 1048576 -and $TAMANIO -lt 1073741824) 
            {
                Write-Host -ForegroundColor Green  "dir."  ($TAMANIO/1mb).ToString("0.00").PadLeft(10)  "MB `t"  $_.Name 
            }
            if($TAMANIO -ge 1073741824) 
            {
                Write-Host -ForegroundColor Green  "dir."  ($TAMANIO/1gb).ToString("0.00").PadLeft(10)  "GB `t"  $_.Name 
            }
        } 
        else 
        {   
            #calculando tamanio 
            $TAMANIO = (Get-Item $_.Name -Force).Length
            
            if($TAMANIO -lt 1024)
            {
                Write-Host  "file"  ($TAMANIO/1).ToString("0.00").PadLeft(10)  "by `t"  $_.Name 
            }
            if($TAMANIO -ge 1024 -and $TAMANIO -lt 1048576)
            {
                Write-Host  "file"  ($TAMANIO/1kb).ToString("0.00").PadLeft(10)  "Kb `t"  $_.Name 
            }
            if($TAMANIO -ge 1048576 -and $TAMANIO -lt 1073741824) 
            {
                Write-Host  "file"  ($TAMANIO/1mb).ToString("0.00").PadLeft(10)  "MB `t"  $_.Name 
            }
            if($TAMANIO -ge 1073741824) 
            {
                Write-Host  "file"  ($TAMANIO/1gb).ToString("0.00").PadLeft(10)  "GB `t"  $_.Name  
            }
        }  
        ; 
        $TOTAL += $TAMANIO
    }
    ; 
    #mostrando resultado
    if ($TOTAL -lt 2014) 
    {
        Write-Host  -ForegroundColor Green "`nTOTAL = "  ($TOTAL/1).ToString("0.00").PadLeft(5)  "by`n "     
    }
    if ($TOTAL -ge 1024 -and $TOTAL -lt 1048576) 
    {
        Write-Host  -ForegroundColor Green "`nTOTAL = "  ($TOTAL/1kb).ToString("0.00").PadLeft(5)  "Kb`n "     
    }
    if ($TOTAL -ge 1048576 -and $TOTAL -lt 1073741824)
    {
        Write-Host  -ForegroundColor Green "`nTOTAL = "  ($TOTAL/1mb).ToString("0.00").PadLeft(5)  "MB`n " 
    }
    if ($TOTAL -ge 1073741824)
    {
        Write-Host  -ForegroundColor Green "`nTOTAL = "  ($TOTAL/1gb).ToString("0.00").PadLeft(5)  "GB`n " 
    }
}
