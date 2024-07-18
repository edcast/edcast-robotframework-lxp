
*** Settings ***

Documentation  Locators with respect Login functionality

Resource        ../../common/common_function.robot

###############################################################################################

*** Variables ***

${username_input}                  //*[@id="email"]
${password_input}                  //*[@id="password"]
${terms_and_conditions_checkbox}   //*[@id='tandc']
${login_button}                    //button[@type="submit" and not(@disabled)]

###############################################################################################

*** Keywords ***

Type User Email
    [Arguments]	     ${user_email}
  	Wait and Type    ${username_input}    ${user_email}

Type User Password
    [Arguments]	     ${user_password}
  	Wait and Type    ${password_input}    ${user_password}

Select Terms And Conditions Checkbox
    Run Keyword And Ignore Error   Select Checkbox  ${terms_and_conditions_checkbox}

Click Log In Buttton
    Wait and Click   ${login_button} 
