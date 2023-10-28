## Docker Image: Debian Bookworm with XFCE UI and RDP Connectivity

This Docker image is designed to run Debian Bookworm with the XFCE user interface, allowing connectivity via Remote Desktop Protocol (RDP). It's specifically optimized for lightweight server or game server purposes.

### Usage

To run the Docker container, use the following command:

```
docker run -d \
   --name debianContainer_01 \
   -e USER_PASSWORD=test123 \
   -p 3399:3389 \
   debianrdp
```

Please note:
- the port mapping used (3399:3389) to ensure successful connection as the standard RDP port (3389) might lead to connection failures.
- the default user password is "changeme" if you remove the ENV VAR "USER_PASSWORD"

### Important Information

For successful authentication, it's crucial to avoid using the default RDP port (3389). The provided command utilizes port 3399 for RDP connections to the container.

### Optimization

Upon accessing the xrdp login interface, only the password needs to be provided for authentication, simplifying the login process.

### Note

This image is primarily intended for server and game server applications. It provides a lightweight Debian Bookworm environment with the XFCE user interface, offering RDP connectivity for remote access.
