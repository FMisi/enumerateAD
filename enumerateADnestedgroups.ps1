# PowerShell script for enumerating all groups (including nested groups) in Active Directory
# Created by FMisi
# 2023.03.23.

$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()

$PDC = ($domainObj.PdcRoleOwner).Name

$SearchString = "LDAP://"

$SearchString += $PDC + "/"

$DistinguishedName = "DC=$($domainObj.Name.Replace(".",',DC='))"

$SearchString += $DistinguishedName

$SearchString

$Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)

$objDomain = New-Object System.DirectoryServices.DirectoryEntry

$Searcher.SearchRoot = $objDomain

$Searcher.filter="(objectClass=Group)" # CHANGE THIS, another example: "name=Misi"

$Searcher.FindAll()

Foreach($obj in $Result)
{
    $obj.Properties.name
}
