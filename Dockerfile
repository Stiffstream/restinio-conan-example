FROM ubuntu:18.10

# Prepare build environment
RUN apt-get update && \
    apt-get -qq -y install gcc g++ \
    cmake curl wget pkg-config \
    libtool
RUN apt-get -qq -y install python3
RUN apt-get -qq -y install python3-pip
RUN pip3 install conan
RUN conan remote add stiffstream https://api.bintray.com/conan/stiffstream/public
RUN conan remote add public-conan https://api.bintray.com/conan/bincrafters/public-conan  

RUN mkdir restinio-conan-example
COPY *.cpp restinio-conan-example/
COPY conanfile.txt restinio-conan-example
COPY CMakeLists.txt restinio-conan-example

RUN echo "*** Building an example ***" \
	&& cd restinio-conan-example \
	&& mkdir build \
	&& cd build \
	&& conan install .. --build=missing \
	&& cmake .. \
	&& cmake --build . --config Release

EXPOSE 8080

WORKDIR /restinio-conan-example/build/bin

CMD ./hello_world_minimal

