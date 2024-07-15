*** Settings ***

Documentation     A resource file for logging in to LXP
Resource          ../common/common_import.robot

*** Variables ***

*** Keywords ***
###############################################################################################
Open Connection With Valid Credentials
    [Arguments]    ${user_email}    ${user_password}
    [Documentation]    Opens a new browser and logs in using username and password provided.
    ...    To specify Browser profile and other details, please set parameter
    ...    accordingly in config.robot
    
    Open Browser To Page		    ${BROWSER}
    Login With Given User Name		${user_email}		${user_password}

###############################################################################################
Login With Given User Name
    [Arguments]	  ${user_email}    ${user_password}
    [Documentation]    Takes user to the login page and logine User with valid credential
    Delete All Cookies
    Type User Email       ${user_email}
    Type User Password    ${user_password}
    Select Terms And Conditions Checkbox
    Click Log In Buttton
    Wait Until Location Does Not Contain     /user/login       15s        User doesn't log in

###############################################################################################
Logout User
  	Click Profile Dropdown Button
  	Click Sign Out Button
    Wait Until Location Contains    /user/login       15s        User doesn't log out
  
############################################################################################### 
Open Browser To Page	
    [Arguments]    ${browser}
	Log    Opening Browser ${browser} to URL: ${LOGIN_URL_${ENV}}    console=yes
    ${desire_capabilities}=    Set Variable    ${EMPTY}
    ${SELENIUM_GRID_HUB}=        Set Variable If        "${browser}"=="edge"         http://localhost:9515         ${SELENIUM_GRID_HUB}          
    Set Suite Variable    ${desire_capabilities}
    Open Browser      ${LOGIN_URL_${ENV}}    ${browser}    None    ${SELENIUM_GRID_HUB}    ${desire_capabilities}    ${FF_PROFILE}
    Maximize Browser Window
    Set Selenium Implicit Wait    1s

 ############################################################################################### 
Open Connection With Browser Aliases To Page	
    [Arguments]    ${browser}   ${alias}
	Log    Opening Browser ${browser} to URL: ${LOGIN_URL_${ENV}}    console=yes
    ${desire_capabilities}=    Set Variable    ${EMPTY}
    ${SELENIUM_GRID_HUB}=        Set Variable If        "${browser}"=="edge"         http://localhost:9515         ${SELENIUM_GRID_HUB}          
    Set Suite Variable    ${desire_capabilities}
    Open Browser      ${LOGIN_URL_${ENV}}    ${browser}    ${alias}    ${SELENIUM_GRID_HUB}    ${desire_capabilities}    ${FF_PROFILE}
    Maximize Browser Window
    Set Selenium Implicit Wait    1s

###############################################################################################
Wait and Click    
    [Arguments]   ${locator}
    Wait Until Element Is Visible               ${locator}         ${TIMEOUT}
    Click Element								${locator}

###############################################################################################
Wait and Check    
    [Arguments]   ${locator}
    Wait Until Element Is Visible               ${locator}         ${TIMEOUT}
    Select Checkbox								${locator}

###############################################################################################
Wait and Type   
   [Arguments]     ${locator}     ${text}
   Wait Until Element Is Visible               ${locator}         ${TIMEOUT}
   Clear Element Text                          ${locator}
   Input Text                                  ${locator}         ${text}

###############################################################################################
Compare Images
   [Arguments]      ${reference_image_path}    ${test_image_path}    ${allowed_threshold}
   ${temp}=         Replace String     ${IMAGE_COMPARATOR_COMMAND}    expected_image_path     ${reference_image_path}
   ${command}=      Replace String     ${temp}    tested_image_path     ${test_image_path}
   Log              Executing: ${command}
   ${rc}            ${output}=     Run And Return Rc And Output     ${command}
   Log              Return Code: ${rc}
   Log              Return Output: ${output}
   ${result}        Evaluate    ${output} < ${allowed_threshold}
   Should be True   ${result}