xhost +local:root

XAUTH=/tmp/.docker.xauth

docker run -it \
    --rm \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$XAUTH:$XAUTH" \
    --ipc=host \
    --gpus all \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
     --net=host \
     --privileged \
    --volume="$(pwd)/demo:/app" \
    tokohsun/rvl-base:1.0.0 \
    /bin/bash


echo "\n"
echo "Done!!"