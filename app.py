from flask import Flask, render_template, request
import osc

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


@app.route("/patches")
def patches():
    return render_template('warning.html', code="PATCH-WARN", url="/patches/list",
                           description="Many patches could damage or brick your system. The Open Shop Channel is not responsbile for any damages to your Wii.")

@app.route("/patches/list")
def listpatches():
    return render_template('error.html', code="HTTP-503", 
                          description="This service is currently unavailable.")

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
def server_error(e):
    return render_template('error.html', code="HTTP-500",
                           description="Something went wrong on the shop's server. Please report this event!")

@app.errorhandler(503)
def not_implemented():
    return render_template('error.html', code="HTTP-503", 
                          description="This service is currently unavailable. Please report this event!")

if __name__ == '__main__':
    app.run()
