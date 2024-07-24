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
############################################################################################### 
Verify Login Into Different Browsers With Session Expiring
    [Tags]                                  regression
    [Teardown]                              Close All Browsers
    Set Test Variable                       ${ENV}    QATRAUTOMATIONV11
    Open Connection With Browser Aliases To Page   chrome    browser1
    Login With Given User Name	           	${USER_EMAIL_${ENV}}	 ${USER_PASSWORD_${ENV}}
    Open Connection With Browser Aliases To Page   safari    browser2
    Login With Given User Name	           	${USER_EMAIL_${ENV}}	 ${USER_PASSWORD_${ENV}}
    Switch Browser                          browser1
    Click Me Tab
    Wait Until Location Contains            /log_in    60s    User isn't log out.
############################################################################################### 
Verify Switching Between Tabs 
    [Tags]                                  regression
    [Teardown]                              Close All Browsers
    Set Test Variable                       ${ENV}    PREVIEW
    Open Connection With Valid Credentials  ${USER_EMAIL_${ENV}}	 ${USER_PASSWORD_${ENV}}
    Execute Javascript                      window.open('')
    @{window_titles}=                       Get Window Titles
    Log List                                ${window_titles}
    Switch Window                           title=undefined
    Go To                                   ${LOGIN_URL_QATRAUTOMATIONV11}
    Wait Until Location Contains            ${LOGIN_URL_QATRAUTOMATIONV11}    60s    User isn't switched on new opened tab.
    Switch Window                           title=homepage - picassov3uspreview
    Wait Until Location Contains            ${LOGIN_URL_PREVIEW}    60s    User isn't switched on previous opened tab.
