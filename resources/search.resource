*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary

*** Variables ***
${XPATHS}          xpath=
${SEARCH_INPUT}    //input[@placeholder='Search place or address']
${SEARCH_BTN}      ${XPATHS}//pb-button//button[contains(@class,'pb-button')]