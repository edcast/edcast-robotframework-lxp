
*** Settings ***

Documentation  Locators with respect admin navigation menu functionality

Resource       ../../../common/common_function.robot

###############################################################################################

*** Variables ***
${modal_header}                //div[text()='Member Import Preview']
${import_button}               //button[text()='Import']

###############################################################################################

*** Keywords ***
Member Import Preview Modal Should Be Open
  	Wait Until Element Is Visible   ${modal_header}    30s   Preview modal isn't opened.

Click Import Button
   Wait and Click   ${import_button}
   Wait Until Page Does Not Contain Element   ${import_button}   30s   Preview modal doesn't disappear after click on import button.