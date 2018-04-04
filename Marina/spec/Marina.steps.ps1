Given 'we have a correctly-formatted configuration file' {
	md testdrive:\config
	Set-Content 'testdrive:\config\correct.xml' -Value @'
<?xml version="1.0" encoding="utf-8"?>
<marina />
'@
	'testdrive:\config\correct.xml' | Should Exist
}