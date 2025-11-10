*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SCREENSHOT_INDEX}       1
${MAKE_SCREENSHOTS}      True
${SCREENSHOT_DIR}    ${EXECDIR}${/}results${/}screenshots

*** Keywords ***
Initialize Screenshots
    [Documentation]    Creates screenshot folder and resets counters.
    Create Directory    ${SCREENSHOT_DIR}
    Set Suite Variable   ${SCREENSHOT_INDEX}    1
    Set Suite Variable   ${MAKE_SCREENSHOTS}    True

Disable Screenshotting
    [Documentation]    Turns off screenshot capturing for current suite.
    Set Suite Variable   ${MAKE_SCREENSHOTS}    False

Enable Screenshotting
    [Documentation]    Turns on screenshot capturing for current suite.
    Set Suite Variable   ${MAKE_SCREENSHOTS}    True

Custom Capture Screenshot
    [Documentation]    Captures sanitized screenshot into screenshots directory.
    Run Keyword If    '${MAKE_SCREENSHOTS}' != 'True'    RETURN
    ${suite_name} =    Evaluate    re.sub(r'[^A-Za-z0-9_-]', '_', """${SUITE_NAME}""")    modules=re
    ${status}    ${test_name} =    Run Keyword And Ignore Error    Set Variable    ${TEST_NAME}
    Run Keyword If    '${status}' != 'PASS'    Set Variable    ${test_name}    NoTest
    ${test_name} =    Evaluate    re.sub(r'[^A-Za-z0-9_-]', '_', """${test_name}""")    modules=re
    ${filename} =    Set Variable    TestSuite-${suite_name}-${test_name}-Screenshot-${SCREENSHOT_INDEX}.png
    ${filepath} =    Set Variable    ${SCREENSHOT_DIR}${/}${filename}
    Capture Page Screenshot    ${filepath}
    ${new_index} =    Evaluate    ${SCREENSHOT_INDEX} + 1
    Set Suite Variable    ${SCREENSHOT_INDEX}    ${new_index}
