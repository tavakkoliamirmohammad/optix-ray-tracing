xhost +local:root
sudo docker run --rm \
--volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
--volume=/dev/input:/dev/input:rw \
--volume=/var/tmp/OptixCache_root:/var/tmp/OptixCache_root \
--env="DISPLAY" \
-it --gpus all test bash
