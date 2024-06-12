*** Settings ***

Documentation  Locators with respect header navigation functionality

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${profile_dropdown_button}         //div[@class='dropdown-wrapper ed-header--profile']
${more_button}                     //button[@aria-label='More options and features']
${create_button}                   //*[@id='createBtn']

###############################################################################################

*** Keywords ***
Click Profile Dropdown Button
  	Wait and Click   ${profile_dropdown_button} 

Click Create Button
  	Wait and Click   ${create_button}

Click More Button
  	Wait and Click   ${more_button}

