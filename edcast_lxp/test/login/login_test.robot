*** Settings ***

Resource  ../../resources/common/common_import.robot

#################################################

*** Test Cases ***
Login to LXP with new browser
    [Tags]                                  regression
	Open Connection With Valid Credentials  ${USER_EMAIL_${ENV}}	 ${USER_PASSWORD_${ENV}}
############################################################################################### 
Logout from LXP
    [Tags]                                  regression
	Logout User
############################################################################################### 
Login with any using with same session
    [Tags]                                  regression
    [Teardown]                              Close All Browsers
    Login With Given User Name  ${USER_EMAIL_${ENV}}	 ${USER_PASSWORD_${ENV}}
############################################################################################### 
Verify Login Into Different Browsers
    [Tags]                                  regression
    [Teardown]                              Close All Browsers
    Open Connection With Browser Aliases To Page   chrome    browser1
    Login With Given User Name	           	${USER_EMAIL_${ENV}}	 ${USER_PASSWORD_${ENV}}
    Click Me Tab
    Open Connection With Browser Aliases To Page   safari    browser2
    Login With Given User Name	           	${USER_EMAIL_${ENV}}	 ${USER_PASSWORD_${ENV}}
    Switch Browser                          browser1
    Wait Until Location Contains            /me    60s    User isn't switched to chrome browser.
