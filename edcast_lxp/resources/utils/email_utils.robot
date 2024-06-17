*** Settings ***
Library    String
Library    Collections
Library    ImapLibrary2

*** Variables ***


*** Keywords ***

Read All Emails
    Open Mailbox    host=imap.gmail.com   user=inviteedcastuser@gmail.com    password=ajwyqixmkbausfal
    Mark All Emails As Read
    Close Mailbox


Delete All Emails For User
    Open Mailbox    host=imap.gmail.com   user=inviteedcastuser@gmail.com    password=ajwyqixmkbausfal
    Delete All Emails
    Close Mailbox

    Open Mailbox    host=imap.gmail.com   user=inviteedcastuser@gmail.com    password=ajwyqixmkbausfal   folder=SPAM
    Delete All Emails
    Close Mailbox

Wait For Invitation Link
    [Arguments]     ${recipient}
    Open Mailbox    host=imap.gmail.com   user=${recipient}    password=ajwyqixmkbausfal   folder=Inbox
    ${latest}=      Wait For Email    recipient=${recipient}     timeout=300
    ${parts} =      Walk Multipart Email    ${latest}
    FOR    ${i}    IN RANGE    ${parts}
        Walk Multipart Email   ${latest}
        ${content-type}=       Get Multipart Content Type
        Continue For Loop If   '${content-type}' != 'text/html'
        ${payload}=            Get Multipart Payload    decode=True
        Should Contain         ${payload}    Start Now
        @{links}=              Get Links From Email   ${latest}
    END
    Close Mailbox
    ${invitation_link}=        Get From List    ${links}   0
    [Return]                   ${invitation_link}

