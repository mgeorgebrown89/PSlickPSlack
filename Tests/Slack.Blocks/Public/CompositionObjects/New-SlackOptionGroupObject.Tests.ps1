# If the module is already in memory, remove it
Get-Module Slack | Remove-Module -Force

# Import the module from the local path, not from the users Documents folder
$repoRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent (Split-Path -Parent ((Split-Path -Parent $MyInvocation.MyCommand.Path)))))
$ModuleRoot = $repoRoot + "\Slack"
Import-Module $ModuleRoot -Force 

$slackContent = Get-Content $ModuleRoot\SlackDefaults.json | ConvertFrom-Json
$SlackUri = $slackContent.slackwebhook
$SlackHeaders = @{Authorization = ("Bearer " + $slackContent.slacktoken) }

InModuleScope -ModuleName Slack {
    $functionName = (($PSCommandPath -split '\\')[-1]) -replace ".Tests.ps1", ""
    $slackTestUri = "https://slack.com/api/api.test" 
    $ContentType = "application/json; charset=utf-8"
    #Slack Option Group
    $options = @()
    $label = "Slack Option Group"
    $optionGroup = New-SlackOptionGroupObject -label $label -SlackOptions $options

    Describe "$functionName | Unit Tests" -Tags "Unit" {
        Context "Slack Option Group Object | Unit Tests" {
    
            $properties = ("label", "options")
            $propertyCount = $properties.Count
    
            It "An object is created" {
                [bool]$optionGroup | Should -Be $true
            }
            It "has plain_text Text Object as label: `"$label`"" {
                $optionGroup.label.type | Should -Be "plain_text"
                $optionGroup.label.text | Should -Be $label
            }
            It "has property count $propertyCount" {
                $optionGroup.PSObject.Properties.Name | Should -HaveCount $properties.Count
            }
            foreach ($property in $properties) {
                It "has a $property property" {
                    [bool]($optionGroup.PSObject.Properties.Name -match $property) | Should Be $true
                }
            }
            It "is valid JSON" {
                $optionGroup | ConvertTo-Json -Depth 100
            }
        }
    }
}