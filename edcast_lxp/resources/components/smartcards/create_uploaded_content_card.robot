*** Settings ***

Documentation  Locators with respect upload card creation

Resource       ../../common/common_function.robot
#Resource       ../../components/nav_header/create_menu.robot
#Resource       ../../components/smartcards/smardcard_menu_component.robot
Resource       ../../components/smartcards/create_card_common_page.robot
Resource       ../../components/upload/upload_file_modal.robot

###############################################################################################

*** Variables ***

${upload_file_button}                     //button[@aria-label='Upload File Select Files to Upload required']
${file_input}                             //input[@id='fsp-fileUpload']
${uploaded_image}                         //img[@alt='User provided image']
${title_input}                            //input[@name='title']
${description_input}                      //div[@id='message']

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
    Wait and Type                      ${title_input}            ${smartcard_title}

Type Smart Card Description
    [Arguments]                        ${smartcard_decription}
    Wait and Type                      ${description_input}      ${smartcard_decription}

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

