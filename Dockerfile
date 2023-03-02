FROM ubuntu:22.04
RUN mkdir -p /opt/status-page/
WORKDIR /opt/status-page/
COPY . .
RUN apt-get -y update
RUN apt-get install -y tzdata 
RUN apt install -y vim 
RUN apt install -y postgresql
RUN apt install -y systemctl
RUN systemctl enable postgresql
RUN service postgresql start && \
    su postgres -c "psql -c \"CREATE DATABASE statuspage;\"" && \
    su postgres -c "psql -c \"CREATE USER statuspage WITH PASSWORD 'abcdefgh123456';\"" && \
    su postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE statuspage TO statuspage;\""     
RUN apt install -y redis-server && \
    systemctl enable redis-server && \
    service redis-server start
RUN adduser --system --group status-page
RUN apt install -y python3 python3-pip python3-venv python3-dev build-essential libxml2-dev libxslt1-dev libffi-dev libpq-dev libssl-dev zlib1g-dev 
RUN pip3 install -r requirements.txt
RUN service postgresql start && \
    bash ./upgrade.sh
RUN service postgresql start && \
    sh -c 'python3 -m venv venv' && \
    cd /opt/status-page/statuspage && \
    sh -c 'python3 ./manage.py' && \
    cp /opt/status-page/contrib/gunicorn.py /opt/status-page/gunicorn.py && \
    cp -v /opt/status-page/contrib/status-page.service /etc/systemd/system/ && \
    cp -v /opt/status-page/contrib/status-page-scheduler.service /etc/systemd/system/ && \
    cp -v /opt/status-page/contrib/status-page-rq.service /etc/systemd/system/ && \
    systemctl daemon-reload && \
    systemctl start status-page status-page-scheduler status-page-rq && \
    systemctl enable status-page status-page-scheduler status-page-rq && \
    apt install -y nginx && \
    systemctl enable nginx && \
    service nginx start && \
    cp /opt/status-page/contrib/nginx.conf /etc/nginx/sites-available/status-page.conf && \
    rm /etc/nginx/sites-enabled/default && \
    ln -s /etc/nginx/sites-available/status-page.conf /etc/nginx/sites-enabled/status-page.conf && \
    systemctl enable nginx && \
    service nginx start && \
    service postgresql start 
    
ENTRYPOINT ["sh", "entry.sh"] 
CMD ["sh", "entry.sh" ] 
