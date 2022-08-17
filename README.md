# Usage

```sh
./image_build.sh [-u USERNAME] [-n DOCKER_NAME] [-f DOCKERFILE]
```

# Docker_pytorch
### image build
```sh
docker image build -t cheesesan/pytorch -f Dockerfile_pytorch .
```

### run continar
```sh
docker run -v /home/bucchiman/git:/home/bucchiman/git -it cheesesan/pytorch:latest
```



# Docker_ros2
### image build
```sh
docker image build -t cheesesan/ros2 -f Dockerfile_ros2 .
```

# Docker GPU
e.g. https://docs.nvidia.com/cuda/wsl-user-guide/index.html
