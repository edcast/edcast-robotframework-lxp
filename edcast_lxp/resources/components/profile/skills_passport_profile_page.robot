*** Settings ***

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${get_transript_button}                 //span[text()='Get Transcript']

###############################################################################################

*** Keywords ***
Click Get Transcript Button
   Wait and Click   ${get_transript_button}


