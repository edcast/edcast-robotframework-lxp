*** Settings ***

Resource  ../../../resources/common/common_import.robot
Resource  ../../../resources/components/smartcards/create_uploaded_content_card.robot
Resource  ../../../resources/components/profile/content_page.robot
Resource  ../../../resources/components/smartcards/card_details_page.robot
Resource  ../../../resources/components/smartcards/card_actions_menu.robot
Resource  ../../../resources/components/smartcards/assign_card_page.robot

#################################################

*** Test Cases ***
Verify Upload Smartcard Creation
    [Tags]                                  regression
    [Teardown]                              Close Browser
    ${card_title}=                          Generate Random String
    Open Connection With Valid Credentials  ${USER_EMAIL_${ENV}}   ${USER_PASSWORD_${ENV}}
    ${card_title}=                          Generate Random String
    @{skill_names}=                         Create List   Kubernetes   Python
    @{tags_names}=                          Create List   Tag1   Tag2
    &{card_details}=                        Create Dictionary   smartcard_title=${card_title}   smartcard_decription=Some card description  
    ...                                     skill_names=@{skill_names}   tags_names=@{tags_names}   language_name=English   content_type_name=Article   
    ...                                     hours=1   mins=20   privacy_setting=Private
    Create Upload Card                      &{card_details}
    Wait For Private Card Has Been Created Toast Message
    Card With Title Should Be Present In Card List   ${card_title}

Verify Upload Smartcard Image
    [Tags]                                  regression
    [Teardown]                              Close Browser
    Open Connection With Valid Credentials  ${USER_EMAIL_${ENV}}   ${USER_PASSWORD_${ENV}}
    ${card_title}=                          Generate Random String
    @{skill_names}=                         Create List   Kubernetes   Python
    @{tags_names}=                          Create List   Tag1   Tag2
    &{card_details}=                        Create Dictionary   smartcard_title=${card_title}   smartcard_decription=Test description  
    ...                                     tags_names=${tags_names}   language_name=Finnish (Suomi)   content_type_name=Article   
    ...                                     hours=0   mins=15   privacy_setting=Public
    Create Upload Card                      &{card_details}
    Wait For Public Card Has Been Created Toast Message
    Card With Title Should Be Present In Card List   ${card_title}
    Open Card From Content Page             ${card_title}
    ${test_card_image_path}=                Get Card Image
    Compare Images                          ${CURDIR}/../../../output/test_upload.png   ${test_card_image_path}   0.25

Verify Of Assigning For Upload Smartcard
    [Tags]                                  regression
    [Teardown]                              Close Browser
    ${card_title}=                          Generate Random String
    Open Connection With Valid Credentials  ${USER_EMAIL_${ENV}}   ${USER_PASSWORD_${ENV}}
    &{card_details}=                        Create Dictionary   smartcard_title=${card_title}   privacy_setting=Private
    Create Upload Card                      &{card_details}
    Wait For Private Card Has Been Created Toast Message
    Card With Title Should Be Present In Card List   ${card_title}
    Open Card From Content Page             ${card_title}
    Open SmartCard Actions Menu
    Click Assign Button
    Search For User To Assign               Danish
    ${today_date}=                          Get Today Date
    Select Start Date                       ${today_date}
    ${tomorrow_date}=                       Get Tomorrow Date
    Select Due Date                         ${tomorrow_date}
    Click Assign Button On Assign Page
    Wait For Card Assigned To User Toast Message
