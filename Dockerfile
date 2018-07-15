FROM amazonlinux:latest

# Install python 3.6 and development tools
RUN yum -y update \
    && yum -y upgrade \
    && yum -y groupinstall "Development Tools"  \
    && yum -y install python36-devel python36-pip gcc \
    && yum -y install libxml2-devel libxslt-devel

RUN easy_install-3.6 pip
RUN pip3 install -qqqU awscli
RUN pip3 install nltk
RUN python3 -m nltk.downloader all
RUN pip3 install tinysegmenter
RUN pip3 install numpy

# Grab some commonly used packages
RUN mkdir ~/packages
RUN wget --directory-prefix=~/packages --no-verbose --no-check-certificate 'https://github.com/Miserlou/lambda-packages/files/1425358/_sqlite3.so.zip'

USER circleci

CMD ["/bin/sh"]