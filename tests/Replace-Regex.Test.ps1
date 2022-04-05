Describe "Test Replacing" {
    BeforeEach{
        "Hello World!" | Out-File test.txt
        "What a day!" | Out-File test2.txt
    }
        It "Replace from Pipeline Case sensitive" {
        Get-ChildItem *.txt | ..\Replace-Regex.ps1 -Pattern "[H|W]" -Replacement X -CaseSensitive
        Get-Content -path .\test.txt | Should -Be "Xello Xorld!" 
        Get-Content -path .\test2.txt | Should -Be "Xhat a day!" 
    }
    It "Replace from Pipeline Case insensitive" {
        Get-ChildItem *.txt | ..\Replace-Regex.ps1 -Pattern "[H|W]" -Replacement X
        Get-Content -path .\test.txt | Should -Be "Xello Xorld!" 
        Get-Content -path .\test2.txt | Should -Be "XXat a day!" 
    }
    It "Replace Case sensitive" {
        ..\Replace-Regex.ps1 -Pattern "[H|W]" -Replacement X -InputFiles ./test.txt,./test2.txt
        Get-Content -path .\test.txt | Should -Be "Xello Xorld!" 
        Get-Content -path .\test2.txt | Should -Be "XXat a day!" 
    }
    It "Replace Case sensitive, just one file" {
        ..\Replace-Regex.ps1 -Pattern "[H|W]" -Replacement X -InputFiles ./test.txt
        Get-Content -path .\test.txt | Should -Be "Xello Xorld!" 
    }
    AfterAll {
        Remove-Item *.txt
    }
}