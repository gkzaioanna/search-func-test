*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${ENV}             https://uat.parkbee.com
${BROWSER_MODE}    headless
${BROWSER}         ${BROWSER_MODE}firefox
${DECLINE_COOKIES}    //*[@id="CybotCookiebotDialogBodyButtonDecline"]
${ACCEPT_COOKIES}    //button[contains(., 'Accept all') or contains(., 'Allow all')]


*** Keywords ***
The User Has Access To Homepage
    Open Browser    ${ENV}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${ACCEPT_COOKIES}    10s
    Click Element    ${ACCEPT_COOKIES}
    Sleep    2
