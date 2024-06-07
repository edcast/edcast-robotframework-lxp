*** Settings ***

Resource  ../../../resources/common/common_import.robot
Resource  ../../../resources/components/nav_header/create_menu.robot
Resource  ../../../resources/components/smartcards/smardcard_menu_component.robot
Resource  ../../../resources/components/smartcards/create_uploaded_content_card.robot
Resource  ../../../resources/components/upload/upload_file_modal.robot

#################################################

*** Test Cases ***
Verify Upload Smartcard Creation
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
    Type Smart Card Title                   Some card title
    Type Smart Card Description             Some card decription
    Select Skills                           Kubernetes   Python
    Type Tags                               Tag1   Tag2
    Select Language                         English
    Select Content Type                     Article
    Select Duration                         1   20
    Set Privacy Settings                    Private
    Click Create Card Button
