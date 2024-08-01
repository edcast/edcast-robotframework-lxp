*** Settings ***

Resource  ../../../resources/common/common_import.robot
Resource  ../../../resources/components/smartcards/create_smartcard.robot

Library   AutoRecorder      mode=suite

#################################################

*** Test Cases ***
Verify Keyboard Actions For Card Description
    [Tags]                                  regression
    [Teardown]                              Close Browser
    Open Connection With Valid Credentials  ${USER_EMAIL_${ENV}}   ${USER_PASSWORD_${ENV}}
    ${card_description}=                    Set Variable   Card Description To Test Special Keywords
    Click Create Button
    Click Smartcard Button
    Click Text Card Tab
    Type Smart Card Description Into Special Description Frame   ${card_description}
    ${typed_description}=                    Get Smart Card Description From Special Description Frame
    Should Be Equal As Strings               ${card_description}   ${typed_description}   Description isn't typed.
    #select all text and remove it
    Switch To Special Description Frame
    Press Keys                               ${rte_description_editor_input}   COMMAND+A   DELETE
    Unselect Frame
    ${description_after_removing}=           Get Smart Card Description From Special Description Frame
    Should Be Equal As Strings               ${description_after_removing}   ${Empty}   Description isn't removed by keyboad action.
    