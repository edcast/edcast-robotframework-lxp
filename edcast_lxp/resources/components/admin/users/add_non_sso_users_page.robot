*** Settings ***

Documentation  Locators with respect add non-sso users page

Resource       ../../../common/common_function.robot

###############################################################################################

*** Variables ***
${download_sample_button}                //a[contains(@href, 'bulk_import_sample.csv')]
${upload_file_input}                     //input[@type='file']
${preview_button}                        //button[text()='Preview']

###############################################################################################

*** Keywords ***
Click Download Sample File
  	Wait and Click   ${download_sample_button}

Upload Users File
  	[Arguments]      ${csv_file_path}
	Wait Until Page Contains Element   ${upload_file_input}
  	Choose File                        ${upload_file_input}            ${csv_file_path}

Click Preview Button
  	Wait and Click   ${preview_button}