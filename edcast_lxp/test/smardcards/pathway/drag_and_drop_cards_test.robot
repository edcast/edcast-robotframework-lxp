*** Settings ***

Resource  ../../../resources/common/common_import.robot
Resource  ../../../resources/components/smartcards/smardcard_menu_component.robot
Resource  ../../../resources/components/smartcards/create_uploaded_content_card.robot
Resource  ../../../resources/components/smartcards/create_pathway_page.robot

#################################################

*** Test Cases ***

Verify Drag And Drop Smartcards While Pathway Creation
    [Tags]                                   regression
    [Teardown]                               Close Browser
    Open Connection With Valid Credentials   ${USER_EMAIL_${ENV}}   ${USER_PASSWORD_${ENV}}
    Click Create Button
    Click Pathway Button
    ${pathway_title}=                        Generate Random String
    Type Pathway Title                       ${pathway_title}
    Click Continue With Pathway Creation Button
    Click Create New Smartcard Button
    #${card_title_1}=                        Generate Random String
    ${card_title_1}=                         Set Variable     Test1
    Click Text Card Tab
    Type Smart Card Title                     ${card_title_1}
    Click Create Card Button
    Click Create New Smartcard Button
    #${card_title_2}=                        Generate Random String
    ${card_title_2}=                          Set Variable     Test2
    Click Text Card Tab
    Type Smart Card Title                     ${card_title_2}
    Click Create Card Button
    Drag And Drop Smartcards Inside Pathway   ${card_title_1}   ${card_title_2}
    @{changed_cards}=                         Get Pathway Smartcard Titles
    ${index_of_changed_card}=                 Get Index From List   ${changed_cards}   ${card_title_2}
    Should Be Equal As Integers               ${index_of_changed_card}   0   msg=Card position isn't changed after drag and drop
