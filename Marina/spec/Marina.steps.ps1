
BeforeEachFeature {
    $here = Split-Path -Parent $MyInvocation.MyCommand.ScriptBlock.File
    $script:ValidXml = Get-Content (Join-Path $here 'reference_config.xml')
    $script:moduleParent = Resolve-Path (Join-Path $here '..\..')
    Import-Module "$moduleParent\Marina"
}

Given 'we have a correctly-formatted (?<type>\S+) configuration file' {
    param ($type)
    $ConfigFolder = 'testdrive:\config'
    md $ConfigFolder
    switch ($type.ToUpper()) {
        'XML' {
            $ConfigFileName = Join-Path $ConfigFolder 'correct.xml'
            Set-Content -Path $ConfigFileName -Value $ValidXml
            $ConfigFileName | Should Exist
        }
        default {
            throw "Configuration file type |$type| not known"
        }
    }
}

When 'we call Import-MarinaConfiguration -FileName(?: -(?<type>.*))?' {
    param ($type)
    $params = @{
        FileName = $ConfigFileName
    }
    if ($type) {$params."$type" = $true}
    $config = Import-MarinaConfiguration @params
}

Then 'the configuration loads successfully' {
    $config | Should -Not -BeNullOrEmpty
}

When 'New-MarinaConfiguration is called with no parameters' {
    $ret = New-MarinaConfiguration
}

Given 'a blank MarinaConfiguration object' {
    $parent = New-MarinaConfiguration
}

When 'Add-(?<typename>\S+) is called with no parameters' {
    param($typename)
    $ret = $parent | &"Add-$typename"
}

Then 'a (?<typename>\S+) object is returned' {
    param ($typename)
    $ret | Should -BeOfType &"[$typename]"
}

And 'the number of (?<parentProperty>\S+) is (?<count>\d+)' {
    param ($parentProperty,$count)
    $parent.psobject.properties[$parentProperty].Count | Should -Be $count
}

AfterEachFeature {
    Remove-Module 'Marina'
}
