function Invoke-SlackWebAPI {
    <#
    #>
    [CmdletBinding()]
    param(
        [string]
        $Token,

        [string]
        $REST_Method = 'POST',

        [string]
        #[ValidateSet()]
        $Method_Family,

        [PSCustomObject]
        $Body,

        [string]
        #[ValidateSet()]
        $ContentType = 'application/json;charset=iso-8859-1' 
    )

    $Uri = "https://slack.com/api/$Method_Family"
    $Headers = @{
        Authorization = "Bearer $token"
    }

    Invoke-RestMethod -Method $REST_Method -Uri $Uri -Headers $Headers -ContentType $ContentType -Body ($Body | ConvertTo-Json -Depth 100)
}