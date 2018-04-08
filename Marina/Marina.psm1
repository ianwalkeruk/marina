function Import-MarinaConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ParameterSetName='FromXmlFile')]
        [Parameter(Mandatory=$true,ParameterSetName='FromJsonFile')]
        [string]$FileName
        ,
        [Parameter(Mandatory=$false,ParameterSetName='FromXmlFile')]
        # because Mandatory=$false in this ParameterSet, this is the default
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

function New-MarinaConfiguration {
    param() 
    process {
        $ret = New-Object -type MarinaConfiguration
        return $ret
    }
}
Export-ModuleMember -Function 'New-MarinaConfiguration'

function Add-MarinaModule {
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [MarinaConfiguration]$Configuration
    )
    process {
        $ret = New-Object -type MarinaModule
        $Configuration.Modules += @($ret)
        return $ret
    }
}
Export-ModuleMember -Function 'Add-MarinaModule'

Class MarinaConfiguration {
    MarinaConfiguration() {
        $this.Modules = @()
    }
    
    # TODO - move this out of the class and into a function
    [void]ImportXml ([xml]$xml) {
        $root = $xml.documentelement
        if ($root.name -ne 'marina') {throw "Invalid XML configuration"}        
    }
    
    hidden [MarinaModule[]]$Modules
}

Class MarinaModule {
}