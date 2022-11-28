import os
from src.app import app
from src.app.routes import routes

routes(app)

if __name__ == "__main__":
    app.run(port=int(os.environ.get("PORT", 8080)), host='0.0.0.0',debug=True)
