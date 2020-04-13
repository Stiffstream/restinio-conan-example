FROM ubuntu:19.10
ARG boost_libs
ARG boost_libs=none

# Prepare build environment
RUN apt-get update && \
    apt-get -qq -y install gcc g++ \
    cmake curl wget pkg-config \
    libtool python3 python3-pip

RUN pip3 install conan

RUN conan profile new default --detect
RUN conan profile update settings.compiler.libcxx=libstdc++11 default

RUN \
    conan remote add stiffstream https://api.bintray.com/conan/stiffstream/public && \
    conan remote add public-conan https://api.bintray.com/conan/bincrafters/public-conan

RUN mkdir restinio-conan-example
COPY *.cpp restinio-conan-example/
COPY conanfile.txt restinio-conan-example
COPY CMakeLists.txt restinio-conan-example

RUN echo "*** Building an example ***" \
	&& cd restinio-conan-example \
	&& mkdir build \
	&& cd build \
	&& conan install -o restinio:boost_libs=$boost_libs --build=missing ..  \
	&& cmake .. \
	&& cmake --build . --config Release

EXPOSE 8080

WORKDIR /restinio-conan-example/build/bin

CMD ./hello_world_minimal

