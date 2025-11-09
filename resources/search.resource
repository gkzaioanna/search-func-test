*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary

*** Variables ***
# Expected Messages
${INVALID_INPUT_TXT}      There are no results for this search
${EMPTY_INPUT_TXT}        Oops, choose a location first
${RELATED_RESULTS_TXT}    Recommended for you
${NO_LOCATION_TXT}        No results in this map area.
# Web Locators
${SEARCH_INPUT}        //input[@placeholder='Search place or address']
${SEARCH_BTN}          //pb-button//button[contains(@class,'pb-button')]
${RESULTS_SUCCESS}    //h3[text()=${RELATED_RESULTS_TXT}]


*** Keywords ***
#Clicks The Search Button
#    [Documentation]
#    Set Window Size    1366    1200
#    Wait Until Element Is Visible    ${SEARCH_BTN}    30s
#    Wait Until Element Is Enabled    ${SEARCH_BTN}    20s
#    Scroll Element Into View    ${SEARCH_BTN}
#    Sleep    2
#    Capture Page Screenshot    search_btn.png

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
    Press Keys    ${SEARCH_INPUT}     ENTER

The User Includes Extra Space In The Input In The Search Form
    [Documentation]
    Enter Input        ${SPACE}1101AX

The User Inputs Dangerous Content In The Search Form
    [Documentation]
    Enter Input    !@#$%^&*(){}":?><|][~

The User Should Be Able To View Locations Related To Search
    [Documentation]
    [Arguments]    ${txt}
    Wait Until Page Contains    ${txt}
    Capture Page Screenshot

No Results Should Be Generated And A Message Is Displayed
    [Documentation]
    [Arguments]    ${txt}
    Page Should Contain    ${txt}
    Capture Page Screenshot

The User Enters Location In Lower Case In The Search Form
    [Documentation]
    Enter Input    utrecht centraal

The User Enters Location In Upper Case In The Search Form
    [Documentation]
    Enter Input    Utrecht Centraal

The Results In Both Cases Should Be The Same
    [Documentation]


There Is No Available Spot In The Location
    [Documentation]
    Go To