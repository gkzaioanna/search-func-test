*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
Library    Collections
Library    String
Resource    general.resource

*** Variables ***
# Expected Messages
${INVALID_INPUT_TXT}      There are no results for this search
${EMPTY_INPUT_TXT}        Oops, choose a location first
${RELATED_RESULTS_TXT}    Recommended for you
${NO_LOCATION_TXT}        No results in this map area.
# Web Locators
${SEARCH_INPUT_BASE}        //input[@placeholder='Search place or address']
${SEARCH_BTN}          //pb-button//button[contains(@class,'pb-button')]
${RESULTS_SUCCESS}    //h3[text()=${RELATED_RESULTS_TXT}]
${SEARCH_INPUT}        //input[@placeholder='Where are you going?']
${SEARCH_RESULTS}    //div//p[contains(@class,'truncate body-small-2')]
# User Input
${VALID_INPUT_1}      Amsterdam
${VALID_INPUT_2}      1101AX
${INVALID_INPUT}      123ABCslpw
${MALICIOUS_INPUT}    !@#$%^&*(){}":?><|][~
${LOWER_CASE_INPUT}    utrecht centraal
${UPPER_CASE_INPUT}    Utrecht Centraal

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
    Wait Until Element Is Visible    ${SEARCH_INPUT_BASE}    10s
    Input Text    ${SEARCH_INPUT_BASE}    ${input}
    Sleep    2
    Press Keys    ${SEARCH_INPUT_BASE}     ENTER
    Custom Capture Screenshot

The User Enters A Valid Place Or Address In The Search Form
    [Documentation]
    Enter Input    ${VALID_INPUT_1}

The User Enters Invalid Input In The Search Form
    [Documentation]
    Enter Input    ${INVALID_INPUT}

The User Enters Nothing In The Search Form
    [Documentation]
    No Operation
    Press Keys    ${SEARCH_INPUT_BASE}     ENTER

The User Includes Extra Space In The Input In The Search Form
    [Documentation]
    Enter Input        ${SPACE}${VALID_INPUT_2}

The User Inputs Dangerous Content In The Search Form
    [Documentation]
    Enter Input    ${MALICIOUS_INPUT}

The User Should Be Able To View Locations Related To Search
    [Documentation]
    [Arguments]    ${txt}
    Wait Until Page Contains    ${txt}
    Capture Page Screenshot

No Results Should Be Generated And A Message Is Displayed
    [Documentation]
    [Arguments]    ${txt}
    Sleep    5
    Page Should Contain    ${txt}
    Custom Capture Screenshot

The User Enters Location In The Search Form
    [Arguments]    ${input}    ${txt}=None
    [Documentation]    Enters any input into the search field and verifies results.
    Enter Input    ${input}
    The User Should Be Able To View Locations Related To Search    ${input}    ${txt}


The User Enters Location In Lower Case In The Search Form
    [Documentation]
    Enter Input    ${LOWER_CASE_INPUT}
    The User Should Be Able To View Locations Related To Search    ${LOWER_CASE_INPUT}    ${RELATED_RESULTS_TXT}

The User Enters Location In Upper Case In The Search Form
    [Documentation]
    Enter Input    ${UPPER_CASE_INPUT}
    The User Should Be Able To View Locations Related To Search    ${UPPER_CASE_INPUT}    ${RELATED_RESULTS_TXT}

The Results In Both Cases Should Be The Same
    [Arguments]    ${first_input}    ${second_input}    ${result_locator}=${SEARCH_RESULTS}
    Wait Until Element Is Visible    ${result_locator}    timeout=10s
    ${first_elements}=    Get WebElements    ${result_locator}
    ${first_texts}=    Create List
    FOR    ${el}    IN    @{first_elements}
        ${text}=    Get Text    ${el}
        ${text_lower}=    Convert To Lowercase    ${text}
        Append To List    ${first_texts}    ${text_lower}
    END
    Custom Capture Screenshot
    ${second_elements}=    Get WebElements    ${result_locator}
    ${second_texts}=    Create List
    FOR    ${el}    IN    @{second_elements}
        ${text}=    Get Text    ${el}
        ${text_lower}=    Convert To Lowercase    ${text}
        Append To List    ${second_texts}    ${text_lower}
    END
    Custom Capture Screenshot
    Should Be Equal As Lists    ${first_texts}    ${second_texts}



There Is No Available Spot In The Location
    [Documentation]
    Go To