<#
    MUESTRA TAMAÑO DE DIRECTORIOS Y ARCHIVOS 
#>
 
Write-Host "`nTYPE        SIZE          NAME"
Write-Host "________________________________" 

function sizedf {
    [CmdLetBinding()]
    $TAMANIO = 0
    $TOTAL = 0
    Get-ChildItem -Force | ForEach-Object { 
        if(Test-Path -Path $_.Name -PathType Container) 
        {
            
            try {
                $TAMANIO = (Get-ChildItem $_.Name -Force -Recurse | Measure-Object  -Sum {$_.Length})   
                $TAMANIO = $TAMANIO.Sum 
                -ErrorAction Stop
            }
            catch {
                $TAMANIO=0
            }
            
            if($TAMANIO -lt 1024)
            {
                Write-Host -ForegroundColor Green  "dir."  ($TAMANIO/1).ToString("0.00").PadLeft(10)  "by `t"  $_.Name 
            }
            if($TAMANIO -ge 1024 -and $TAMANIO -lt 1048576) 
            {
                Write-Host -ForegroundColor Green  "dir."  ($TAMANIO/1kb).ToString("0.00").PadLeft(10)  "Kb `t"  $_.Name   
            }
            if($TAMANIO -ge 1048576) 
            {
                Write-Host -ForegroundColor Green  "dir."  ($TAMANIO/1mb).ToString("0.00").PadLeft(10)  "MB `t"  $_.Name 
            }
        } 
        else 
        {
            $TAMANIO = (Get-Item $_.Name -Force).Length
            
            if($TAMANIO -lt 1024)
            {
                Write-Host  "file"  ($TAMANIO/1).ToString("0.00").PadLeft(10)  "by `t"  $_.Name 
            }
            if($TAMANIO -ge 1024 -and $TAMANIO -lt 1048576)
            {
                Write-Host  "file"  ($TAMANIO/1kb).ToString("0.00").PadLeft(10)  "Kb `t"  $_.Name 
            }
            if($TAMANIO -ge 1048576) 
            {
                Write-Host  "file"  ($TAMANIO/1mb).ToString("0.00").PadLeft(10)  "MB `t"  $_.Name 
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
    if ($TOTAL -ge 1048576) 
    {
        Write-Host  -ForegroundColor Green "`nTOTAL = "  ($TOTAL/1mb).ToString("0.00").PadLeft(5)  "MB`n " 
    }
}

sizedf 
