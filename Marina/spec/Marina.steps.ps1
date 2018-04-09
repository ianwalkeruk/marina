
BeforeEachFeature {
    $here = Split-Path -Parent $MyInvocation.MyCommand.ScriptBlock.File
    $script:ValidXml = Get-Content (Join-Path $here 'reference_config.xml')
    $script:moduleParent = Resolve-Path (Join-Path $here '..\..')
    Import-Module "$moduleParent\Marina"
    
    $script:TestParameters = @{
        MarinaModule = @{
            Add = @{Name = 'TestModule'; Path = 'testdrive:\TestModule'}
        }
        MarinaModuleAlt = @{
            Add = @{Name = 'TestModuleAlt'; Path = 'testdrive:\TestModuleAlt'}
        }
        MarinaImageSet = @{
            Add = @{Name = 'TestImageSet'}
        }
    }
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

When 'Add-(?<typename>\S+) is called with (?<isAlt>alternate )?test parameters' {
    param ($typename,$isAlt)
    $testname = $typename
    if ($isAlt) {$testname += 'Alt'}
    $params = $testparameters."$testname".Add
    $ret = $parent | & "Add-$typename" @params
}

Then 'a (?<typename>\S+) object is returned' {
    param ($typename)
    $ret.GetType().Name | Should -Be $typename
}

And 'the number of (?<parentProperty>\S+) is (?<count>\d+)' {
    param ($parentProperty,$count)
    $value = $parent.psobject.properties[$parentProperty].Value
    $value.Count | Should -Be $count
}

Given '(?:a|an) (?<testmode>alternate test|test) module directory' {
    param ($testmode)
    switch ($testmode) {
        'test'           {$path = $testparameters.MarinaModule.Add.Path}
        'alternate test' {$path = $testparameters.MarinaModuleAlt.Add.Path}
    }
    mkdir $path
    $path | Should -Exist
}

AfterEachFeature {
    Remove-Module 'Marina'
}
