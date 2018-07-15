FROM amazonlinux

ENV PYTHON_VERSION 3.6.5

# Install OS packages
RUN yum -y update \
    && yum -y groupinstall "Development tools" \
    && yum -y install libxml2-devel libxslt-devel \
    && yum -y install wget gcc zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel

# Install Python3
RUN curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
RUN tar zxf Python-${PYTHON_VERSION}.tgz
RUN rm Python-${PYTHON_VERSION}.tgz
WORKDIR Python-${PYTHON_VERSION}
RUN ./configure --prefix=/opt/local
RUN make
RUN make altinstall
ENV PATH /opt/local/bin:$PATH
RUN ln -s /opt/local/bin/python3.6 /opt/local/bin/python3

# Install pip
RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py

RUN pip3 install -qqqU awscli
RUN pip3 install nltk
RUN python3 -m nltk.downloader all
RUN pip3 install tinysegmenter
RUN pip3 install numpy

# Grab some commonly used packages
RUN mkdir ~/packages
RUN wget --directory-prefix=~/packages --no-verbose --no-check-certificate 'https://github.com/Miserlou/lambda-packages/files/1425358/_sqlite3.so.zip'

#RUN groupadd --gid 3434 devops \
#  && useradd --uid 3434 --gid devops --shell /bin/bash --create-home devops \
#  && echo 'devops ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-devops \
#  && echo 'Defaults env_keep += noninteractive' >> /etc/sudoers.d/env_keep
#
#USER devops

CMD ["/bin/bash"]
