# Get the path the script is executing from
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$here
# If the module is already in memory, remove it
Get-Module PSlickPSlack | Remove-Module -Force

# Import the module from the local path, not from the users Documents folder
Import-Module ..\PSlickPSlack.psm1 -Force 

Describe "New-SlackSectionBlock Unit Tests" -Tags "Unit" {
    $text = "Lorum au latin words and stuff."
    Context "Text Only Slack Section Block" {
        $block = New-SlackSectionBlock -text $text
        $properties = ("type", "text")

        It "has a type of section" {
            $block.type | Should Be "section"
        }
        It "has text `"$text`"" {
            $block.text.text | Should Be $text
        }
        It "has property count 2" {
            $block.PSObject.Properties.Name | Should -HaveCount $properties.Count
        }
        foreach ($property in $properties) {
            It "has a $property property" {
                [bool]($block.PSObject.Properties.Name -match $property) | Should Be $true
            }
        }
        It "is valid JSON" {
            $block | ConvertTo-Json -Depth 100
        }
    }
    Context "Text with block_id Slack Section Block" {
        $block_id = "blockABC123"
        $block = New-SlackSectionBlock -text $text -block_id $block_id
        $properties = ("type", "text", "block_id")
        
        It "has a type of section" {
            $block.type | Should Be "section"
        }
        It "has text `"$text`"" {
            $block.text.text | Should Be $text
        }
        It "has block_id `"$block_id`"" {
            $block.block_id | Should Be $block_id
        }
        It "has property count 3" {
            $block.PSObject.Properties.Name | Should -HaveCount $properties.Count
        }
        foreach ($property in $properties) {
            It "has a $property property" {
                [bool]($block.PSObject.Properties.Name -match $property) | Should Be $true
            }
        }
        It "is valid JSON" {
            $block | ConvertTo-Json -Depth 100
        }
    }
    Context "Text with Fields Slack Section Block" {
        $fields = @()
        $field1 = New-SlackTextObject -type mrkdwn -text $text
        $fields += $field1
        $field2 = New-SlackTextObject -type plain_text -text $text
        $fields += $field2
        $block = New-SlackSectionBlock -text $text -fields $fields
        $properties = ("type", "text", "fields")
        
        It "has a type of section" {
            $block.type | Should Be "section"
        }
        It "has text `"$text`"" {
            $block.text.text | Should Be $text
        }
        It "has property count 3" {
            $block.PSObject.Properties.Name | Should -HaveCount $properties.Count
        }
        foreach ($property in $properties) {
            It "has a $property property" {
                [bool]($block.PSObject.Properties.Name -match $property) | Should Be $true
            }
        }
        It "has field count 2" {
            $block.fields | Should -HaveCount $fields.Length
        }
        It "is valid JSON" {
            $block | ConvertTo-Json -Depth 100
        }
    }
    Context "Text with accessory Slack Section Block" {
        $accessory = New-SlackButtonElement -text "ButtonText" -action_id "ButtonAction_id"
        $block = New-SlackSectionBlock -text $text -accessory $accessory
        $properties = ("type", "text", "accessory")

        It "has a type of section" {
            $block.type | Should Be "section"
        }
        It "has text `"$text`"" {
            $block.text.text | Should Be $text
        }
        It "has property count 3" {
            $block.PSObject.Properties.Name | Should -HaveCount $properties.Count
        }
        foreach ($property in $properties) {
            It "has a $property property" {
                [bool]($block.PSObject.Properties.Name -match $property) | Should Be $true
            }
        }
        It "is valid JSON" {
            $block | ConvertTo-Json -Depth 100
        }
    }
}