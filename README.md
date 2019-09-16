# aarch64-cross-build
Dockerfile for aarch64 cross-build environment(debian9 rootfs)


## Usage
```
toystars-MacBook-Pro:underwater toystar$ docker run -u 0 -it -v /Users/toystar/Development/Projects/underwater/share:/home/build/share toystar/aarch64-cross-build:latest


root@2645978414f7:/home/build# git clone https://toystar@bitbucket.org/toystar/underwatercomm.git
root@2645978414f7:/home/build# cp -a ./underwatercomm underwatercomm_rootfs/home/keti/projects/
root@2645978414f7:/home/build# chroot underwatercomm_rootfs
# cd /home/keti/projects
# cd underwatercomm/targets
# cd board
# cd transmitter_reconf
# make clean
# make FEC=turbo
```
