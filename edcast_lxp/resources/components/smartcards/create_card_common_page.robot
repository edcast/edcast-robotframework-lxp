*** Settings ***

Documentation  Locators with respect upload card creation

Resource       ../../common/common_function.robot
Resource       ../../components/nav_header/create_menu.robot
Resource       ../../components/smartcards/create_smartcard.robot

###############################################################################################

*** Variables ***

${skills_input}                           //*[text()='Skills']/..//input
${skills_option}                          //div[starts-with(@class, 'ed-multi-select__option') and text()='%s']
${tags_input}                             //label[text()='Tags']/..//input
${language_selector}                      //select[@id='language']
${content_type_selector}                  //select[@id='contentType']
${level_selector}                         //label[text()='Level']/../select
${hours_selector}                         //select[@id='hours']
${mins_selector}                          //select[@id='mins']
${privacy_radio_button}                   //span[text()='%s']//preceding-sibling::input
${create_card_button}                     //button[@id='create-card-btn']
${private_card_created_toast_message}     //span[text()='Your private card has been created.']
${public_card_created_toast_message}      //span[text()='Your card has been published publicly and will be accessible to everyone.']

###############################################################################################

*** Keywords ***

Select Skills
    [Arguments]                        @{skill_names}
    FOR  ${skill}  IN  @{skill_names}
        Wait and Type                  ${skills_input}           ${skill}\n
        ${selected_skill}=             Replace String            ${skills_option}   %s   ${skill}
        Wait and Click                 ${selected_skill}
    END

Type Tags
    [Arguments]                        @{tags_names}
    FOR  ${tag}  IN  @{tags_names}
        Wait and Type                  ${tags_input}                  ${tag}\n
    END

Select Language
    [Arguments]                        ${language_name}
    Wait and Click                     ${language_selector}
    Select From List By Label          ${language_selector}            ${language_name}

Select Content Type
    [Arguments]                        ${content_type_name}
    Wait and Click                     ${content_type_selector}
    Select From List By Label          ${content_type_selector}        ${content_type_name}

Select Duration
    [Arguments]                        ${hours}   ${mins}
    Wait and Click                     ${hours_selector}
    Select From List By Value          ${hours_selector}               ${hours}
    Wait and Click                     ${mins_selector}
    Select From List By Value          ${mins_selector}                ${mins}

Set Privacy Settings
    [Arguments]                        ${privacy_setting}
    ${seleted_privacy_option}          Replace String   ${privacy_radio_button}   %s   ${privacy_setting}
    Wait and Click                     ${seleted_privacy_option}

Click Create Card Button
    Wait and Click                     ${create_card_button}

Wait For Private Card Has Been Created Toast Message
    Wait Until Element Is Visible      ${private_card_created_toast_message}    error=Card creation message doesn't appear

Wait For Public Card Has Been Created Toast Message
    Wait Until Element Is Visible      ${public_card_created_toast_message}     error=Card creation message doesn't appear
