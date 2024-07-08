*** Settings ***

Resource  ../../../resources/common/common_import.robot
Resource  ../../../resources/components/nav_header/create_menu.robot
Resource  ../../../resources/components/smartcards/smardcard_menu_component.robot
Resource  ../../../resources/components/smartcards/create_uploaded_content_card.robot
Resource  ../../../resources/components/upload/upload_file_modal.robot
Resource  ../../../resources/components/profile/content_page.robot
Resource  ../../../resources/components/smartcards/card_details_page.robot

#################################################

*** Test Cases ***
Verify Upload Smartcard Creation
    [Tags]                                  regression
    [Teardown]                              Close Browser
    ${card_title}=                          Generate Random String
    Open Connection With Valid Credentials  ${USER_EMAIL_${ENV}}   ${USER_PASSWORD_${ENV}}
    Click Create Button
    Click Smartcard Button
    Click Uploaded Content Tab
    Upload File Button Click
    Upload File                             ${CURDIR}/../../../output/test_upload.png
    Click Upload Button
    Wait Until Image Uploaded
    Type Smart Card Title                   ${card_title}
    Type Smart Card Description             Some card decription
    Select Skills                           Kubernetes   Python
    Type Tags                               Tag1   Tag2
    Select Language                         English
    Select Content Type                     Article
    Select Duration                         1   20
    Set Privacy Settings                    Private
    Click Create Card Button
    Wait For Private ard Has Been Created Toast Message
    Card With Title Should Be Present In Card List   ${card_title}

Verify Upload Smartcard Image
    [Tags]                                  regression
    [Teardown]                              Close Browser
    ${card_title}=                          Generate Random String
    Open Connection With Valid Credentials  ${USER_EMAIL_${ENV}}   ${USER_PASSWORD_${ENV}}
    Click Create Button
    Click Smartcard Button
    Click Uploaded Content Tab
    Upload File Button Click               
    Upload File                             ${CURDIR}/../../../output/test_upload.png
    Click Upload Button
    Wait Until Image Uploaded
    Type Smart Card Title                   ${card_title}
    Type Smart Card Description             Some card decription
    Select Skills                           Kubernetes   Python
    Type Tags                               Tag1   Tag2
    Select Language                         English
    Select Content Type                     Article
    Select Duration                         1   20
    Set Privacy Settings                    Private
    Click Create Card Button
    Card With Title Should Be Present In Card List   ${card_title}
    Open Card From Content Page             ${card_title}
    ${test_card_image_path}=                Get Card Image
    Compare Images                          ${CURDIR}/../../../output/test_upload.png   ${test_card_image_path}   0.25
