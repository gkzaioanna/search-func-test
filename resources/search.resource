*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
Library    Collections
Library    String
Resource    general.resource
Resource    browser.resource

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
${VALID_INPUT_2}      1101 AX
${INVALID_INPUT}      123ABCslpw
${SQL_INJECTION}      "' OR 1=1 --"
${SCRIPT_INJECTION}    "<script>alert('test')</script>"
${LOWER_CASE_INPUT}    utrecht centraal
${UPPER_CASE_INPUT}    Utrecht Centraal
${NO_AVAILABILITY_INPUT}    Thessalia

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
    [Documentation]    Enters input in the search form.
    [Arguments]    ${input}
    Wait Until Element Is Visible    ${SEARCH_INPUT_BASE}    10s
    Input Text    ${SEARCH_INPUT_BASE}    ${input}
    Sleep    2
    Press Keys    ${SEARCH_INPUT_BASE}     ENTER
    Custom Capture Screenshot

The User Enters A Valid Place Or Address In The Search Form
    [Documentation]    The user provides correct input.
    Enter Input    ${VALID_INPUT_1}

The User Enters Invalid Input In The Search Form
    [Documentation]    The user enters incorrect input.
    Enter Input    ${INVALID_INPUT}

The User Enters Nothing In The Search Form
    [Documentation]    The user provides no input.
    No Operation
    Press Keys    ${SEARCH_INPUT_BASE}     ENTER

The User Includes Extra Space In The Input In The Search Form
    [Documentation]    The user input contains unnecessary spaces.
    Enter Input        ${SPACE}${VALID_INPUT_2}

The User Attempts SQL Injection In The Search Form
    [Documentation]    The user attempts an SQL injection attack.
    Enter Input    ${SQL_INJECTION}

The User Attempts Script Injection In The Search Form
    [Documentation]    The user attempts a scripting attack.
    Enter Input    ${SCRIPT_INJECTION}

The User Should Be Able To View Locations Related To Search
    [Documentation]    Verifies that the user is able to view related results.
    [Arguments]    ${txt}
    Sleep    3
    Wait Until Page Contains    ${txt}
    Capture Page Screenshot

No Results Should Be Generated And A Message Is Displayed
    [Documentation]    Verifies that no results are generated and an appropriate message is displayed.
    [Arguments]    ${txt}
    Sleep    5
    Page Should Contain    ${txt}
    Custom Capture Screenshot

The User Enters A Partial Input In The Search Form
    [Documentation]    The user does not enter the full input.
    Enter Input    ${VALID_INPUT_1}[0:4]

The User Enters A Location In The Search Form
    [Documentation]    The user enters a location in the search form.
    Enter Input    ${NO_AVAILABILITY_INPUT}

Get Normalized Search Results
    [Documentation]    Normalizes page element.
    [Arguments]    ${result_locator}=${SEARCH_RESULTS}
    Wait Until Page Contains Element    ${result_locator}    timeout=10s
    ${elements}=    Get WebElements    ${result_locator}
    ${texts}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        ${text_clean}=    Strip String    ${text}
        ${text_lower}=    Convert To Lowercase    ${text_clean}
        Append To List    ${texts}    ${text_lower}
    END
    RETURN    ${texts}

The User Enters Location In Lower Case In The Search Form
    [Documentation]    The user types location in lower case.
    Enter Input    ${LOWER_CASE_INPUT}
    The User Should Be Able To View Locations Related To Search    ${RELATED_RESULTS_TXT}
    ${LOWER_CASE_RESULTS}=    Get Normalized Search Results
    Set Suite Variable    ${LOWER_CASE_RESULTS}

The User Enters Location In Upper Case In The Search Form
    [Documentation]    The User types location in upper case.
    Close Browser
    The User Has Access To Homepage
    Enter Input    ${UPPER_CASE_INPUT}
    The User Should Be Able To View Locations Related To Search    ${RELATED_RESULTS_TXT}
    ${UPPER_CASE_RESULTS}=    Get Normalized Search Results
    Set Suite Variable    ${UPPER_CASE_RESULTS}

The Results In Both Cases Should Be The Same
    [Documentation]    Compares the results.
     Should Be Equal    ${LOWER_CASE_RESULTS}    ${UPPER_CASE_RESULTS}

The HMI Should Display A No Available Location Message
    [Documentation]    Verifies appropriate message is displayed on the HMI.
    [Arguments]    ${msg}
    Wait Until Page Contains    ${msg}    timeout=10s
    Custom Capture Screenshot

There Is No Available Spot In The Location
    [Documentation]    Checks or simulates that the location has no available spots
    Wait Until Page Contains    ${NO_LOCATION_TXT}    timeout=10s
    Custom Capture Screenshot

The User Enters Only Spaces In The Search Form
    [Documentation]    User input consists only of spaces.
    Enter Input    ${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}

*** Keywords ***
Generate Long Input
    [Arguments]    ${length}=300
    ${long_input}=    Evaluate    ('ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' * 50)[:${length}]
    RETURN    ${long_input}

The User Enters Excessively Long Input In The Search Form
    [Documentation]    User input consists of excessively long characters.
    ${LONG_INPUT}=    Generate Long Input    400
    Enter Input    ${LONG_INPUT}
