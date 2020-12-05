from flask import Flask, render_template, request
import metadata

metadata = metadata.API()
metadata.load_packages()

app = Flask(__name__)


@app.route("/")
def home():
    return render_template('home.html')


@app.route("/apps")
def apps():
    return render_template('list.html', packages=metadata.get_packages())


@app.route("/app")
def application():
    return render_template('app.html', package=metadata.package_by_name(request.args.get("package")))


if __name__ == '__main__':
    app.run()
