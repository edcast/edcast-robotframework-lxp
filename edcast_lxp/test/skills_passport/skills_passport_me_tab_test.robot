*** Settings ***
Library   Pdf2TextLibrary

Resource  ../../resources/common/common_import.robot
Resource  ../../resources/components/profile/profile_common_page.robot
Resource  ../../resources/components/profile/skills_passport_profile_page.robot
Resource  ../../resources/utils/email_utils.robot


#################################################

*** Test Cases ***
Download User Transcription File Test
    [Tags]                                  regression
    [Teardown]                              Close Browser
    Open Connection With Valid Credentials  inviteedcastuser+yubnx@gmail.com	 ${USER_PASSWORD_${ENV}}
    Click Me Tab
    Click Skills Passport Tab
    Click Get Transcript Button
    ${transcript_file}=   Wait For Transcript PDF File            inviteedcastuser+yubnx@gmail.com
    ${text}=              Convert Pdf To Txt   ${transcript_file}
    Log To Console        ${text}
    Should Contain        container=${text}   item=Certificates\ (1)\n\nCertificate\nJavaSkillbox\n\nExperience:\ \ \ NA\ \ \ \ \ \ \ Level:\ \ \ Intermediate\ \ \ \ \ \ \ Credentials\:\ \ \ NA
    ...                   msg=PDF file doesn't contain information about certificates.
    Remove File           ${transcript_file}