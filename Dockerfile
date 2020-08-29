FROM centos:7

ENV PYTHON_VERSION 3.8.1

# yum install
RUN yum update -y \
 && yum groupinstall -y "development tools" \
 && yum install -y \
            bzip2-devel \
            curl \
            gdbm-devel \
            libffi-devel \
            libuuid-devel \
            ncurses-devel \
            openssl-devel \
            readline-devel \
            sqlite-devel \
            sudo \
            tk-devel \
            unzip \
            wget \
            xz-devel \
            zlib-devel\
 && rm -rf /var/cache/yum/* \
 && yum clean all

# git install
RUN yum remove -y git \
 && yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
 && yum install -y \
            libsecret \
            pcre2 \
 && yum install -y git --enablerepo=ius --disablerepo=base,epel,extras,updates \
 && rm -rf /var/cache/yum/* \
 && yum clean all

# Japanese Locale Setting
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
   LANGUAGE="ja_JP:ja" \
   LC_ALL="ja_JP.UTF-8"

# alias
RUN echo "alias ll='ls -la -F'" >> ~/.bashrc

# Python install
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH

RUN git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc \
 && eval "$(pyenv init -)"

RUN pyenv install ${PYTHON_VERSION} \
 && pyenv global ${PYTHON_VERSION}

# pip update
RUN source ~/.bashrc && pip install --upgrade pip

# work directory
WORKDIR /share
