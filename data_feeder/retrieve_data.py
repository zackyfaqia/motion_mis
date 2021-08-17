from linkedin_scraper import Person, actions
from selenium.webdriver import Chrome
from selenium.webdriver.chrome.options import Options

opts = Options()
opts.headless = True
driver = Chrome(options=opts)

email = "xxxx"
password = "yyyy"
actions.login(driver, email, password) # if email and password isnt given, it'll prompt in terminal
person = Person("https://www.linkedin.com/in/auliadwio/", driver=driver)
# person = Person("https://www.linkedin.com/in/muhammad-alif-akbar/", driver=driver)

print(person)