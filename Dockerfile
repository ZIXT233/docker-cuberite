
FROM debian:latest

# Base
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive \
	&& apt-get install --no-install-recommends --yes \
		ca-certificates clang git cmake make\
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/

# Cuberite
RUN git clone --recursive https://github.com/cuberite/cuberite.git \
  && cd cuberite \
  && pwd

# Build
RUN  cd cuberite && mkdir build-cuberite && cd build-cuberite \
  && cmake .. -DCMAKE_BUILD_TYPE=Release \
  && make -j 2\
  && cd ../Server

COPY configs/ /cuberite/Server
COPY scripts/start.sh /cuberite/Server

WORKDIR /cuberite/Server
CMD ["./start.sh"]

EXPOSE 25565 8080
VOLUME ["/cuberite"]
