*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${ENV}             https://uat.parkbee.com
${BROWSER_MODE}    headless
${BROWSER}         ${BROWSER_MODE}firefox
${ENV_COOKIES}     //*[@id="CybotCookiebotDialogBodyButtonDecline"]
${SCROLL_OFFSET}   100

*** Keywords ***
Open Browser No Cookies
    Open Browser    ${ENV}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${ENV_COOKIES}    10s
    Click Element    ${ENV_COOKIES}
    Sleep    2
