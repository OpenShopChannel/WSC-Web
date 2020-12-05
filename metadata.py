import json
from datetime import datetime

import requests

class API:
    packages = None

    def load_packages(self):
        self.packages = json.loads(requests.get(f"https://api.oscwii.org/v2/primary/packages").text)

    def get_packages(self):
        return self.packages

    def package_by_name(self, name):
        for package in self.packages:
            if package["internal_name"] == name:
                try:
                    package["release_date"] = datetime.fromtimestamp(int(package["release_date"])).strftime('%B %e, %Y at %R')
                except ValueError:
                    pass
                return package
