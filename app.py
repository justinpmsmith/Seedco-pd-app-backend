from flask import Flask
from flask_cors import CORS
from routes.categories import categories_bp
from routes.trials import trials_bp
from routes.diseases import diseases_bp
from routes.photos import photos_bp


def create_app():
    app = Flask(__name__)

    # Enable CORS for all routes
    CORS(app)

    app.register_blueprint(categories_bp)
    app.register_blueprint(trials_bp)
    app.register_blueprint(diseases_bp)
    app.register_blueprint(photos_bp)
    return app


if __name__ == "__main__":
    app = create_app()
    app.run(debug=True)