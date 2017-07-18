FROM python:2.7

# Install required packages and remove the apt packages cache when done.

RUN apt-get update
RUN apt-get install -y \
       nginx \
       supervisor
RUN rm -rf /var/lib/apt/lists/*

# Copy files from local disk to image
COPY . /home/docker/weather

# install python packages
RUN pip install -U pip setuptools
RUN pip install -r /home/docker/weather/requirements.txt

# setup all the config files
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/sites-available/default
COPY supervisor-app.conf /etc/supervisor/conf.d/

EXPOSE 80
CMD ["supervisord", "-n"]
