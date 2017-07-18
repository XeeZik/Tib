# Dockerfile for for Otxserver server project
FROM ubuntu:16.04
#FROM mattrayner/lamp:latest-1604

# Add data to app path
ADD . /app
# Copy config.lua to config path
RUN mkdir -p /config
COPY config.lua /config

# install build dependencies
RUN apt-get update -qq && apt-get install -qq -y \
		git \
		cmake \
		build-essential \
		liblua5.2-dev \
		libgmp3-dev \
		libmysqlclient-dev \
		libboost-system-dev \
		libboost-iostreams-dev \
		libpugixml-dev \
		unzip

# unpack global map
WORKDIR /app/data/world
RUN unzip global.zip

# Compile it
WORKDIR /app
RUN mkdir -p build && cd build && cmake .. && make 
RUN cp build/tfs .

# Cleanup
RUN rm -fr ./src ./vc14 ./cmake ./build

# Add volumes for the app
VOLUME  [ "/config", "/logs" ]
EXPOSE 7171 7172 7173
CMD ["/app/tfs", "-c", "/config/config.lua" , "2>&1" , "|", "tee", "/logs/lastRun.log" ]
