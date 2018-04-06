$ValidXml = @'
<?xml version="1.0" encoding="utf-8"?>
<marina />
'@

BeforeEachScenario {
    $here = Split-Path -Parent $MyInvocation.MyCommand.ScriptBlock.File
    $moduleParent = Resolve-Path (Join-Path $here '..\..')
    Import-Module "$moduleParent\Marina"
}

Given 'we have a correctly-formatted (?<type>\S+) configuration file' {
    param ($type)
    $script:ConfigFolder = 'testdrive:\config'
    md $script:ConfigFolder
    switch ($type.ToUpper()) {
        'XML' {
            $script:ConfigFileName = Join-Path $script:ConfigFolder 'correct.xml'
            Set-Content -Path $script:ConfigFileName -Value $ValidXml
            Write-Host "|$(Get-Content -Path $script:ConfigFileName)|"
            $script:ConfigFileName | Should Exist
        }
        default {
            throw "Configuration file type |$type| not known"
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
