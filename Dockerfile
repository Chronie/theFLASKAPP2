FROM python:latest

WORKDIR /app

COPY requirements.txt /app
RUN pip install -r requirements.txt

COPY . /app

ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=tlmjmbl24d
ENV POSTGRES_DB=mydb

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /scripts
RUN chmod +x /scripts/wait-for-it.sh
ENTRYPOINT ["/scripts/wait-for-it.sh", "db:5432", "--"]

CMD ["python", "runserver", "app.py", "--host=0.0.0.0", "--threaded"]