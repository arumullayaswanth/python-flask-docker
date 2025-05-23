FROM python:3.13-alpine
LABEL maintainer="yaswanth@gmail.com"
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT ["python"]
CMD ["src/app.py"]
