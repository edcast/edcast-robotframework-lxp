*** Settings ***

Documentation  Locators with respect creation menu (smartcard, pathway, journey, group, projet) functionality

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***

${smartcard_button}                //*[@class='icon-smartcard']/..
${pathway_button}                  //*[@class='icon-pathways']/..

###############################################################################################

*** Keywords ***

Click Smartcard Button
  	Wait and Click   ${smartcard_button}

Click Pathway Button
  	Wait and Click   ${pathway_button}

