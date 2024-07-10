*** Settings ***

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${upload_button}         //*[@title='Upload']
${back_button}           //div[@title='Go back']

###############################################################################################

*** Keywords ***
Click Upload Button
  	Wait and Click                           ${upload_button} 

Wait Until Back Button Is Present
    Wait Until Element Is Visible            ${back_button}