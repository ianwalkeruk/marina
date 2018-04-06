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
        Write-Verbose "Using Parameter Set: $($PSCmdLet.ParameterSetName)"
    }
}
Export-ModuleMember -Function 'Import-MarinaConfiguration'

Class MarinaConfiguration {
    
}