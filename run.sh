xhost +local:root

XAUTH=/tmp/.docker.xauth

docker run -it \
    --rm \
    --name=rvl-base \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$XAUTH:$XAUTH" \
    --ipc=host \
    --gpus all \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --volume="$(pwd)/demo:/app" \
    hsun/rvl-base:1.0.0 \
    /bin/bash


echo "\n"
echo "Done!!"