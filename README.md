# docker-aosp
Docker image for building android AOSP

## Build image

First, build the image:

```sh
$ docker build --build-arg userid=$(id -u) --build-arg groupid=$(id -g) --build-arg username=$(id -un) -t docker-aosp .
```

Then you can start up new instances with:

```sh
$ docker run -it --rm -v $ANDROID_BUILD_TOP:/aosp docker-aosp
> source build/envsetup.sh
> lunch aosp_arm-eng
> m -j16
```

## Reference

- [AOSP - build tools](https://android.googlesource.com/platform/build/+/master/tools/docker)
- [GitHub - kylemanna/docker-aosp](https://github.com/kylemanna/docker-aosp)