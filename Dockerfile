
# # Use the official lightweight Python image.
# # https://hub.docker.com/_/python
# FROM python:3.10-slim

# # # Allow statements and log messages to immediately appear in the Knative logs
# ENV PYTHONUNBUFFERED True

# # Copy local code to the container image.
# ENV APP_HOME /app
# # ENV FLASK_APP=app.py
# # ENV FLASK_ENV=development
# # ENV FLASK_DEBUG=True
# # ENV FLASK_RUN_HOST=0.0.0.0
# # ENV FLASK_RUN_PORT=8080
# # ENV SECRET_KEY=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
# # ENV OAUTHLIB_INSECURE_TRANSPORT=1
# # ENV FRONTEND_URL=https://mcoelho-people.web.app/
# # ENV BACKEND_URL=http://localhost:5000/
# ENV PORT=3000
# WORKDIR $APP_HOME
# # COPY . ./

# # # Install production dependencies.
# # RUN pip install --no-cache-dir -r requirements.txt
# RUN pip install gunicorn

# # CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app



# # WORKDIR /app

# COPY . ./

# RUN pip3 install -r requirements.txt

# RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
# ENTRYPOINT app.py
# USER appuser
# CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app

# CMD [ "python3", "app.py" ]
FROM python:3.10
COPY . /src/app
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV POETRY_VERSION 1.0
RUN pip install "poetry==$POETRY_VERSION"
WORKDIR /app
COPY poetry.lock /app
COPY pyproject.toml /app
RUN poetry config virtualenvs.create false \
&& poetry install --no-interaction --no-ansi
COPY . .
CMD gunicorn --bind 0.0.0.0:5000 app:app