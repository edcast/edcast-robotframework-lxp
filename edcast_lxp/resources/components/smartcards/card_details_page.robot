*** Settings ***

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${uploaded_image}            //img[@alt='User provided image']
${card_menu_button}          //button[starts-with(@aria-label, 'Actions for this SmartCard:')]

###############################################################################################

*** Keywords ***
Get Card Image
    Wait Until Element Is Visible   ${uploaded_image}
    ${uploaded_card_image_file}=    Capture Element Screenshot    ${uploaded_image}   card_image_screenshot.png
    [Return]                        ${uploaded_card_image_file}

Open SmartCard Actions Menu
    Wait and Click                  ${card_menu_button}


