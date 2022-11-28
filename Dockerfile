
# # Use the official lightweight Python image.
# # https://hub.docker.com/_/python
# COPY . /src/app
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1
# ENV POETRY_VERSION 1.0
# RUN pip install "poetry==$POETRY_VERSION"
# WORKDIR /app
# COPY poetry.lock /app
# COPY pyproject.toml /app
# RUN poetry config virtualenvs.create false \
# && poetry install --no-interaction --no-ansi
# COPY . .
# CMD gunicorn --bind 0.0.0.0:5000 app:app
FROM python:3.10-slim

ENV FLASK_APP=app.py
ENV FLASK_ENV=development
ENV FLASK_DEBUG=True
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=8080
ENV SECRET_KEY=ALGUMSEGREDO
ENV OAUTHLIB_INSECURE_TRANSPORT=1
ENV FRONTEND_URL=https://labinventory-devinhouse.web.app/
ENV BACKEND_URL=https://labinventory-backend-vjqcwqvuka-uc.a.run.app/
ENV PORT=8080

WORKDIR /app
COPY . .
RUN pip3 install -r requirements.txt
EXPOSE 8080
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser
CMD [ "python3", "app.py" ]
