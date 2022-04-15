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

