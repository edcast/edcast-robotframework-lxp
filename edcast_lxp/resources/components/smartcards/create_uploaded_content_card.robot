*** Settings ***

Documentation  Locators with respect profile menu navigation functionality

Resource       ../../common/common_function.robot
Resource       ../../components/nav_header/create_menu.robot
Resource       ../../components/smartcards/smardcard_menu_component.robot
Resource       ../../components/upload/upload_file_modal.robot

###############################################################################################

*** Variables ***
${upload_file_button}                     //button[@aria-label='Upload File Select Files to Upload required']
${file_input}                             //input[@id='fsp-fileUpload']
${uploaded_image}                         //img[@alt='User provided image']
${title_input}                            //input[@name='title']
${description_input}                      //div[@id='message']
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
Upload File Button Click
    Wait and Click                     ${upload_file_button}

Upload File
    [Arguments]                        ${file_path}
    Wait Until Page Contains Element   ${file_input}
  	Choose File                        ${file_input}            ${file_path}

Wait Until Image Uploaded
    Wait Until Page Contains Element   ${uploaded_image}        15s
    Page Should Contain Element        ${uploaded_image}        Image isn't uploaded. 

Type Smart Card Title
    [Arguments]                        ${smartcard_title}
    Wait Until Element Is Visible      ${title_input}
    Clear Element Text                 ${title_input}
    Input Text                         ${title_input}            ${smartcard_title}

Type Smart Card Description
    [Arguments]                        ${smartcard_decription}
    Wait Until Element Is Visible      ${description_input}
    Clear Element Text                 ${description_input}
    Input Text                         ${description_input}      ${smartcard_decription}

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

Create Upload Card
    [Arguments]                             &{card_details} 
    Click Create Button
    Click Smartcard Button
    Click Uploaded Content Tab
    Upload File Button Click
    Upload File                             ${CURDIR}/../../../output/test_upload.png
    Wait Until Back Button Is Present
    Click Upload Button
    Wait Until Image Uploaded
    ${are_skill_names_added}=           Run Keyword And Return Status           Get From Dictionary     ${card_details}   skill_names   @{Empty}
    ${are_tag_names_added}=             Run Keyword And Return Status           Get From Dictionary     ${card_details}   tags_names    @{Empty}
    Run Keyword If  '${card_details.get("smartcard_title")}'!='${None}'         Type Smart Card Title                   ${card_details.get("smartcard_title")}
    Run Keyword If  '${card_details.get("smartcard_decription")}'!='${None}'    Type Smart Card Description             ${card_details.get("smartcard_decription")}
    Run Keyword If  '${are_skill_names_added}'=='${True}'                       Select Skills                           @{card_details.get("skill_names")}
    Run Keyword If  '${are_tag_names_added}'=='${True}'                         Type Tags                               @{card_details.get("tags_names")}
    Run Keyword If  '${card_details.get("language_name")}'!='${None}'           Select Language                         ${card_details.get("language_name")}
    Run Keyword If  '${card_details.get("content_type_name")}'!='${None}'       Select Content Type                     ${card_details.get("content_type_name")}
    Run Keyword If  '${card_details.get("hours")}'!='${None}'                   Select Duration                         ${card_details.get("hours")}   ${card_details.get("mins")}
    Run Keyword If  '${card_details.get("privacy_setting")}'!='${None}'         Set Privacy Settings                    ${card_details.get("privacy_setting")}
    Click Create Card Button

