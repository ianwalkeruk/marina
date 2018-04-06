BeforeEachScenario {
    $here = Split-Path -Parent $MyInvocation.MyCommand.ScriptBlock.File
    $moduleParent = Resolve-Path (Join-Path $here '..\..')
    Import-Module "$moduleParent\Marina"
    
    $script:ValidXml = @'
<?xml version="1.0" encoding="utf-8"?>
<marina />
'@
}

Given 'we have a correctly-formatted (?<type>\S+) configuration file' {
    param ($type)
    $script:ConfigFolder = 'testdrive:\config'
    md $script:ConfigFolder
    switch ($type) {
        'XML' {
            $script:ConfigFileName = Join-Path $script:ConfigFolder 'correct.xml'
            Set-Content $script:ConfigFileName -Value $Script:ValidXml
            $script:ConfigFileName | Should Exist
        }
    }
}

When 'we call Import-MarinaConfiguration -FileName(?: -(?<type>.*))?' {
    param ($type)
    $params = @{
        FileName = $script:ConfigFileName
    }
    if ($type) {$params."$type" = $true}
    $script:config = Import-MarinaConfiguration @params
}

Then 'the configuration loads successfully' {
    $script:config | Should -Not -BeNullOrEmpty
}

AfterEachScenario {
    Remove-Module 'Marina'
}
