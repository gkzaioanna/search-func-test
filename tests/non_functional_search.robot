*** Settings ***
Resource    ../resources/search.resource
Resource    ../resources/browser.resource
Resource    ../resources/general.resource

Suite Setup    Initialize Screenshots

*** Test Cases ***
Test 1 SQL injection attempt
    [Documentation]    This test verifies that when a user enters dangerous data
    ...    in the search form, then no result is generated and a warning message is displayed.
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Attempts SQL Injection In The Search Form
    Then No Results Should Be Generated And A Message Is Displayed    ${INVALID_INPUT_TXT}

Test 2 Script injection attempt
    [Documentation]
    Given The User Has Access To Homepage
    When The User Attempts Script Injection In The Search Form
    Then No Results Should Be Generated And A Message Is Displayed    ${INVALID_INPUT_TXT}
