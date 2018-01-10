FROM ubuntu:latest
MAINTAINER Anuyog Chauhan "anuyog.chauhan@aricent.com"

RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential

# Install Java 8
# https://newfivefour.com/docker-java8-auto-install.html
#RUN apt-get -y install software-properties-common && \
#	add-apt-repository -y ppa:webupd8team/java && \
#	echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
#	echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
#	apt-get update -y && \
#	apt-get -y install oracle-java8-installer


COPY ./workload_LidarDataPredict /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["service-time.py"]
