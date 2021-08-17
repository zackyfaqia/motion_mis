import os
import yaml
from linkedin_scraper import Person, actions
from selenium.webdriver import Chrome
from selenium.webdriver.chrome.options import Options

# opts = Options()
# opts.headless = True
# driver = Chrome(options=opts)

email = "xxxx"
password = "yyyy"
# actions.login(driver, email, password) # if email and password isnt given, it'll prompt in terminal
# person = Person("https://www.linkedin.com/in/auliadwio/", driver=driver)
# person = Person("https://www.linkedin.com/in/muhammad-alif-akbar/", driver=driver)

if __name__ == '__main__':
    member_data_path = "./members_data"
    generation_file_name = []
    for dirpath, dnames, fnames in os.walk(member_data_path):
        # print(f"{dirpath}, {dnames}, {fnames}")
        generation_file_name = fnames
    for filename in generation_file_name:
        print(f'========= processing: {filename} ========')
        gen_data = {}
        with open(f"{member_data_path}/{filename}", 'r') as stream:
            try:
                gen_data = yaml.safe_load(stream)
            except yaml.YAMLError as exc:
                print(exc)
        for idx, member in enumerate(gen_data['members']):
            print(f"{idx+1}. {member['name']} : {member['linkedin']}")