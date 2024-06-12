*** Settings ***

Documentation  Locators with respect more menu (groups, people, leaderboard, channels, bookmarks, admin, etc) functionality

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***
${admin_console_button}                //a[@href='/admin']

###############################################################################################

*** Keywords ***
Open Admin Console
  	Wait and Click   ${admin_console_button}