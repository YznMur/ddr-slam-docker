xhost +
sudo nvidia-docker run  --runtime=nvidia -ti -v /tmp/.X11-unix:/tmp/.X11-unix --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -e DISPLAY=$DISPLAY -v $(pwd)/Dataset:/home/Dataset -v $(pwd)/DDRSLAM:/root/ddr_orb2 --name=ddrslam --gpus all ddrslam bash

