*** Settings ***

Documentation  Locators with respect admin navigation menu functionality

Resource       ../../../common/common_function.robot

###############################################################################################

*** Variables ***
${add_user_button}                //button[text()='Add Users']

###############################################################################################

*** Keywords ***
Click Add User Button
  	Wait and Click   ${add_user_button}