*** Settings ***
Resource    ../resources/search.resource
Resource    ../resources/browser.resource
Resource    ../resources/general.resource

Suite Setup    Initialize Screenshots

Test Teardown    Close Browser

*** Test Cases ***
Manual Test 1 Autocomplete Suggestions Should Display ParkBee Locations
    [Documentation]    This is a simulation test which verifies that when a user
    ...    has access to the main page and does not type the complete location
    ...    suggestions would be populated in the dropdown list, so that user is
    ...    able to select desired location and view relevant results.
    [Setup]    Tester must have access to https://uat.parkbee.com
    ...        Browser used can host the page.
    Step 1    Open the browser and access Parkbee main page in https://uat.parkbee.com
    Expected Result    Application loads successfully.
    Step 2    In the search input field, type the first 3-4 letters of a known valid location.
              Capture Screenshot(s).
    Expected Result    Autocomplete dropdown is displayed below the search input field, populating
    ...                suggested locations related to user's input.
                       Screenshot(s) Captured.
    Step 3    Select one of the suggested locations.
              Capture Screenshot(s).
    Expected Result    The page navigates to show parking locations for the selected place and
    ...                an appropriate message is displayed to the user.
                        Screenshot(s) Captured.

Test 2 Search Should Work On Mobile View
    [Documentation]    This is a simulation test which verifies that when a user
    ...    has access to the main page via mobile app or desktop browser and searches for
    ...    a valid location, the system should display the relevant results of the desired location.
    [Setup]    Tester must have the mobile device or desktop browser set to an appropriate resolution.
    ...        This test must be run twice. (One execution with mobile device and one with browser.)
    Step 1    Open main page using a mobile device or using browser DevTools in mobile mode.
              Capture Screenshot(s).
    Expected Results        Homepage loads successfully and fits mobile view.
                            Screenshot(s) Captured.
    Step 2    Tap the search input and enter a valid location, e.g. Delft.
    Expected Results        On screen keyboard is displayed and text appears correctly in input field.
    ...                     The page navigates to show parking locations for the selected place and
    ...                     an appropriate message is displayed to the user.
                            Screenshot(s) Captured.
    Step 3    Zoom in and out to the desired spot.
    Expected Results        UI remains usable and responsive.
