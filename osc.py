from datetime import datetime
from functools import reduce

import requests
import operator

import config


def sizeof_fmt(num, suffix='B'):
    for unit in ['', 'Ki', 'Mi', 'Gi', 'Ti', 'Pi', 'Ei', 'Zi']:
        if abs(num) < 1024.0:
            return "%3.1f%s%s" % (num, unit, suffix)
        num /= 1024.0
    return "%.1f%s%s" % (num, 'Yi', suffix)


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
    featured_app = "danbo"
    packages = None

    def load_packages(self):
        self.packages = requests.get(f"{config.REPOMAN_HOST}/api/v3/contents").json()

    def get_packages(self):
        return self.packages

    def filter_packages(self, category=None):
        filtered = filter_packages(self.packages, category=category)
        return filtered

    def package_by_name(self, name):
        for package in self.packages:
            if package["slug"] == name:
                try:
                    package["release_date"] = datetime.fromtimestamp(int(package["release_date"])).strftime('%B %e, %Y')
                    package["extracted_human_size"] = sizeof_fmt(package["file_size"]["zip_uncompressed"])
                except ValueError:
                    pass
                return package

    def search_packages(self, key, value):
        matching_packages = []
        if key not in self.packages[0]:
            return "err"
        for package in self.packages:
            if value.lower() in package[key].lower():
                try:
                    package["release_date"] = datetime.fromtimestamp(int(package["release_date"])).strftime('%B %e, %Y')
                    package["file_size"]["zip_uncompressed"] = sizeof_fmt(package["file_size"]["zip_uncompressed"])
                except ValueError:
                    pass
                matching_packages.append(package)
        return matching_packages

    def retrieve_featured_app(self):
        package = requests.get(f"{config.REPOMAN_HOST}/api/v3/featured-app").json()
        self.featured_app = package["slug"]
        return self.featured_app
