# file: browser_helper.py
from selenium.webdriver import Chrome
from selenium.webdriver.chrome.options import Options

def open_chrome_incognito(url, headless=False):
    options = Options()
    options.add_argument("--incognito")
    options.add_argument("--window-size=1920,1080")
    if headless:
        options.add_argument("--headless=new")
    driver = Chrome(options=options)
    driver.get(url)
    return driver
