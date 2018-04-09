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
        ,
        [Parameter(Mandatory)]
        [string]$Name
        ,
        [Parameter(Mandatory)]
        [string]$Path
    )
    process {
        $ret = [MarinaModule]::new($Name,$Path)
        $Configuration.Modules += @($ret)
        return $ret
    }
}
Export-ModuleMember -Function 'Add-MarinaModule'

function Add-MarinaImageSet {
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [MarinaConfiguration]$Configuration
        ,
        [Parameter(Mandatory)]
        [string]$Name
    )
    process {
        $ret = [MarinaImageSet]::new($Name)
        $Configuration.ImageSets += @($ret)
        return $ret
    }

}
Export-ModuleMember -Function 'Add-MarinaImageSet'

Class MarinaConfiguration {
    MarinaConfiguration() {
        $this.Modules = @()
        $this.ImageSets = @()
    }
    
    # TODO - move this out of the class and into a function
    [void]ImportXml ([xml]$xml) {
        $root = $xml.documentelement
        if ($root.name -ne 'marina') {throw "Invalid XML configuration"}        
    }
    
    hidden [MarinaModule[]]$Modules
    hidden [MarinaImageSet[]]$ImageSets
}

Class MarinaModule {
    MarinaModule ($Name,$Path) {
        $this.Name = $Name
        $this.Path = Resolve-Path $Path -ErrorAction Stop
    }
    
    [string]$Name
    [System.Management.Automation.PathInfo]$Path
}

Class MarinaImageSet {
    MarinaImageSet ($Name) {
        $this.Name = $Name
    }
    
    [string]$Name
}