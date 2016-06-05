
FROM debian:latest

# Base
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive \
	&& apt-get install --no-install-recommends --yes \
		clang git cmake make\
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/

# Cuberite
RUN mkdir /minecraft \
	&& cd /minecraft \
	&& git clone https://github.com/cuberite/cuberite.git \
  && cd cuberite \
  && pwd

RUN pwd
# Build
RUN  cd minecraft && cd cuberite && mkdir build-cuberite && cd build-cuberite \
  && cmake .. -DCMAKE_BUILD_TYPE=Release \
  && make -j`nproc` \
  && cd ../Server

RUN mv "$C_HOME"/cuberite/Server "$C_HOME"/Server

COPY configs/ "$C_HOME"/Server

CMD ["Cuberite"]

EXPOSE 25565 8080
VOLUME /minecraft
