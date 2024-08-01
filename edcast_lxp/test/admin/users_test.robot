*** Settings ***

Resource  ../../resources/common/common_import.robot
Resource  ../../resources/components/nav_header/more_button_menu.robot
Resource  ../../resources/components/admin/navigation_panel/navigation_panel.robot
Resource  ../../resources/components/admin/users/admin_users_page.robot
Resource  ../../resources/components/admin/users/add_non_sso_users_page.robot
Resource  ../../resources/utils/csv_utils.robot
Resource  ../../resources/utils/email_utils.robot
Resource  ../../resources/components/admin/users/member_import_preview_modal_page.robot
Resource  ../../resources/components/login/onboarding_user_page.robot

Library   AutoRecorder      mode=suite

#################################################

*** Test Cases ***
Download Sample User File Test
    [Tags]                                  regression
    [Teardown]                              Close Browser
	Open Connection With Valid Credentials  ${USER_EMAIL_${ENV}}	 ${USER_PASSWORD_${ENV}}
    Click More Button
    Open Admin Console
    Open Users Page
    Click Add User Button
    Click Download Sample File
    Wait Until Keyword Succeeds              
    ...    30s
    ...    3s
    #...    File Should Exist                 ${CURDIR}/../../../test_files/bulk_import_sample.csv   File isn't downloaded
    ...    File Should Exist                 /Users/anazarenko/Downloads/bulk_import_sample.csv     File isn't downloaded

Read CSV User File Test
    [Tags]                                   regression
    Read CSV File                            ${CURDIR}/../../output/bulk_import_sample.csv

Remove Line From CSV User File Test
    [Tags]                                   regression    
    @{lines}=                                Remove Line From CSV File Lines   csv_file_path=${CURDIR}/../../output/bulk_import_sample.csv   line_for_removing=,,,,,
    Write Lines To CSV File                  ${CURDIR}/../../output/test_bulk_import_sample.csv     @{lines}

Write Line To CSV User File Test
    [Tags]                                   regression    
    @{lines}=                                Create List   first_name,last_name,email,groups,picture_url,password    Danish+123,Pandhare+123,danish@123.com,,,Password@123
    Write Lines To CSV File                  ${CURDIR}/../../output/test_bulk_import_sample.csv     @{lines}

Look For Invitation Email Test
    [Tags]                                   regression  
    Wait For Invitation Link                 inviteedcastuser@gmail.com

User Onboarding Test
    [Tags]                                   regression  
    [Teardown]                               Close Browser
    ${users_csv_file_path}=                  Replace Variables        ${CURDIR}/../../output/test_bulk_import_sample.csv
    ${new_user_firstname}=                   Generate Random String   5   abcdefghijklmnoprstuvwxyz
    ${new_user_lastname}=                    Generate Random String   10
    ${new_user_email}=                       Replace Variables        inviteedcastuser+${new_user_firstname}@gmail.com
    ${user_full_line}=                       Replace Variables        ${new_user_firstname},${new_user_lastname},${new_user_email},,,Password@123
    @{lines}=                                Create List   first_name,last_name,email,groups,picture_url,password    ${user_full_line}

    Write Lines To CSV File                  ${users_csv_file_path}   @{lines}
    Open Connection With Valid Credentials   ${USER_EMAIL_${ENV}}	  ${USER_PASSWORD_${ENV}}
    Click More Button
    Open Admin Console
    Open Users Page
    Click Add User Button
    Upload Users File                        ${users_csv_file_path}
    Click Preview Button
    Member Import Preview Modal Should Be Open
    Click Import Button
    ${invitation_link}=                      Wait For Invitation Link   ${new_user_email}
    Go To                                    ${invitation_link}
    Check Sign Prompt Checkbox
    Click Next Step Button
    Type And Select User Interest Topic      Python
    Select User Learning Level
    Click Add Buttton
    Click Next Step Button
    Sleep                                    3s
    Click Skip Buttton
    Click Lets Get Started Button
    Wait Until Location Does Not Contain     /onboarding       15s        Onboarding isn't completed.

Read CSV File Test With Errors
    [Tags]                                   regression
    [Documentation]                          Negative cases to check how catching errors works
    [Teardown]                               Run Keyword If Timeout Occurred          Log To Console        This text won't be in console as timeout error isn't reached.
    Log To Console                           Catching errors by 'Run Keyword And Expect Error' keyword
    ${msg}=    Run Keyword And Expect Error  *      Read CSV File        ${CURDIR}/../../output/incorrect_file_name.csv
    Should Contain                           ${msg}    FileNotFoundError

    Log To Console                           Catching errors by 'Run Keyword And Ignore Error' keyword
    Run Keyword And Ignore Error             Read CSV File        incorrect_file_path

    Log To Console                           Avoid errors by 'Run Keyword And Ignore Error' and 'Wait Until Keyword Succeeds' keyword
    Run Keyword And Ignore Error	         Wait Until Keyword Succeeds	1s	3s	My keyword

    Log To Console                           Generating error
    TRY
       Read CSV File                            incorrect_file_path
    EXCEPT   AS    ${message}
       Log to console    Error occurred: ${message}
    END