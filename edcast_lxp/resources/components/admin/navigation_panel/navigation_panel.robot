*** Settings ***

Documentation  Locators with respect admin navigation menu functionality

Resource       ../../../common/common_function.robot

###############################################################################################

*** Variables ***
${accounts_menu_button}                //span[@class='name' and text()='Accounts']
${users_menu_button}                   //span[@class='name' and text()='Users']

###############################################################################################

*** Keywords ***
Open Accounts Menu
  	Wait and Click   ${accounts_menu_button}

Open Users Page
    Open Accounts Menu
  	Wait and Click   ${users_menu_button}