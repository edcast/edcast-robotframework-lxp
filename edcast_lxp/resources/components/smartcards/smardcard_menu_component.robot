*** Settings ***

Documentation  Locators with respect card varians menu functionality

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***

${card_type_tab}                //*[text()='%s' and @class='tab-label']/..

###############################################################################################

*** Keywords ***

Select Smartcard Type
    [Arguments]                 ${type_name}
    ${card_type_locator}        Replace String   ${card_type_tab}   %s   ${type_name}
    Wait and Click              ${card_type_locator}

Click Uploaded Content Tab
    Run Keyword                 Select Smartcard Type      Uploaded Content

Click Text Card Tab
    Run Keyword                 Select Smartcard Type      Text Card

