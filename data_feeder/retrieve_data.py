import os
import yaml
from linkedin_scraper import Person, actions
from selenium.webdriver import Chrome
from selenium.webdriver.chrome.options import Options

def setup_driver(email, password):
    opts = Options()
    opts.headless = True
    driver = Chrome(options=opts)
    actions.login(driver, email, password) # if email and password isnt given, it'll prompt in terminal
    return driver

def read_generation_yaml(path, filename):
    with open(f"{path}/{filename}", 'r') as stream:
        try:
            return yaml.safe_load(stream)
        except yaml.YAMLError as exc:
            print(exc)
            return {}

def save_generation_yaml(path, filename, data):
    with open(f"{path}_generated/{filename}", 'w') as stream:
        try:
            yaml.dump(data, stream)
        except yaml.YAMLError as exc:
            print(exc)

def crawl(member_data_path, filename):
    print(f'========= processing: {filename} ========')
    gen_data = read_generation_yaml(member_data_path, filename)
    for idx, member in enumerate(gen_data['members']):
        print(f"{idx+1}. {member['name']} : {member['linkedin']}")
        
        # crawling
        person = Person(member['linkedin'], driver=driver, close_on_complete=False)
        member['full_name'] = person.name
        member['headline'] = person.headline
        member['about'] = person.about
        member['profile_image'] = person.profile_image
        member['cover_image'] = person.cover_image
    save_generation_yaml(member_data_path, filename, gen_data)
    print(f'========= saved: {member_data_path}_generated/{filename} ========')

if __name__ == '__main__':
    email = "xxxx"
    password = "yyyy"
    driver = setup_driver(email, password)

    member_data_path = "./members_data"
    generation_file_name = []
    for dirpath, dnames, fnames in os.walk(member_data_path):
        generation_file_name = fnames
    for filename in generation_file_name:
        crawl(member_data_path, filename)
    driver.quit()