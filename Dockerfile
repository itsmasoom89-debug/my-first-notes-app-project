FROM python:3.9

WORKDIR /app/backend

COPY requirements.txt /app/backend

# Install system dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    # added default-mysql-client to support mysqladmin command used for DB readiness check
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/backend

EXPOSE 8000

# using runserver for simplicity (can be replaced with gunicorn in production)
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

# RUN python manage.py migrate
# RUN python manage.py makemigrations
