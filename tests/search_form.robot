*** Settings ***
Resource    ../resources/search.resource
Resource    ../resources/browser.resource
Library     ../lib/browser_settings.py

Suite Setup    Open Browser No Cookies
*** Test Cases ***
Valid Input Search
    Wait Until Element Is Visible    ${SEARCH_INPUT}    10s
    Input Text    ${SEARCH_INPUT}    Amsterdam
    Press Keys    ${SEARCH_INPUT}    \\13
    Wait Until Element Is Visible    ${SEARCH_BTN}    30s
    Wait Until Element Is Enabled    ${SEARCH_BTN}    10s
#    ${button_element}=    Get WebElement    ${SEARCH_BTN}
#    Execute Javascript
#    ...    window.scrollTo(0, arguments[0].getBoundingClientRect().top + window.pageYOffset - ${SCROLL_OFFSET});
#    ...    ${button_element}
    ${shadow_root}=    Execute Javascript    return document.querySelector('pb_button').shadowRoot
    ${button_element}=    Execute Javascript    return arguments[0].querySelector('button.pb-button');    ${shadow_root}
    Execute Javascript    arguments[0].scrollIntoView({block: "center"});    ${button_element}
    Execute Javascript    arguments[0].click();    ${button_element}
    Click Element    ${SEARCH_BTN}
    Capture Page Screenshot    search_btn.png
    Close Browser