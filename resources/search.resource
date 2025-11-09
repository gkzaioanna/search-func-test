*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary

*** Variables ***
${XPATHS}          xpath=
${SEARCH_INPUT}    //input[@placeholder='Search place or address']
${SEARCH_BTN}      ${XPATHS}//pb-button//button[contains(@class,'pb-button')]
${INVALID_INPUT_TXT}    There are no results for this search
${EMPTY_INPUT)TXT}    Oops, choose a location first

*** Keywords ***
Clicks The Search Button
    [Documentation]
    Set Window Size    1366    1200
    Wait Until Element Is Visible    ${SEARCH_BTN}    20s
    Wait Until Element Is Enabled    ${SEARCH_BTN}    20s
    Scroll Element Into View    ${SEARCH_BTN}
    Sleep    2
    Capture Page Screenshot    search_btn.png

Enter Input
    [Documentation]
    [Arguments]    ${input}
    Wait Until Element Is Visible    ${SEARCH_INPUT}    10s
    Input Text    ${SEARCH_INPUT}    ${input}
    Sleep    2
    Press Keys    ${SEARCH_INPUT}     ENTER
    Capture Page Screenshot

The User Enters A Valid Place Or Address In The Search Form
    [Documentation]
    Enter Input    Amsterdam

The User Enters Invalid Input In The Search Form
    [Documentation]
    Enter Input    123ABCslpw

The User Enters Nothing In The Search Form
    [Documentation]
    No Operation
    Clicks The Search Button

The User Includes Extra Space In The Input In The Search Form
    [Documentation]
    Enter Input        1101AX

The User Inputs Dangerous Content In The Search Form
    [Documentation]
    Enter Input    !@#$%^&*(){}":?><|][~

The User Should Be Able To View Locations Related To Search
    [Documentation]
    [Arguments]    ${element}
    Wait Until Page Contains    ${element}

No Results Should Be Generated And A Message Is Displayed
    [Documentation]
    [Arguments]    ${txt}
    Page Should Contain    ${msg}