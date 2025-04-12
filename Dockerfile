FROM ubuntu:22.04


ARG DEBIAN_FRONTEND=noninteractive


RUN apt-get update && \
    apt-get install -y sudo \
                       build-essential \
                       cmake \
                       libc6-dbg \
                       gdb \
                       valgrind \
                       dstat \
                       git \
                       nano \
                       tmux \
                       curl \
                       vim \
                       locales \
                       wget \
                       pkg-config \
                       libreadline-dev \
                       libicu-dev \
                       zlib1g \
                       zlib1g-dev \
                       bash-completion \
                       ninja-build && \
    rm -rf /var/lib/apt/lists/* 

RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8


# you can use your username and password
RUN adduser --disabled-password --gecos "" csci550user && \
    echo 'csci550user:123456' | chpasswd && \
    usermod -aG sudo csci550user


RUN echo 'if [ -f /etc/bash_completion ] && ! shopt -oq posix; then' \
         '. /etc/bash_completion;' \
         'fi' >> /etc/bash.bashrc

# add duckdb to PATH
ENV PATH="/duckdb-build:$PATH"
RUN echo 'export PATH=$PATH:/duckdb-build' >> ~/.bashrc

# copy the files to current folder
WORKDIR /repo
COPY . /repo

# to set version
WORKDIR /
ARG VERSION=1.2.1
ADD v${VERSION}.tar.gz .

# build debug mode
WORKDIR /duckdb-build
RUN cmake ../duckdb-${VERSION} -G Ninja -DCMAKE_BUILD_TYPE=debug -DCMAKE_CXX_STANDARD=20 . 
RUN ninja -j$(($(nproc)/2))
#RUN ninja -j1

# switch user
# USER csci550user

CMD ["/bin/bash"]
