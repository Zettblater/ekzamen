FROM python

WORKDIR /web

COPY server.py ./

CMD [ "python", "server.py" ]
