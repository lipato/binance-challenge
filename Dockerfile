FROM python:3.6-slim
ENV STATIC_URL /static
ENV STATIC_PATH /var/www/app/static
COPY . /var/www/
RUN pip install -r /var/www/requirements.txt
WORKDIR /var/www/
EXPOSE 8080
CMD [ "gunicorn", "-b" , "0.0.0.0:8080", "wsgi:app"]