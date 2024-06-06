*** Settings ***

Resource  ../../../resources/common/common_import.robot
Resource  ../../../resources/components/nav_header/create_menu.robot
Resource  ../../../resources/components/smartcards/smardcard_menu_component.robot
Resource  ../../../resources/components/smartcards/create_uploaded_content_card.robot
Resource  ../../../resources/components/upload/upload_file_modal.robot

#################################################

*** Test Cases ***
Verify image uploading
    [Tags]                                  regression
    [Teardown]                              Close Browser
	Open Connection With Valid Credentials  ${USER_EMAIL_${ENV}}	 ${USER_PASSWORD_${ENV}}
    Click Create Button
    Click Smartcard Button
    Click Uploaded Content Tab
    Upload File Button Click
    Upload File                             ${CURDIR}/../../../output/test_upload.png
    Click Upload Button
    Wait Until Image Uploaded
    
    