*** Settings ***
Resource    ../resources/search.resource
Resource    ../resources/browser.resource
Resource    ../resources/general.resource

Suite Setup    Initialize Screenshots

*** Test Cases ***
Test 1 Search with a valid input
    [Documentation]    This test verifies that when a user enters a valid location or address,
    ...    then the HMI should display the related results according to search.
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Enters A Valid Place Or Address In The Search Form
    Then The User Should Be Able To View Locations Related To Search    ${VALID_INPUT_1}

Test 2 Search should not consider trailing spaces
    [Documentation]    This test verifies that when a user includes unnecessary spaces in the
    ...    search form, then the HMI should display the related results according to search.
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Includes Extra Space In The Input In The Search Form
    Then The User Should Be Able To View Locations Related To Search    ${VALID_INPUT_2}

Test 3 Partial match search
    [Documentation]    This test verifies that when a user provides partial input to the
    ...    search form, then the HMI should display the related results according to search.
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Enters A Partial Input In The Search Form
    Then The User Should Be Able To View Locations Related To Search    ${RELATED_RESULTS_TXT}

Test 4 Search should not be case sensitive
    [Documentation]    This test verifies that when a user provides input in lower case or
    ...    in upper case in the search form, then the HMI should display the related results
    ...    according to search and the results should be the same.
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Enters Location In Lower Case In The Search Form
    And The User Enters Location In Upper Case In The Search Form
    Then The Results In Both Cases Should Be The Same

Test 5 Search should display message when no location is available
    [Documentation]
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Enters A Location In The Search Form
    And There Is No Available Spot In The Location
    Then The HMI Should Display A No Available Location Message    ${NO_LOCATION_TXT}
