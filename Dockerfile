FROM cloudera/quickstart:latest

MAINTAINER CeShine Lee

RUN yum install -y https://centos6.iuscommunity.org/ius-release.rpm

RUN yum install -y python35u python35u-pip python35u-devel
RUN yum -y install gcc-c++ freetype-devel libpng-devel atlas-devel blas-devel pandoc

RUN pip3.5 install -U pip
RUN pip3.5 install -U jupyter nano
RUN pip3.5 install -U py4j

# Install Scipy Stack
RUN pip3.5 install -U  numpy scipy matplotlib
RUN pip3.5 install -U "pandas>=0.14.0"
RUN pip3.5 install -U "scikit-learn>=0.14.0"
RUN pip3.5 install seaborn ggplot

RUN  ln -s /etc/hive/conf/hive-site.xml /etc/spark/conf

ENV SPARK_HOME /usr/lib/spark
ENV PYSPARK_PYTHON python3.5
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.9-src.zip

RUN mkdir /src
ADD jupyter_notebook_config.py /src
WORKDIR /src
