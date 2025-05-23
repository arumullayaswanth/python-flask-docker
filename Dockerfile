FROM python:3.13-alpine
LABEL maintainer="yaswanth.arumulla@gmail.com"
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 8080
ENTRYPOINT ["python"]
CMD ["src/app.py"]
