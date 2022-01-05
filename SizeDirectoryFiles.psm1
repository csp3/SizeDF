$global:TOTAL = @() 

#funcion que halla el tamaño de un directorio 
function size_recursivo 
{
    <#
    .DESCRIPTION
    Muestra el tamaño de directorios y archivos en una Lista (si dir. o fil. estan ocultos) 
    .EXAMPLE
    C:\PS> SizeDF [Ruta] 
    .NOTES
    Author: CSolisP
    Date:   Dic 2021
    #>
    [CmdletBinding()]
    param (
        $Ruta = "." 
    )
 
    $ACUMULA = 0

    $COMANDO = Get-ChildItem -LiteralPath $RUTA -Force  
    
    foreach ($item in $COMANDO ) 
    {
        $FN = $item.FullName 
        if(Test-Path -LiteralPath $FN -PathType Container) 
        {
            # Write-Host $FN 
            size_recursivo $FN
        }
        else 
        {
            # Write-Host $FN 
            $ACUMULA += (Get-Item -LiteralPath $FN -Force).Length 
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

    $COMANDO = Get-ChildItem -LiteralPath $Ruta -Force 

    $TOTALDIR = 0 
    foreach ($item in $COMANDO )  
    { 
        #ruta completa 
        $FN = $item.FullName  
        
        if(Test-Path -LiteralPath $FN -PathType Container) 
        {
            #calculando tamanio
            $TAMANIO = SizeD -Ruta $FN 
            #si tiene atributo oculto 
            if (Get-Item $FN -Force | where-object { $_.Attributes -like "*hidden*" })  
            {
                presentacion -valor $TAMANIO -cadena1 "dir." -cadena2 $FN -color "Green"         
            }
            else 
            {
                presentacion -valor $TAMANIO -cadena1 "dir" -cadena2 $FN -color "Green" 
            }
        } 
        else 
        {   
            #calculando tamanio 
            $TAMANIO = (Get-Item -LiteralPath $FN -Force).Length 
            #si tiene atributo oculto 
            if (Get-Item $FN -Force | where-object { $_.Attributes -like "*hidden*" })  
            {
                presentacion -valor $TAMANIO -cadena1 "fil." -cadena2 $FN          
            }
            else 
            {
                presentacion -valor $TAMANIO -cadena1 "fil" -cadena2 $FN  
            }
        } 
        ;
        $TOTALDIR = $TOTALDIR + $TAMANIO 
    }
    ; 
    #mostrando resultado
    write-host " "
    presentacion -valor $TOTALDIR -cadena1 "TOTAL = " -cadena2 "" -color "Green" 
    write-host " "  
}

#funcion presentacion 
function presentacion 
{   
    param (
        $valor = 0, 
        $cadena1 = "", 
        $cadena2 = "",
        $color = "White" 
    ) 
    
    if ($valor -lt 2014) 
    {
        Write-Host  -ForegroundColor $color $cadena1 ($valor/1  ).ToString("0.00").PadLeft(10)  "by `t" $cadena2  
    }
    if ($valor -ge 1024 -and $valor -lt 1048576) 
    {
        Write-Host  -ForegroundColor $color $cadena1 ($valor/1kb).ToString("0.00").PadLeft(10)  "Kb `t" $cadena2  
    }
    if ($valor -ge 1048576 -and $valor -lt 1073741824)
    {
        Write-Host  -ForegroundColor $color $cadena1 ($valor/1mb).ToString("0.00").PadLeft(10)  "MB `t" $cadena2  
    }
    if ($valor -ge 1073741824)
    {
        Write-Host  -ForegroundColor $color $cadena1 ($valor/1gb).ToString("0.00").PadLeft(10)  "GB `t" $cadena2  
    }
}
