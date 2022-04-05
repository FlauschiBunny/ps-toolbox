<#
.SYNOPSIS
    Replaces matches of the pattern in all InputFiles
.DESCRIPTION
    All inputfiles are checked for the regex pattern. Matches will be replaced by the replacement. The use of an dedicated encoding is possible. 
.EXAMPLE
    PS C:\> gci *.txt | Replace-Regex.ps1 -Pattern "[abc]" -Replacement "Hello"
    Explanation of what the example does
.INPUTS
    Pattern - a regex pattern
    Replacement - the replacement for the matched strings
    Encoding - optional encoding, otherwise default is used
    InputFiles - the Files to be processed, pipeline input is possible
.OUTPUTS
    none
.NOTES
    
#>
[CmdletBinding(SupportsShouldProcess)]
param (
    # Everything matching this pattern will be replaced
    [Parameter(Mandatory)]
    [string]
    $Pattern,
    # Parameter help description
    [Parameter(Mandatory)]
    [string]
    $Replacement,
    # optional Encoding
    [Parameter()]
    [ValidateSet("Ascii", "BigEndianUnicode", "BigEndianUTF32", "Byte", "Oem", "Unicode", "UTF32", "UTF8", "UTF7", "Default")]
    [string]
    $Encoding = "Default",
    # Case sensitive or not?
    [Parameter(Mandatory=$false)]
    [Switch]
    $CaseSensitive = $false,
    # Path of the files to replace in
    [Parameter(Mandatory, ValueFromPipeline, ValueFromRemainingArguments)]
    [string[]]
    $InputFiles
)
begin {

}
process {
  ForEach ($InputFile in $InputFiles){
    $content = Get-Content $InputFile -Encoding $Encoding
    if ($CaseSensitive){
        $replacedContext = $content -creplace $Pattern, $Replacement
    }else{
        $replacedContext = $content -replace $Pattern, $Replacement
    }
    $replacedContext | Set-Content -Path $InputFile -Encoding $Encoding
  }
}
end {
        
}