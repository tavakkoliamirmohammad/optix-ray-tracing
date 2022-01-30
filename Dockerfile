FROM nvidia/cuda:11.4.2-devel-ubuntu20.04 AS builder
ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_DRIVER_CAPABILITIES graphics,compute,utility,display
RUN apt-get update && apt-get install -y cmake ffmpeg libglu1-mesa-dev freeglut3-dev \
  mesa-common-dev libglfw3-dev libxinerama-dev libxrandr-dev libxcursor-dev \
  --no-install-recommends  && rm -rf /var/lib/apt/lists/*
COPY . /app
WORKDIR /app/src
RUN mkdir -p ../build && cmake -DOptiX_INSTALL_DIR=/app/OptiX_SDK -B../build && cd ../build && make
WORKDIR /app/build/bin
ENTRYPOINT ["./optixPathTracer", "--scene"]
#FROM nvidia/cuda:11.4.2-devel-ubuntu20.04
#ENV NVIDIA_DRIVER_CAPABILITIES graphics,compute,utility,display,video
#ENV LD_LIBRARY_PATH ${LDLIBRARY_PATH}:/code/lib
#WORKDIR /code
#RUN apt-get update && apt-get install -y libx11-dev libxrandr-dev libxinerama-dev  libxcursor-dev strace \
#  && rm -rf /var/lib/apt/lists/*
#COPY --from=builder /app /app
#COPY --from=builder /app/scenes /code/scenes
#COPY --from=builder /app/optix_sdk_7_2_0/src/build/lib /code/lib
#COPY --from=builder /app/optix_sdk_7_2_0/src/cuda /code/cuda
#COPY --from=builder /app/optix_sdk_7_2_0/src/support /code/support
#COPY --from=builder /app/optix_sdk_7_2_0/src/optixPathTracer /code/optixPathTracer
#COPY --from=builder /app/optix_sdk_7_2_0/src/sutil /code/sutil
#COPY --from=builder /app/optix_sdk_7_2_0/src/build/bin/optixPathTracer /code/raytraceer
#COPY --from=builder /app/OptiX_SDK/include /usr/local/cuda/include
