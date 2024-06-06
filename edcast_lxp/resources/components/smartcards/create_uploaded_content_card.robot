*** Settings ***

Documentation  Locators with respect profile menu navigation functionality

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${upload_file_button}     //button[@aria-label='Upload File Select Files to Upload required']
${file_input}             //input[@id='fsp-fileUpload']
${uploaded_image}         //img[@alt='User provided image']


###############################################################################################

*** Keywords ***
Upload File Button Click
    Wait and Click       ${upload_file_button}

Upload File
    [Arguments]          ${file_path}
    Wait Until Page Contains Element        ${file_input}
  	Choose File          ${file_input}      ${file_path}

Wait Until Image Uploaded
    Wait Until Page Contains Element   ${uploaded_image}        15s
    Page Should Contain Element        ${uploaded_image}        Image isn't uploaded. 

