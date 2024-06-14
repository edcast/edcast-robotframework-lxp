*** Settings ***
Library    String
Library    Collections
Library    ImapLibrary2

*** Variables ***


*** Keywords ***

Read All Emails
    Open Mailbox    host=imap.gmail.com   user=inviteedcastuser@gmail.com    password=ajwyqixmkbausfal   folder=SPAM
    Mark All Emails As Read
    Close Mailbox

Wait For Invitation Link
    [Arguments]     ${recipient}
    Open Mailbox    host=imap.gmail.com   user=inviteedcastuser@gmail.com    password=ajwyqixmkbausfal   folder=SPAM
    ${latest}=      Wait For Email    recipient=${recipient}    timeout=300
    ${parts} =    Walk Multipart Email    ${LATEST}
    FOR    ${i}    IN RANGE    ${parts}
        Walk Multipart Email    ${latest}
        ${content-type} =    Get Multipart Content Type
        Continue For Loop If    '${content-type}' != 'text/html'
        ${payload} =    Get Multipart Payload    decode=True
        Should Contain    ${payload}    Start Now
        @{links} =   Get Links From Email   ${latest}
    END
    Close Mailbox
    ${invitation_link}=   Get From List    ${links}   0
    [Return]   ${invitation_link}

Multipart Email Verification
    Open Mailbox    host=imap.gmail.com    user=email@domain.com    password=secret
    ${LATEST} =    Wait For Email    sender=noreply@domain.com    timeout=300
    ${parts} =    Walk Multipart Email    ${LATEST}
    FOR    ${i}    IN RANGE    ${parts}
        Walk Multipart Email    ${LATEST}
        ${content-type} =    Get Multipart Content Type
        Continue For Loop If    '${content-type}' != 'text/html'
        ${payload} =    Get Multipart Payload    decode=True
        Should Contain    ${payload}    your email
        ${HTML} =    Open Link From Email    ${LATEST}
        #${HTML}    Your email
    END
    Close Mailbox
    
   
