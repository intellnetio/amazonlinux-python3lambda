FROM amazonlinux

# Install OS packages
RUN yum -y upgrade \
    && yum -y update \
    && yum -y groupinstall "Development tools" \
    && yum -y install libxml2-devel libxslt-devel \
    && yum -y install wget gcc zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel nano

RUN amazon-linux-extras install -y python3=3.6.2

RUN wget https://bootstrap.pypa.io/get-pip.py && python2 get-pip.py

# Upgrade pip
RUN pip3 install --upgrade pip
RUN pip2 install --upgrade pip

# Install virtualenv because venv doesn't come with python3.6 apparently
RUN pip3 install virtualenv
RUN pip2 install virtualenv

RUN pip3 install lxml
RUN pip2 install lxml

# Install AWS CLI, NLTK, NLTK_DATA, numpy, tinysegmenter
RUN pip3 install -qqq awscli nltk tinysegmenter numpy
RUN pip2 install -qqq awscli nltk tinysegmenter numpy

# Grab some commonly used packages
RUN mkdir /packages
RUN cd /packages && wget --no-verbose --no-check-certificate 'https://github.com/Miserlou/lambda-packages/files/1425358/_sqlite3.so.zip'

CMD ["/bin/bash"]
