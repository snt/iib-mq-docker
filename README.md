# IIB/MQ Docker image



## Preparing

Obtain following files from IBM site with your license:

- `10.0.0-IIB-LINUXX64-FP0004.tar.gz`
- `WS_MQ_V8.0.0.4_LINUX_ON_X86_64_IM.tar.gz`

## Build Docker image

```
docker build -t sntk/iib10fp4 .
```

## Run

Assuming
- you are going to save message flows in `~/src/iib-workspace`,
- your host machine IP address is `192.168.123.1` and X11 is listening on `:0`

Run the image as below

```
docker run -ti -e DISPLAY=192.168.123.1:0 -v ~/src/iib-workspace/:/workspace sntk/iib10fp4
```

If you don't want to expose X11 outside your machine or IP address of your machine is dynamically assigned, refer below to use IP alias.

### Note for Mac user running [Docker for Mac](https://docs.docker.com/docker-for-mac/)

- Run X11 server, [XQuartz](https://www.xquartz.org/).
- Make sure XQuartz is listening on port `6000` with `lsof -i :6000`,
    - open Preferences then check "Allow connections from network clients" on Security tab then restart XQuartz, if not listening.
- Assign IP Alias to loopback network by `sudo ifconfig lo0 alias 192.168.123.1 255.255.255.0`
    - This let you use fixed IP address inside your machine.
- Allow X11 access from `192.168.123.1` by `xhost +192.168.123.1`

```
docker run -ti -e DISPLAY=192.168.123.1:0 -v ~/src/iib-workspace/:/workspace sntk/iib10fp4
```

## Starting Toolkit

On the `bash` in the container, run

```
/iib-10.0.0.4/iib toolkit
```

Toolkit window will appear in your X11.

Switch your workspace
- Open File Menu / Switch Workspace / Other...
- Select `/workspace` which is linked to `~/src/iib-workspace` on your host machine.

