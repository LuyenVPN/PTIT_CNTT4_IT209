# Bài 1: Kiểm tra cài đặt Docker Engine và chạy Container Hello-World

## 1. Kiểm tra phiên bản Docker CLI và Docker Engine

**Lệnh thực hiện:**

```bash
docker version
```

**Kết quả:**

```text
Client:
 Version:           25.0.14
 API version:       1.44
 Go version:        go1.25.12 X:nodwarf5
 Git commit:        0bab007
 Built:             Tue Jul 28 00:00:00 2026
 OS/Arch:           linux/amd64
 Context:           default

Server:
 Engine:
  Version:          25.0.16
  API version:      1.44 (minimum version 1.24)
  Go version:       go1.25.12 X:nodwarf5
  Git commit:       6fdf0a6
  Built:            Tue Jul 28 00:00:00 2026
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          2.2.7+unknown
 runc:
  Version:          1.3.6
  GitCommit:        491b69bab9fa206b984fb26ba07d3110d62e671f
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

## 2. Kiểm tra thông tin Docker Engine

**Lệnh thực hiện:**

```bash
docker info
```

**Kết quả:**

```text
Client:
 Version:    25.0.14
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  0.12.1
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 25.0.16
 Storage Driver: overlay2
  Backing Filesystem: xfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: systemd
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 Swarm: inactive
 Runtimes: runc io.containerd.runc.v2
 Default Runtime: runc
 Init Binary: docker-init
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.18.51-120.163.amzn2023.x86_64
 Operating System: Amazon Linux 2023.12.20260930
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 913.2MiB
 Name: ip-172-31-34-25.ap-southeast-2.compute.internal
 ID: 9f74ef17-1c77-48a8-991a-521774bb901c
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
```

## 3. Chạy container Hello-World

**Lệnh thực hiện:**

```bash
docker run hello-world
```

**Kết quả:**

```text
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
4f55086f7dd0: Pull complete
Digest: sha256:5e23090353324d887c48ad5e5c56d294eab81588df9605b07d1afe895f9cc8f8
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
```
