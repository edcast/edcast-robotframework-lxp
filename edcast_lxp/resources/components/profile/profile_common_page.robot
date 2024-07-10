*** Settings ***

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${profile_tab}                          //button[@role='tab' and @aria-label='Profile']
${content_tab}                          //button[@role='tab' and @aria-label='Content']
${skills_passport_tab}                  //button[@role='tab' and @aria-label='Skills Passport']
${learning_queue_tab}                   //button[@role='tab' and @aria-label='Learning Queue']

###############################################################################################

*** Keywords ***

Click Skills Passport Tab
   Wait and Click   ${skills_passport_tab}

Click Content Tab
   Wait and Click   ${content_tab}
