*** Settings ***

Documentation  Locators with respect card varians menu functionality

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${uploaded_content_tab}         //*[text()='Uploaded Content']/..

###############################################################################################

*** Keywords ***
Click Uploaded Content Tab
  	Wait and Click   ${uploaded_content_tab} 

