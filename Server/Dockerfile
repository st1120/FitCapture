FROM ubuntu

RUN apt update && apt install -y wget git

WORKDIR /app

COPY . .

RUN chmod +x init.sh
RUN ./init.sh

EXPOSE 5000

CMD [ "python", "app.py" ]