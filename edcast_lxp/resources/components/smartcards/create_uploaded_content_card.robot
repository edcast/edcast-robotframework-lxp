*** Settings ***

Documentation  Locators with respect profile menu navigation functionality

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${upload_file_button}     //button[@aria-label='Upload File Select Files to Upload required']
${file_input}             //input[@id='fsp-fileUpload']
${uploaded_image}         //img[@alt='User provided image']
${title_input}            //input[@name='title']
${description_input}      //div[@id='message']
${skills_input}           //*[text()='Skills']/..//input
${skills_option}          //div[starts-with(@class, 'ed-multi-select__option') and text()='%s']
${tags_input}             //label[text()='Tags']/..//input
${language_selector}      //select[@id='language']
${content_type_selector}  //select[@id='contentType']
${level_selector}         //label[text()='Level']/../select
${hours_selector}         //select[@id='hours']
${mins_selector}          //select[@id='mins']
${privacy_radio_button}   //span[text()='%s']//preceding-sibling::input
${create_card_button}     //button[@id='create-card-btn']

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

