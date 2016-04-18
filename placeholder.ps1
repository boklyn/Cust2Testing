Configuration FileResourceDemo
{
    Node "localhost"
    {
        File CreateFile {
            DestinationPath = 'C:\Temp\Test.txt'
            Ensure = "Present"
            Contents = 'Hello World!'
        }

        Log AfterDirectoryCopy
        {
            # The message below gets written to the Microsoft-Windows-Desired State Configuration/Analytic log
            Message = "Finished running the file resource with ID CreateFile"
            DependsOn = "[File]CreateFile" # This means run "CreateFile" first.
        }
    }

}