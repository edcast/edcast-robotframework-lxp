*** Settings ***

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${upload_button}         //*[@title='Upload']

###############################################################################################

*** Keywords ***
Click Upload Button
  	Wait and Click   ${upload_button} 