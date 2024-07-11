*** Settings ***

Documentation  Locators with respect profile menu navigation functionality

Resource       ../../common/common_function.robot
Resource       ./create_card_common_page.robot

###############################################################################################

*** Variables ***

${pathway_title_input}                     //input[@id='Pathway-Title']
${pathway_description_input}               //div[@id='description']/p
${cancel_pathway_creation_button}          //button[@class='ed-btn ed-btn-neutral' and text()='Cancel']
${save_as_draft_pathway_button}            //button[@class='ed-btn ed-btn-neutral' and text()='Save As Draft']
${continue_with_pathway_creation_button}   //button[@class='ed-btn ed-btn-primary' and text()='Continue']
${create_new_smartcard_button}             //button[@id='smart_card_button_0']
${move_smartcard_pointer}                  //*[text()='%s']//ancestor::div[contains(@class, 'card-std-tile ed-ui pointer html-container')]//i[@class='icon-grip pointer']
${smartcard_titles_locator}                //div[contains(@id, 'card-title-')]/span/span

###############################################################################################

*** Keywords ***

Type Pathway Title
    [Arguments]                        ${pathway_title}
    Wait and Type                      ${pathway_title_input}            ${pathway_title}

Click Continue With Pathway Creation Button
    Wait and Click                     ${continue_with_pathway_creation_button}

Click Create New Smartcard Button
    Wait and Click                     ${create_new_smartcard_button}

Drag And Drop Smartcards Inside Pathway
    [Arguments]                        ${first_card_name}                 ${second_card_name}
    ${first_card_locator}              Replace String   ${move_smartcard_pointer}    %s   ${first_card_name}
    ${second_card_locator}             Replace String   ${move_smartcard_pointer}    %s   ${second_card_name}
    Wait Until Element Is Visible      ${first_card_locator}
    Wait Until Keyword Succeeds        5     2      Mouse Over   ${first_card_locator}
    Sleep                              2s
    Wait Until Keyword Succeeds        5     2      Mouse Down   ${first_card_locator}
    Sleep                              2s
    Wait Until Keyword Succeeds        5     2      Mouse Over   ${second_card_locator}
    Sleep                              2s
    Wait Until Keyword Succeeds        5     2      Mouse Out    ${second_card_locator}
    Sleep                              2s
    Wait Until Keyword Succeeds        5     2      Mouse Up     ${first_card_locator}
    Sleep                              2s
    
Get Pathway Smartcard Titles
    @{card_title_elements}=            Get WebElements           ${smartcard_titles_locator}
    ${size}=                           Get Length                ${card_title_elements}
    @{titles}=                         Create List
    FOR  ${item}  IN  @{card_title_elements}
        ${card_title_to_save}=                 Get Text          ${item}
        Append To List                         ${titles}         ${card_title_to_save}
    END
    Log To Console                     ${titles}
    [Return]                           ${titles}
