begin {
    # If the module is already in memory, remove it
    Get-Module PSlickPSlack | Remove-Module -Force

    # Import the module from the local path, not from the users Documents folder
    Import-Module .\PSlickPSlack\PSlickPSlack.psm1 -Force 
    $functionName = $MyInvocation.MyCommand -replace ".Tests.ps1", ""

    #Slack Option Object
    $text = "Slack Object 1"
    $value = 1
    $optionObject = New-SlackOptionObject -text $text -value $value

    #Slack Option Object with url
    $text1 = "Slack Object 2 (with url)"
    $value1 = 2
    $url = "https://github.com/mgeorgebrown89/PSlickPSlack"
    $optionObjectWithUrl = New-SlackOptionObject -text $text1 -value $value1 -url $url
}
process {
    Describe "$functionName | Unit Tests" -Tags "Unit" {
        Context "Slack Option Object | Unit Tests" {
    
            $properties = ("text", "value")
            $propertyCount = $properties.Count
    
            It "An object is created" {
                [bool]$optionObject | Should -Be $true
            }
            It "has plain_text Text Object with text: `"$text`"" {
                $optionObject.text.type | Should -Be "plain_text"
                $optionObject.text.text | Should -Be $text
            }
            It "has text `"$value`"" {
                $optionObject.value | Should -Be $value
            }
            It "has property count $propertyCount" {
                $optionObject.PSObject.Properties.Name | Should -HaveCount $properties.Count
            }
            foreach ($property in $properties) {
                It "has a $property property" {
                    [bool]($optionObject.PSObject.Properties.Name -match $property) | Should Be $true
                }
            }
            It "is valid JSON" {
                $optionObject | ConvertTo-Json -Depth 100
            }
        }
    }
    Describe "$functionName | Unit Tests" -Tags "Unit" {
        Context "Slack Option Object with URL | Unit Tests" {
        
            $properties = ("text", "value", "url")
            $propertyCount = $properties.Count
        
            It "An object is created" {
                [bool]$optionObjectWithUrl | Should -Be $true
            }
            It "has plain_text Text Object with text: `"$text1`"" {
                $optionObjectWithUrl.text.type | Should -Be "plain_text"
                $optionObjectWithUrl.text.text | Should -Be $text1
            }
            It "has value `"$value1`"" {
                $optionObjectWithUrl.value | Should -Be $value1
            }
            It "has property count $propertyCount" {
                $optionObjectWithUrl.PSObject.Properties.Name | Should -HaveCount $properties.Count
            }
            foreach ($property in $properties) {
                It "has a $property property" {
                    [bool]($optionObjectWithUrl.PSObject.Properties.Name -match $property) | Should Be $true
                }
            }
            It "is valid JSON" {
                $optionObjectWithUrl | ConvertTo-Json -Depth 100
            }
        }
    }
}