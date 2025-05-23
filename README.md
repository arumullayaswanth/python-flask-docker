# Python Flask App with Docker on EC2 & AWS Lambda 

This is a simple Python Flask application that prints the **hostname** and **IP address** of the container it's running in.

## 🐳 Part 1:  EC2

### 📦 Prerequisites

* AWS EC2 instance (Amazon Linux 2 or similar)

---

## 🚀 Setup  Python Flask App with EC2

### 1. Install Git

```bash
sudo yum install git -y
```

### 2. Clone the Repository

```bash
git clone https://github.com/arumullayaswanth/python-flask-docker.git
cd python-flask-docker
```

### 3. Install Python3 and pip

```bash
sudo yum install python3 -y
sudo yum install python3-pip -y
```

### 4. Install Flask Requirements

```bash
pip3 install -r requirements.txt
```

### 5. Navigate to App Directory

```bash
cd src/
ls
```

### 6. Run the App

```bash
python3 app.py
```

> 🔍 To check running processes:

```bash
ps aux | grep python
```

---

## 🌀 Run App in Background with `nohup`

`nohup` allows your app to continue running even after terminal disconnect:

```bash
nohup python3 app.py > flask.log 2>&1 &
```

> 💪 Check logs:

```bash
tail -f flask.log
```

> ❗ If port 5000 is in use:

```bash
lsof -i :5000
kill -9 <PID>
```

---
# 🚀 Python Flask App in Docker on AWS EC2

This guide walks you through setting up a Python Flask app inside a Docker container on an AWS EC2 instance.

---

## 📦 Prerequisites

* AWS EC2 instance (Amazon Linux 2 or similar)
* Security group allowing inbound traffic on **port 5000**
* SSH access to EC2 instance

---

## 🧰 Step-by-Step Setup

### 1. ✅ Install System Dependencies

```bash
sudo yum update -y
sudo yum install git -y
sudo yum install python3-pip -y
```

### 2. 🔄 Clone the GitHub Repository

```bash
git clone https://github.com/arumullayaswanth/python-flask-docker.git
cd python-flask-docker
```

### 3. 📦 Install Python Dependencies

```bash
pip3 install -r requirements.txt
```

### 4. 🐳 Install and Enable Docker

```bash
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
```

If

---

## 🐋 Dockerize the Application

### 5. 📄 Dockerfile (should already exist)

Ensure the file has the following content:

```Dockerfile
FROM python:3.13-alpine
LABEL maintainer="yaswanth@gmail.com"
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT ["python"]
CMD ["src/app.py"]
```

### 6. 🏗️ Build Docker Image

```bash
docker build -t flask-docker-app .
docker images
```

### 7. 🚀 Run the Docker Container

```bash
docker run -d -p 5000:5000 flask-docker-app
docker ps
```

### 8. ✅ Verify

Open your browser and visit:

```
http://<your-ec2-public-ip>:5000
```

---

## 🧼 Useful Docker Commands

```bash
# List running containers
docker ps

# List all containers
docker ps -a

# Stop a container
docker stop <container-id>

# Kill a container
docker kill <container-id>

# Remove stopped containers
docker container prune
```

---

## ☁️ AWS Lambda (Optional Version)

You **can’t run Flask directly** on Lambda, but here’s what you can do:

### ✅ If you need API-like behavior in Lambda:

* Use **AWS Lambda + API Gateway** instead of Flask.
* Convert Flask logic into a Lambda-compatible handler:

```python
import json
import socket

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps({
            'hostname': socket.gethostname(),
            'ip': socket.gethostbyname(socket.gethostname())
        })
    }
```

### 🛠️ Package and Deploy

1. Create a zip package of your code.
2. Deploy it to Lambda.
3. Use API Gateway to trigger it.

---

## �� Clean Up

```bash
ps aux | grep python
kill -9 <PID>  # If needed
docker ps
docker stop <container_id>
```

---

## 🙌 Done!

Your Flask app is now running in Docker on EC2, and optionally portable to Lambda.
