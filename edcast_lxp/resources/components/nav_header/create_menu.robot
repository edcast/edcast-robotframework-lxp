*** Settings ***

Documentation  Locators with respect creation menu (smartcard, pathway, journey, group, projet) functionality

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${smartcard_button}                //*[@class='icon-smartcard']/..

###############################################################################################

*** Keywords ***
Click Smartcard Button
  	Wait and Click   ${smartcard_button}
