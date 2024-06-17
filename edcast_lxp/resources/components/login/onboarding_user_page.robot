
*** Settings ***

Documentation  Locators with respect Onboarding functionality

Resource        ../../common/common_function.robot

###############################################################################################

*** Variables ***

${password_input}                  //input[@aria-label='Enter Password']
${confirm_password_input}          //input[@aria-label='Confirm Password']
${sign_prompt_checkbox}            //input[@id='tandCheckbox']
${next_step_button}                //button[text()='Next']
${skip_button}                     //button[@type='submit']
${interest_topic_input}            //input[starts-with(@class, 'ed-multi-select__input')]
${interest_topic_option}           //div[starts-with(@class, 'ed-multi-select__option') and text()='%s']
${interest_level_selector}         //*[@id='select-level']
${interest_level_option}           (//*[@id='select-level']//option)[2]
${add_button}                      //button[text()='Add']
${let_get_started_button}          //button[text()="Let's Get Started"]

###############################################################################################

*** Keywords ***

Type User Password On Onboarding Page
    [Arguments]	     ${user_password}
  	Wait and Type    ${password_input}    ${user_password}

Confirm User Password
    [Arguments]	     ${user_password}
  	Wait and Type    ${confirm_password_input}    ${user_password}

Check Sign Prompt Checkbox
    Wait and Check   ${sign_prompt_checkbox}

Click Next Step Button
    Wait and Click               ${next_step_button}

Click Skip Buttton
    Wait and Click   ${skip_button}

Type And Select User Interest Topic
    [Arguments]	     ${topic}
    Wait and Type                  ${interest_topic_input}           ${topic}\n
    ${selected_skill}=             Replace String            ${interest_topic_option}   %s   ${topic}
    Wait and Click                 ${selected_skill}

Select User Learning Level
    Wait and Click   ${interest_level_selector}
    Wait and Click   ${interest_level_option}

Click Add Buttton
    Wait and Click   ${add_button}

Click Lets Get Started Button
    Wait and Click   ${let_get_started_button}
