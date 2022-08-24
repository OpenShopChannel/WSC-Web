# WSC-Web
This is the frontend for the Open Shop Channel, loaded via the embedded Opera browser in the Wii Shop Channel.
It acts as a catalog for OSC's database, querying its API and providing Wii-specific components where necessary.

## Setup
WSC-Web is intended to be a standard Flask application.

By default, the frontend will be exposed over TLS. In order to test the default configuration, you will need to provide a `cert.pem` and `key.pem`. It is possible to generate certificates, alongside patching them into the Wii Shop Channel, via [WSC-Patcher](https://github.com/OpenShopChannel/WSC-Patcher).

You can typically start the frontend with the following steps:
1. Configure a virtual environment. For example, `python3 -m venv venv && source venv/bin/activate`
2. Install the requirements. `pip3 install -r requirements.txt`
3. Copy `config.py.example` to `config.py`, and edit accordingly.
4. Run via `app.py`. `python3 app.py`

By default, EC-related requests (the backing API to download titles) will be disabled when run individually.
Consider starting this server via `flask run` for development, or `gunicorn` if in production.

## Contributing
Ensure you have tested all changes via the Wii Shop Channel, either on Dolphin or a physical Wii/vWii. Please do not make changes to translations directly - they will be periodically synced from translations elsewhere.

## Resources
 - https://caniuse.com is an excellent resource to see whether a property is available for usage with Opera 8.
 - Consult the [WSC documentation](https://docs.oscwii.org) for information about Nintendo's exposed JavaScript APIs.