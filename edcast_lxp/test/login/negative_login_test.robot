*** Settings ***
Resource         ../../resources/common/common_import.robot

Test Template    Login with invalid credentials should fail

*** Variables ***

*** Test Cases ***                USERNAME                  PASSWORD
Invalid User Name                 invalid                   ${USER_PASSWORD_${ENV}}
Invalid Password                  ${USER_EMAIL_${ENV}}      invalid
Invalid User Name and Password    invalid                   invalid
Empty User Name                   ${EMPTY}                  ${USER_PASSWORD_${ENV}}
Empty Password                    ${USER_EMAIL_${ENV}}      ${EMPTY}
Empty User Name and Password      ${EMPTY}                  ${EMPTY}

*** Keywords ***
Login with invalid credentials should fail
    [Arguments]    ${user_email}    ${user_password}
    [Teardown]                      Close Browser
    Open Browser To Page		    ${BROWSER}
    Type User Email                 ${user_email}
    Type User Password              ${user_password}
    Select Terms And Conditions Checkbox
    Click Log In Buttton
    Wait For Login Error Visiblity