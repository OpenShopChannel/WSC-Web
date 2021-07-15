import json
from datetime import datetime
from functools import reduce

import requests
import operator


def build_dictionary_filter_from_kwargs(**filter_kwargs):
    def _filter_fun(field, value):
        return lambda d: d[field].lower() == value.lower()
    return [_filter_fun(k, v) for k, v in filter_kwargs.items() if v]


def filter_packages(packages, **filter_kwargs):
    new_packages = []
    filters = build_dictionary_filter_from_kwargs(**filter_kwargs)
    for package in packages:
        if len(filters) == 0 or reduce(operator.and_, [filter_(package) for filter_ in filters]):
            new_packages.append(package)
    return new_packages


class API:
    packages = None

    def load_packages(self, category=""):
        self.packages = json.loads(requests.get(f"https://api.oscwii.org/v2/primary/packages?category={category}").text)

    def get_packages(self):
        return self.packages

    def filter_packages(self, category=None):
        filtered = filter_packages(self.packages, category=category)
        return filtered

    def package_by_name(self, name):
        for package in self.packages:
            if package["internal_name"] == name:
                try:
                    package["release_date"] = datetime.fromtimestamp(int(package["release_date"])).strftime('%B %e, %Y')
                except ValueError:
                    pass
                return package
