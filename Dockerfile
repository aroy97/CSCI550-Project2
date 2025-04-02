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


ARG VERSION=1.2.1
ADD v${VERSION}.tar.gz .

# build debug mode
WORKDIR ./duckdb-${VERSION}
RUN cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_STANDARD=20 . && \
    ninja -j$(nproc)


# switch user
USER csci550user

CMD ["/bin/bash"]
