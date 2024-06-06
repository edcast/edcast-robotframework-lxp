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