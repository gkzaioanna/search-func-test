*** Settings ***
Resource    ../resources/search.resource
Resource    ../resources/browser.resource
Resource    ../resources/general.resource

Suite Setup    Initialize Screenshots

Test Teardown    Close Browser

*** Test Cases ***
Test 1 Autocomplete Suggestions Should Display ParkBee Locations
    [Documentation]
    Given The User Has Access To Homepage
    When The User Types A Partial Valid Place Or Address
    Then Autocomplete Suggestions Should Be Visible
    And The User Can Select A Suggested Location
    Then The User Should Be Able To View Locations Related To Search    ${RELATED_RESULTS_TXT}

Test 2 Search Should Work On Mobile View
    [Documentation]
    Given The User Accesses Homepage On Mobile Viewport
    When The User Enters A Valid Place Or Address In The Search Form
    Then The User Should Be Able To View Locations Related To Search    ${RELATED_RESULTS_TXT}
