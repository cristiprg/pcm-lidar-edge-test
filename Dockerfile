FROM ubuntu:latest
# FROM openjdk:8-jre
#FROM singularities/spark:1.6 - consider this as base image in the future
#MAINTAINER Anuyog Chauhan "anuyog.chauhan@aricent.com"

RUN apt-get update -y
# RUN apt-get install -y python-pip python-dev build-essential
RUN apt-get install -y libopencv-dev libopencv-ml-dev libcgal-dev libboost-regex1.58.0 libboost-log1.58-dev

# RUN apt-get install -y procps netcat net-tools less

# Download Spark
# TODO: verify integrity of archive, md5sum or similar
# RUN wget -nv http://mirror.netcologne.de/apache.org/spark/spark-1.6.3/spark-1.6.3-bin-hadoop2.6.tgz && \
# 	mkdir -p /app && \
# 	tar xzf ./spark-1.6.3-bin-hadoop2.6.tgz -C /app && \
# 	rm ./spark-1.6.3-bin-hadoop2.6.tgz


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

RUN apt-get install -y python-pip
RUN pip install -r requirements.txt
# RUN mv /app/log4j.properties /app/spark-1.6.3-bin-hadoop2.6/conf



RUN chmod +x /app/start.sh
ENTRYPOINT ["/app/start.sh"]
# CMD ["+x /app/start.sh"]

# ENTRYPOINT ["python"]
# CMD ["service-time.py"]

# ENTRYPOINT ["/bin/bash"]
#ENTRYPOINT ["/app/spark-1.6.3-bin-hadoop2.6/bin/run-example", "streaming.NetworkWordCount", "localhost", "9999"]
