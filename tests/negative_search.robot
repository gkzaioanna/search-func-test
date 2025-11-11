*** Settings ***
Resource    ../resources/search.resource
Resource    ../resources/browser.resource
Resource    ../resources/general.resource

Suite Setup    Initialize Screenshots

Test Teardown    Close Browser

*** Test Cases ***
Test 1 Search with an invalid input
    [Documentation]    This test verifies that when a user enters invalid location or address,
    ...    then the HMI should display an appropriate message and no results.
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Enters Invalid Input In The Search Form
    Then No Results Should Be Generated And A Message Is Displayed    ${INVALID_INPUT_TXT}

Test 2 Search with empty input
    [Documentation]    This test verifies that when a user provides no input in the search form,
    ...    then the HMI should display an appropriate message and no results.
    [Teardown]    Close Browser
    Given The User Has Access To Homepage
    When The User Enters Nothing In The Search Form
    Then No Results Should Be Generated And A Message Is Displayed    ${EMPTY_INPUT_TXT}

Test 3 Search with only spaces
    [Documentation]    This test verifies that when a user provides only spaces in the search form,
    ...    then the HMI should display an appropriate message and no results.
    Given The User Has Access To Homepage
    When The User Enters Only Spaces In The Search Form
    Then No Results Should Be Generated And A Message Is Displayed    ${EMPTY_INPUT_TXT}

Test 4 Search with excessively long input
    [Documentation]    This test verifies that when a user provides too long input in the search form,
    ...    then the HMI should display an appropriate message and no results.
    Given The User Has Access To Homepage
    When The User Enters Excessively Long Input In The Search Form
    Then No Results Should Be Generated And A Message Is Displayed    ${INVALID_INPUT_TXT}

Test 5 User clears/resets search
    [Documentation]    This test verifies that when a user removes input from the search form
    ...    then the search form is reverted to its original state.
    Given The User Has Access To Homepage
    When The User Provides Input In The Search Form
    And The User Clears Input
    Then Search Form Field Is Cleared