*** Settings ***

Documentation  Locators with respect profile menu navigation functionality

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${sign_out_button}         //a[@href="/sign_out"]

###############################################################################################

*** Keywords ***
Click Sign Out Button
  	Wait and Click   ${sign_out_button} 

