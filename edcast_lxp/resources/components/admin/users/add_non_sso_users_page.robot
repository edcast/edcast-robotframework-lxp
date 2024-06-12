*** Settings ***

Documentation  Locators with respect add non-sso users page

Resource       ../../../common/common_function.robot

###############################################################################################

*** Variables ***
${download_sample_button}                //a[contains(@href, 'bulk_import_sample.csv')]

###############################################################################################

*** Keywords ***
Click Download Sample File
  	Wait and Click   ${download_sample_button}