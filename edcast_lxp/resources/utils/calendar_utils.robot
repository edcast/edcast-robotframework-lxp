*** Settings ***
Library		String
Library		DateTime
Library     Collections

Resource    ../../resources/common/common_import.robot

*** Variables ***
${chosen_month_datapicker}               //div[@class='react-datepicker__current-month']
${next_month_button}                     //span[@class='react-datepicker__navigation-icon react-datepicker__navigation-icon--next']
${day_datapicker}                        //div[text()='%s']


*** Keywords ***
Get Tomorrow Date
   ${date}=            Get Current Date   increment=1 day  result_format=%B %Y %d
   Log To Console      ${date}
   [Return]            ${date}

Get Some Date
   [Arguments]         ${increment_value}
   ${date}=            Get Current Date   increment=${increment_value}  result_format=%B %Y %d
   Log To Console      ${date}
   [Return]            ${date}

Get Today Date
   ${date}=            Get Current Date  result_format=%B %Y %d
   Log To Console      ${date}
   [Return]            ${date}

Select Date In Calendar Picker
   [Arguments]         ${date}
   @{date_values}=     Split String   ${date}   separator=\ 
   ${month_value}=     Get From List       ${date_values}   0
   ${year_value}=      Get From List       ${date_values}   1
   ${day_value}=       Get From List       ${date_values}   2
   ${day_value_as_number}=   Convert To Integer   ${day_value}
   ${day_value_as_string}=   Convert To String    ${day_value_as_number}

   FOR  ${i}  IN  12
     Wait Until Element Is Visible     ${chosen_month_datapicker} 
    ${selected_month}=    Get Text     ${chosen_month_datapicker}
    ${is_correct_month_selected}=      Evaluate    '${selected_month}'=='${month_value}\ ${year_value}'
    Exit For Loop If                   ${is_correct_month_selected}
   END

   ${exact_day}                      Replace String   ${day_datapicker}   %s   ${day_value_as_string}
   Wait and Click                    ${exact_day} 

