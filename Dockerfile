FROM ubuntu
RUN sed -i'' 's/archive\.ubuntu\.com/us\.archive\.ubuntu\.com/' /etc/apt/sources.list
RUN apt-get update 
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app
COPY . /app

RUN apt-get install -y apache2 \
    -y apache2-utils

RUN apt-get clean

RUN apt-get install -y software-properties-common


RUN apt install python3-pip -y
RUN pip install -r software.txt

RUN python3 manage.py migrate
EXPOSE 8000
CMD ["python3", "manage.py", "runserver","0:8000"]