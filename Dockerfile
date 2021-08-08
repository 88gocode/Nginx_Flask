From alpine:latest
RUN  apk update
COPY request_py3.txt /tmp/requirements.txt
RUN apk add --no-cache \
    python3 \
    python3-dev \
    build-base \
    linux-headers \
    pcre-dev \
    bash \
    curl \
    nginx \
    vim \
    supervisor && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    pip3 install uwsgi && \
    pip3 install -r /tmp/requirements.txt && \
    rm -r /root/.cache
RUN  mkdir -p  /run/nginx/
RUN  touch /run/nginx/nginx.pid
COPY ./demo.py  /var/www/html/WebPython/
COPY ./uwsgi.ini  /var/www/html/WebPython/
COPY nginx_default.conf /etc/nginx/conf.d/default.conf
WORKDIR /var/www/html/WebPython
COPY "start_up.sh" "/var/local"
RUN chmod 755 /var/local/start_up.sh
CMD [ "/bin/bash", "-c" , "/var/local/start_up.sh ;"]
