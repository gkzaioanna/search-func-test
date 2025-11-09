*** Settings ***
Resource    ../resources/search.resource
Resource    ../resources/browser.resource
#Library     ../lib/browser_settings.py


*** Test Cases ***
Test 1: Search with a valid input
    [Documentation]
    Given The User Has Access To Homepage
    When The User Enters A Valid Place Or Address In The Search Form
    Then The User Should Be Able To View Locations Related To Search    Amsterdam

Test 2: Search with an invalid input
    [Documentation]
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Enters Invalid Input In The Search Form
    Then No Results Should Be Generated And A Message Is Displayed    ${INVALID_INPUT_TXT}

Test 3: Search with empty input
    [Documentation]
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Enters Nothing In The Search Form
    Then No Results Should Be Generated And A Message Is Displayed    ${EMPTY_INPUT_TXT}

Test 4: Search should not consider trailing spaces
    [Documentation]
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Includes Extra Space In The Input In The Search Form
    Then The User Should Be Able To View Locations Related To Search    ${RELATED_RESULTS_TXT}

Test 5: Search should not be case sensitive
    [Documentation]
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Enters Location In Lower Case In The Search Form    utrecht
    And The User Enters Location In Upper Case In The Search Form    UTRECHT
    Then The Results In Both Cases Should Be The Same

Test 6: Search should display message when no location is available
    [Documentation]
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Enters A Valid Place Or Address In The Search Form    Amsterdam
    And There Is No Available Spot In The Location
    Then The HMI Should Display A Message    ${NO_LOCATION_TXT}= No results in this map area.

Test 7: Search should not allow malicious data
    [Documentation]
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Enters Dangerous Content In The Search Form    !~@#$%^&*(){}"|_+?><:"[]
    Then No Results Should Be Generated And A Message Is Displayed    ${INVALID_INPUT_TXT}