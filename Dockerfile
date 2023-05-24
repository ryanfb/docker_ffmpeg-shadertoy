FROM ubuntu:latest

RUN sed -i -e 's/# deb-src/deb-src/' /etc/apt/sources.list && apt-get update && apt-get install -y xvfb libosmesa6 git && apt-get build-dep -y ffmpeg && rm -rf /var/lib/apt/lists/*

ADD https://gitlab.com/kriwkrow/ffmpeg_shadertoy_filter/-/archive/main/ffmpeg_shadertoy_filter-main.tar.gz .
RUN tar xzvf ffmpeg_shadertoy_filter-main.tar.gz
WORKDIR /ffmpeg_shadertoy_filter-main
RUN ./install_dependencies
RUN git clone --depth=1 https://git.ffmpeg.org/ffmpeg.git ffmpeg_source
RUN ./patch_ffmpeg && ./configure_ffmpeg && ./compile_ffmpeg
ENV GLFW_CONTEXT_CREATION_API=GLFW_OSMESA_CONTEXT_API
