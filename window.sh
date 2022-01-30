xhost +local:root
sudo docker run --rm \
--volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
--volume=/dev/input:/dev/input:rw \
--volume=/home/tavakoli/project/remote-real-time-ray-tracing/models:/app/models:ro \
--volume=/home/tavakoli/project/remote-real-time-ray-tracing/scenes:/app/scenes:ro \
--volume=/var/tmp/OptixCache_root:/var/tmp/OptixCache_root \
--env="DISPLAY" \
-it --gpus all test ./optixPathTracer --scene ../../scenes/sponza_dark.txt
