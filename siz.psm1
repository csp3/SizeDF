$global:TOTAL = @() 

function size_recursivo 
{
    [CmdletBinding()]
    param (
        $RUTA = "."
    )

    # $ACTUAL = Get-Location 
    $ACUMULA = 0
    foreach ($item in Get-ChildItem $RUTA) 
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

function SizeDir 
{
    $SUMATOTAL = 0

    size_recursivo "."

    foreach ($item in $global:TOTAL) 
    {
        $SUMATOTAL += $item 
    }

    Write-Host "SUMA TOTAL = " $SUMATOTAL 
} 
