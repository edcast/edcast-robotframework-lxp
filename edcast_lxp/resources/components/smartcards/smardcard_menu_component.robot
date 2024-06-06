*** Settings ***

Documentation  Locators with respect profile menu navigation functionality

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${uploaded_content_tab}         //*[text()='Uploaded Content']/..

###############################################################################################

*** Keywords ***
Click Uploaded Content Tab
  	Wait and Click   ${uploaded_content_tab} 

