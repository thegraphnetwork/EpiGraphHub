from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
import unittest


class TestEpiGraphHub(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        chrome_options = Options()
        chrome_options.add_argument("--disable-gpu")
        chrome_options.add_argument("--headless")
        chrome_path = ChromeDriverManager().install()
        service = Service(executable_path=chrome_path)   
        cls.driver = webdriver.Chrome(service=service)
        cls.driver.get("http://localhost:8088")

    @classmethod
    def tearDownClass(cls):
        cls.driver.quit()

    def find_css_element(self, value):
        return self.driver.find_element(by=By.CSS_SELECTOR, value=value)

    def test_title(self):
        title = self.driver.title
        self.assertEqual(title, 'EpiGraphHub')

    def test_login_as_guest(self):
        self.driver.implicitly_wait(0.5)
        # Log In
        login_button = self.find_css_element("a.btn.btn-primary.btn-lg")
        login_button.click()
        self.driver.implicitly_wait(0.5)
        # guest:guest
        self.find_css_element("input#username.form-control").send_keys('guest')
        self.find_css_element("input#password.form-control").send_keys('guest')
        # Sign In
        self.find_css_element("input.btn.btn-primary.btn-block").click()


if __name__ == '__main__':
    unittest.main(verbosity=2)

