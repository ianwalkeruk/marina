function Import-MarinaConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ParameterSetName='FromXmlFile')]
        [Parameter(Mandatory=$true,ParameterSetName='FromJsonFile')]
        [string]$FileName
        ,
        [Parameter(Mandatory=$false,ParameterSetName='FromXmlFile')]
        [switch]$Xml
        ,
        [Parameter(Mandatory=$true,ParameterSetName='FromJsonFile')]
        [switch]$Json        
    )
    process {
        $ret = New-Object -type MarinaConfiguration
        switch ($PSCmdLet.ParameterSetName) {
            'FromXmlFile' {
                $x = [xml](Get-Content -Path $FileName)
                $ret.ImportXml($x)
            }
        }
        return $ret
    }
}
Export-ModuleMember -Function 'Import-MarinaConfiguration'

Class MarinaConfiguration {
    [void]ImportXml ([xml]$xml) {
        $root = $xml.documentelement
        if ($root.name -ne 'marina') {throw "Invalid XML configuration"}        
    }
}