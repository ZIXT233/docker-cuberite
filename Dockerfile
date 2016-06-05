
FROM debian:latest

# Base
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive \
	&& apt-get install --no-install-recommends --yes \
		ca-certificates clang git cmake make\
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/

# Cuberite
RUN mkdir /minecraft \
	&& cd /minecraft \
	&& git clone --recursive https://github.com/cuberite/cuberite.git \
  && cd cuberite \
  && pwd

RUN pwd
# Build
RUN  cd /minecraft && cd cuberite && mkdir build-cuberite && cd build-cuberite \
  && cmake .. -DCMAKE_BUILD_TYPE=Release \
  && make -j`nproc` \
  && cd ../Server

RUN mv minecraft/cuberite/Server minecraft/Server

COPY configs/ minecraft/Server

CMD ["Cuberite"]

EXPOSE 25565 8080
VOLUME /minecraft
