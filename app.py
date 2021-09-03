from flask import Flask, render_template, request, redirect, Response
from werkzeug.serving import WSGIRequestHandler
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

lastCheckedFeaturedApp = 0

def getErrorText(code):
    with open("data/errors.json", 'r') as f:
        data = json.load(f)
        return data[code][0]["desc"]

def getMOTD():
    with open("data/motd.txt") as f:
        lines = f.readlines()
        return random.choice(lines).rstrip("\n")

def getFeaturedApp():
    global lastCheckedFeaturedApp
    if (time.time() - lastCheckedFeaturedApp > 1800):
        lastCheckedFeaturedApp = time.time()
        req = Request('https://oscwii.org')
        req.add_header('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:56.0) Gecko/20100101 Firefox/56.0')
        contents = str(urlopen(req).read()).split("App of the Day: ")[1].split("/library/app/")[1].split("\"")[0]
        with open('data/featuredApp.txt', "w") as f:
            f.write(contents)
    with open('data/featuredApp.txt', "r") as f:
        featuredApp = f.read()
    return featuredApp

@app.template_global()
def modify_query(**new_values):
    args = request.args.copy()

    for key, value in new_values.items():
        args[key] = value

    return '{}?{}'.format(request.path, url_encode(args))


@app.route("/")
def splash():
    return render_template('splash.html')

@app.route("/landing")
def landing():
    return render_template('landing.html', motd=getMOTD(), featuredApp=OpenShopChannel.package_by_name(getFeaturedApp()))

@app.route("/donate")
def donate():
    return render_template('donate.html') 

@app.route("/browse")
def browse():
    return render_template('browse.html', featuredApp=getFeaturedApp()) 

@app.route("/keyword")
def keyword():
    return render_template('keyword.html') 

@app.route("/category")
def category():
    return render_template('category.html') 

@app.route("/startdownload")
def startdownload():
    selectedApp = request.args.get('app', default = 'danbo', type = str)
    selectedApp = OpenShopChannel.package_by_name(selectedApp)
    return render_template('startdownload.html', app=selectedApp)

@app.route("/search")
def search():
    key = request.args.get('key', default = 'display_name', type = str)
    value = request.args.get('value', default = 'danbo', type = str).lower()
    page = request.args.get('page', default = 0, type = int)

    results = OpenShopChannel.search_packages(key, value)

    lastPage = ""
    nextPage = ""

    if len(results[page*2*8:(page*2*8)+8]) == 0 or len(results[page*8:(page*8)+8]) < 4:
        nextPage = ""
    elif len(results) > 0:
        nextPage = "search?key=" + key + "&value=" + value + "&page=" + str(page + 1)

    if page == 0:
        lastPage = ""
    elif len(results) > 0:
        lastPage = "search?key=" + key + "&value=" + value + "&page=" + str(page - 1)

    return render_template('search.html', results=results[page*8:(page*8)+8], lastPage=lastPage, nextPage=nextPage) 

@app.route("/app")
def appPage():
    selectedApp = request.args.get('app', default = 'danbo', type = str)
    selectedApp = OpenShopChannel.package_by_name(selectedApp)
    
    readableSize = sizeof_fmt(selectedApp["extracted"])

    return render_template('app.html', app=selectedApp, size=readableSize)

@app.route("/random")
def randomApp():
    response = Response('')
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Location"] = "/app?app=" + random.choice(OpenShopChannel.get_packages())["internal_name"]
    return response, 301

@app.route("/error")
def errorPage():
    errorcode = request.args.get('error', default = 'danbo', type = str)
    errortext = getErrorText(errorcode)
    if errorcode == "SUCCESS":
        return redirect("/", code=302)
    else:
        return render_template('error.html', errorcode=errorcode, errortext=errortext)

@app.errorhandler(404)
def page_not_found(e):
    errorcode = "HTTP_404"
    errortext = "The requested page could not be found."
    return render_template('error.html', errorcode=errorcode, errortext=errortext)


@app.errorhandler(500)
def server_error(e):
    errorcode = "HTTP_500"
    errortext = "The server has encountered an error. This isn't your fault- try your action again."
    return render_template('error.html', errorcode=errorcode, errortext=errortext)


if __name__ == '__main__':
    WSGIRequestHandler.protocol_version = "HTTP/1.1"
    app.run(host='0.0.0.0', port=80, debug=True)