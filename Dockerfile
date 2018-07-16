FROM amazonlinux

# Install OS packages
RUN yum -y upgrade \
    && yum -y update \
    && yum -y groupinstall "Development tools" \
    && yum -y install libxml2-devel libxslt-devel \
    && yum -y install wget gcc zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel

RUN amazon-linux-extras install -y python3=3.6.2

# Upgrade pip
RUN pip3 install --upgrade pip

# Install virtualenv because venv doesn't come with python3.6 apparently
RUN pip3 install virtualenv

RUN pip3 install lxml

# Install AWS CLI, NLTK, NLTK_DATA, numpy, tinysegmenter
RUN pip3 install -qqq awscli nltk tinysegmenter numpy

# Grab some commonly used packages
RUN mkdir /packages
RUN cd /packages && wget --no-verbose --no-check-certificate 'https://github.com/Miserlou/lambda-packages/files/1425358/_sqlite3.so.zip'

#RUN groupadd --gid 3434 devops \
#  && useradd --uid 3434 --gid devops --shell /bin/bash --create-home devops \
#  && echo 'devops ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-devops \
#  && echo 'Defaults env_keep += noninteractive' >> /etc/sudoers.d/env_keep
#
#USER devops

CMD ["/bin/bash"]
