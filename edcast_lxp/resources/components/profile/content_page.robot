*** Settings ***

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${card_title_locator}                   //span[text()='%s']
${card_container}                       ${card_title_locator}/ancestor::div[starts-with(@class, 'card-std-tile ed-ui pointer')]

###############################################################################################

*** Keywords ***
Card With Title Should Be Present In Card List
  	[Arguments]                         ${card_title}
    ${expected_card}                    Replace String   ${card_title_locator}   %s   ${card_title}
    Wait Until Element Is Visible       ${expected_card}   15s   Card isn't present on content page.

Open Card From Content Page
  	[Arguments]                         ${card_title}
    ${expected_card_container}          Replace String   ${card_container}   %s   ${card_title}
    Wait and Click                      ${expected_card_container}
