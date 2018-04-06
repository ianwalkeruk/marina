BeforeEachScenario {
	$here = Split-Path -Parent $MyInvocation.MyCommand.ScriptBlock.File
	$moduleParent = Resolve-Path (Join-Path $here '..\..')
	Import-Module "$moduleParent\Marina"
}

Given 'we have a correctly-formatted configuration file' {
	$script:ConfigFolder = 'testdrive:\config'
	md $script:ConfigFolder
	$script:ConfigFileName = Join-Path $script:ConfigFolder 'correct.xml'
	Set-Content $script:ConfigFileName -Value @'
<?xml version="1.0" encoding="utf-8"?>
<marina />
'@
	$script:ConfigFileName | Should Exist
}

When 'we call Import-MarinaConfiguration' {
	$script:config = Import-MarinaConfiguration -FileName $script:ConfigFileName
}

Then 'the configuration loads successfully' {
	$script:config | Should -Not -BeNullOrEmpty
}

AfterEachScenario {
	Remove-Module 'Marina'
}
