# Hack to permit no "Connection: close".
import no_connection_close

from flask import Flask, render_template, request, redirect, Response, send_from_directory
from flask_babel import Babel, gettext
from werkzeug.urls import url_encode
from urllib.request import Request, urlopen

import time
import random
import json
import osc
import ssl

OpenShopChannel = osc.API()
OpenShopChannel.load_packages()

app = Flask(__name__)
babel = Babel(app)

lastCheckedFeaturedApp = 0
should_handle_ec = True


def category_translation(category, str_type = "title"):
    if str_type == "title":
        if category == "games":
            return gettext("Games")
        elif category == "media":
            return gettext("Media")
        elif category == "utilities":
            return gettext("Utilities")
        elif category == "emulators":
            return gettext("Emulators")
        elif category == "demos":
            return gettext("Demos")
    return "Unknown"



app.jinja_env.globals.update(category_translation=category_translation)


def get_locale():
    if request.cookies.get('language'):
        return request.cookies.get('language')
    else:
        return 'en'

babel.init_app(app, locale_selector=get_locale)


def get_error_text(code):
    with open("data/errors.json", 'r') as f:
        data = json.load(f)[code][0]["desc"]
        return gettext(data)


def get_motd():
    with open("data/motd.txt") as f:
        lines = f.readlines()
        return random.choice(lines).rstrip("\n")


def get_featured_app():
    global lastCheckedFeaturedApp
    if time.time() - lastCheckedFeaturedApp > 1800:
        lastCheckedFeaturedApp = time.time()
        OpenShopChannel.retrieve_featured_app()
    return OpenShopChannel.featured_app


@app.template_global()
def modify_query(**new_values):
    args = request.args.copy()

    for key, value in new_values.items():
        args[key] = value

    return '{}?{}'.format(request.path, url_encode(args))


@app.template_global()
def openify(text):
    openified = ""

    for i, c in enumerate(text):
        osc_char = 'open'[i % 4]
        openified += '<span class="osc-{}">{}</span>'.format(osc_char, c)

    return openified


@app.route("/")
def initial_page():
    return render_template('initial.html', should_handle_ec=should_handle_ec)


@app.route("/debug")
def debug_page():
    return render_template('debug.html')


@app.route("/landing")
def landing_page():
    return render_template('landing.html', motd=get_motd(),
                           featured_app=OpenShopChannel.package_by_name(get_featured_app()))


@app.route("/home")
def home_page():
    return render_template('home.html')


@app.route("/browse")
def browse_page():
    return render_template('browse.html')


@app.route("/search")
def search_page():
    search_type = request.args.get('type', default='titles', type=str)
    if search_type == "publishers":
        return render_template('publishers.html')
    return render_template('catalog.html')


@app.route("/title/<id>/")
def title_index_page(id):
    return render_template('title/index.html')


@app.route("/title/<id>/controllers")
def title_controllers_page(id):
    return render_template('title/controllers.html')


@app.route("/title/<id>/details")
def title_details_page(id):
    return render_template('title/details.html')


"""
@app.route("/donate")
def donate_page():
    return render_template('donate.html')


@app.route("/browse")
def browse_page():
    return render_template('browse.html', featuredApp=get_featured_app())


@app.route("/keyword")
def keyword_page():
    return render_template('keyword.html')


@app.route("/category")
def category_page():
    return render_template('category.html')


@app.route("/startdownload")
def start_download_page():
    selected_app = request.args.get('app', default='danbo', type=str)
    selected_app = OpenShopChannel.package_by_name(selected_app)
    return render_template('startdownload.html', app=selected_app)


@app.route("/search")
def search_page():
    key = request.args.get('key', default='display_name', type=str)
    value = request.args.get('value', default='danbo', type=str).lower()
    page = request.args.get('page', default=0, type=int)

    results = OpenShopChannel.search_packages(key, value)

    last_page = ""
    next_page = ""

    if len(results[page * 2 * 8:(page * 2 * 8) + 8]) == 0 or len(results[page * 8:(page * 8) + 8]) < 4:
        next_page = ""
    elif len(results) > 0:
        next_page = "search?key=" + key + "&value=" + value + "&page=" + str(page + 1)

    if page == 0:
        last_page = ""
    elif len(results) > 0:
        last_page = "search?key=" + key + "&value=" + value + "&page=" + str(page - 1)

    return render_template('search.html', results=results[page * 8:(page * 8) + 8], lastPage=last_page,
                           nextPage=next_page)


@app.route("/app")
def app_page():
    selected_app = request.args.get('app', default='danbo', type=str)
    selected_app = OpenShopChannel.package_by_name(selected_app)

    return render_template('app.html', app=selected_app)


@app.route("/random")
def random_app_page():
    response = Response('')
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Location"] = "/app?app=" + random.choice(OpenShopChannel.get_packages())["slug"]
    return response, 301


@app.route("/finishdownload")
def finish_download_page():
    return render_template("finishdownload.html")
"""

@app.route("/error")
def error_page():
    error_code = request.args.get('error', default='danbo', type=str)
    error_text = get_error_text(error_code)
    if error_code == "SUCCESS":
        return redirect("/", code=302)
    else:
        return render_template('error.html', error_code=error_code, error_text=error_text)


@app.route("/eval")
def eval_page():
    return render_template("eval.html")


@app.errorhandler(404)
def page_not_found(e):
    error_code = "HTTP_404"
    error_text = gettext("The requested page could not be found.")
    return render_template('error.html', error_code=error_code, error_text=error_text), 404


@app.errorhandler(500)
def server_error(e):
    error_code = "HTTP_500"
    error_text = gettext("The server has encountered an error. Try again later.")
    return render_template('error.html', error_code=error_code, error_text=error_text), 500


if __name__ == '__main__':
    # Allow UI easier prototyping by nullify all EC requests.
    should_handle_ec = False
    context = ssl.SSLContext(ssl.PROTOCOL_TLSv1)
    # Hint that we are about to use very brittle ciphers.
    context.set_ciphers('ALL:@SECLEVEL=0')
    context.load_cert_chain('cert.pem', 'key.pem')

    app.run(host='127.0.0.1', port=443, debug=True, ssl_context=context)
