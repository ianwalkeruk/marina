function Import-MarinaConfiguration {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true,ParameterSetName='FromXmlFile')]
		[string]$FileName
		,
		[Parameter(Mandatory=$false,ParameterSetName='FromXmlFile')]
		[switch]$Xml
	)
	process {
	}
}