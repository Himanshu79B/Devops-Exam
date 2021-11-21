import sys
import requests

git_api_url = 'https://api.github.com'

class Codesearch:
    def __init__(self, organization, word):
        self.organization = organization
        self.word = word

    def text_search(self):
        #Code to check if organization exists or not
        org_response = requests.get(url=f"{git_api_url}/orgs/{self.organization}")
        if org_response.status_code == 200:
            print(f"Organization : {self.organization} exists. Starting code search for {self.word}...")

            url = f"{git_api_url}/search/code?q={self.word} +in:file +org:{self.organization}"
            headers = {'Authorization': 'Token XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx'}
            text_search_response = requests.get(url, headers=headers).json()
            if len(text_search_response['items']) == 0:
                print(f"Repository : not found")
                print(f"filepath : not found")
            else:
                #Priting only the first item in the result as per the requirement
                print(f"Repository : {text_search_response['items'][0]['repository']['full_name']}")
                print(f"filepath : {text_search_response['items'][0]['path']}")

        else:
            print("Response code: ", org_response.status_code)
            print(f"{self.organization} organization doesn't exist.Please Re-Check details and retry. Exiting")
            exit()


cs = Codesearch(organization=sys.argv[1], word=(' '.join(sys.argv[2:]))).text_search()

