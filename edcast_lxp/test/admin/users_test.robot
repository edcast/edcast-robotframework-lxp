*** Settings ***

Resource  ../../resources/common/common_import.robot
Resource  ../../resources/components/nav_header/more_button_menu.robot
Resource  ../../resources/components/admin/navigation_panel/navigation_panel.robot
Resource  ../../resources/components/admin/users/admin_users_page.robot
Resource  ../../resources/components/admin/users/add_non_sso_users_page.robot
Resource  ../../resources/utils/csv_utils.robot

#################################################

*** Test Cases ***
Download Sample User File
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
    ...    File Should Exist                 ${CURDIR}/../../../test_files/bulk_import_sample.csv   File isn't downloaded

Read CSV User File
    [Tags]                                   regression
    Read CSV File                            ${CURDIR}/../../output/bulk_import_sample.csv

Remove Line From CSV User File
    [Tags]                                   regression    
    @{lines}=                                Remove Line From CSV File Lines   csv_file_path=${CURDIR}/../../output/bulk_import_sample.csv   line_for_removing=,,,,,
    Write Lines To CSV File                  ${CURDIR}/../../output/test_bulk_import_sample.csv     @{lines}

Write Line To CSV User File
    [Tags]                                   regression    
    @{lines}=                                Create List   first_name,last_name,email,groups,picture_url,password    Danish+123,Pandhare+123,danish@123.com,,,Password@123
    Write Lines To CSV File                  ${CURDIR}/../../output/test_bulk_import_sample.csv     @{lines}
