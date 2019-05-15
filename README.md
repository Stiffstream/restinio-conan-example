This repository contains a simple example that use [RESTinio](https://stiffstream.com/en/products/restinio.html) via the corresponding Conan package.

RESTinio uses standalone version of Asio or the one from Boost. 

# How To Try

## Docker
The simplest way is to use Docker and Dockerfile from the repository. For example:
```bash
git clone https://github.com/Stiffstream/restinio-conan-example
cd restinio-conan-example
docker build -t restinio-conan-example .
docker run -p 8080:8080 restinio-conan-example &
curl http://localhost:8080/
```

All necessary steps like installing Python, PIP, conan, CMake and so on are performed in Dockerfile. 
You can check Dockerfile content to see how conan can be configured and used.

To test RESTinio with Boost.ASIO one shoud build docker with one of the following:
```bash
docker build --build-arg boost_libs=static -t restinio-conan-example .
docker build --build-arg boost_libs=shared -t restinio-conan-example .
```

## Manual Build
To perform manual build it is necessary to have conan and CMake installed. Then you can do the following steps:
```bash
# Add remote for conan to find RESTinio package.
conan remote add stiffstream https://api.bintray.com/conan/stiffstream/public
# Add remote for conan to find RESTinio's dependencies.
conan remote add public-conan https://api.bintray.com/conan/bincrafters/public-conan  
# Clone the demo repository.
git clone https://github.com/Stiffstream/restinio-conan-example
cd restinio-conan-example
# Build the example.
mkdir build && cd build
conan install .. --build=missing
# Or 
# conan install -o restinio:boost_libs=static .. --build=missing
# conan install -o restinio:boost_libs=shared .. --build=missing
cmake ..
cmake --build . --config Release
# Check the example.
./bin/hello_world_minimal &
curl http://localhost:8080/
```

