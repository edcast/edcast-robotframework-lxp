*** Settings ***

Resource       ../../common/common_function.robot

###############################################################################################

*** Variables ***

${assign_menu_item}                   //li[@role='menuitem' and text()='Assign']
${assign_to_me_menu_item}             //li[@role='menuitem' and text()='Assign to Me']
${add_to_pathway_menu_item}           //li[@role='menuitem' and text()='Add to Pathway']

###############################################################################################

*** Keywords ***

Click Assign Button
    Wait and Click                   ${assign_menu_item}
