#--------------------------------------------------------------------------------- 

Configuration SetIEHomePage
{
    Param
    (
        #Target nodes to apply the configuration  
        [String[]]$NodeName = $env:COMPUTERNAME,  
  
        #Specifies the URL for the home page of Internet Explorer.
        [Parameter(Mandatory)]  
        [ValidateNotNullOrEmpty()]  
        [String]$StartPageURL,  
  
        #Specifies the URL for the secondary home pages of Internet Explorer.
        [Parameter()]   
        [String]$SecondaryStartPagesURL,  
  
        #Set the value as 'Present'/'Absent', it indicates the IE home page is configured/unconfigured.
        [Parameter(Mandatory)]  
        [ValidateSet('Present','Absent')]  
        [String]$SetEnsure
    )
    
    Import-DSCResource -ModuleName xInternetExplorerHomePage

    Node "localhost"
    {
        xInternetExplorerHomePage IEHomePage
        {
            StartPage = $StartPageURL
            SecondaryStartPages = $SecondaryStartPagesURL
            Ensure = $SetEnsure
        }
    }
}

SetIEHomePage -StartPageURL "www.bing.com" -SecondaryStartPagesURL "www.google.com" -SetEnsure 'Present'
Start-DscConfiguration -Path .\SetIEHomePage  -Wait -Force -Verbose