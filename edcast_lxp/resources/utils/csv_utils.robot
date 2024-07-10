*** Settings ***
Library	 	Collections
Library		String
Library 	   OperatingSystem

*** Variables ***


*** Keywords ***
Read CSV File
   [Arguments]         ${csv_file_path}
   ${csv}              Get File           ${csv_file_path}
   @{lines}            Split To Lines     ${csv}
   FOR  ${line}  IN  @{lines}
       Log To Console   ${line}
   END
   [Return]  @{lines}

Remove Line From CSV File Lines
    [Arguments]         ${csv_file_path}   ${line_for_removing}
    @{lines}=           Read CSV File      ${csv_file_path}
    Remove Values From List    ${lines}    ${line_for_removing}
    FOR  ${line}  IN  @{lines}
       Log To Console   ${line}
    END
    [Return]   @{lines}

Write Lines To CSV File
    [Arguments]         ${csv_file_path}   @{lines}
    Create File         ${csv_file_path}
    FOR  ${line}  IN  @{lines}
       Append To File   ${csv_file_path}   ${line}\n
    END
    
   
