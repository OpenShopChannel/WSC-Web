from flask import Flask, render_template, request
from werkzeug.serving import WSGIRequestHandler
import osc

import ssl

OpenShopChannel = osc.API()
OpenShopChannel.load_packages()

app = Flask(__name__)


@app.route("/")
def welcome():
    return render_template('welcome.html')


@app.route("/home")
def home():
    return render_template('home.html', packages=OpenShopChannel.get_packages())


@app.route("/apps")
def apps():
    return render_template('list.html', packages=OpenShopChannel.get_packages())


@app.route("/app")
def application():
    package = OpenShopChannel.package_by_name(request.args.get("package"))
    if package:
        return render_template('app.html', package=package)
    else:
        return render_template('error.html', code="APP-404",
                               description="The app \"{}\" (Internal Name) could not be found.".format(
                                   request.args.get("package")))


# Errors
@app.errorhandler(404)
def page_not_found(e):
    return render_template('error.html', code="HTTP-404",
                           description="Page could not be found. This is not where the shop is :(")


@app.errorhandler(500)
def page_not_found(e):
    return render_template('error.html', code="HTTP-500",
                           description="Something went wrong on the shop. Please report this event!")


if __name__ == '__main__':
    WSGIRequestHandler.protocol_version = "HTTP/1.1"
    context = ssl.SSLContext(ssl.PROTOCOL_TLSv1)
    context.load_cert_chain('cert.pem', 'key.pem')

    app.run(host='127.0.0.1', port=443, debug=True, ssl_context=context)
