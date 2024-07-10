*** Settings ***

Resource       ../../common/common_function.robot
Resource       ../../utils/calendar_utils.robot

###############################################################################################

*** Variables ***

${search_user_to_assign_input}         //input[starts-with(@aria-label, 'Search Users ')]
${found_user_checkbox}                 //div[contains(text(), '%s')]/ancestor::tr//input
${start_date_button}                   //div[@class='date-picker' and text()='Start Date: ']
${due_date_button}                     //div[@class='date-picker' and text()='Due Date: ']
${assign_button}                       //button[text()='Assign']
${card_assigned_message}               //span[starts-with(text(), 'You have assigned this SmartCard to ')]

###############################################################################################

*** Keywords ***

Select Start Date
    [Arguments]                      ${start_date}
    Wait Until Element Is Visible    ${start_date_button}
    Scroll Element Into View         ${start_date_button}
    Wait and Click                   ${start_date_button}  
    Select Date In Calendar Picker   ${start_date}


Select Due Date
    [Arguments]                      ${due_date}
    Wait Until Element Is Visible    ${due_date_button}
    Scroll Element Into View         ${due_date_button}
    Wait and Click                   ${due_date_button}  
    Select Date In Calendar Picker   ${due_date}

Search For User To Assign
    [Arguments]                      ${user_name}
    Wait and Type                    ${search_user_to_assign_input}   ${user_name}
    ${found_user_locator}=           Replace String   ${found_user_checkbox}   %s   ${user_name}
    Wait and Check                   ${found_user_locator}

Click Assign Button On Assign Page
    Wait and Click                   ${assign_button}

Wait For Card Assigned To User Toast Message
    Wait Until Element Is Visible      ${card_assigned_message}     error=Card assigning message doesn't appear

