*** Settings ***

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${uploaded_image}            //img[@alt='User provided image']

###############################################################################################

*** Keywords ***
Get Card Image
    Wait Until Element Is Visible   ${uploaded_image}
    ${uploaded_card_image_file}=    Capture Element Screenshot    ${uploaded_image}   card_image_screenshot.png
    [Return]                        ${uploaded_card_image_file}


