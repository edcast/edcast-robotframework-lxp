*** Settings ***

Resource  ../../resources/common/common_import.robot
Resource  ../../resources/components/nav_header/more_button_menu.robot
Resource  ../../resources/components/admin/navigation_panel/navigation_panel.robot
Resource  ../../resources/components/admin/users/admin_users_page.robot
Resource  ../../resources/components/admin/users/add_non_sso_users_page.robot

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
    ...    File Should Exist                        ../../../test_files/bulk_import_sample.csv   File isn't downloaded

