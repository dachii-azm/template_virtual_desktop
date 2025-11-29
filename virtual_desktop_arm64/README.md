# ARM64 Virtual Desktop Docker Image

This is an ARM64-compatible version of the virtual desktop image, designed to work on Raspberry Pi and other ARM64 systems.

## Building the Image

### On the Raspberry Pi:

1. Copy this directory to your Raspberry Pi:
   ```bash
   scp -r virtual_desktop_arm64 prox-admin@raspberrypi.local:~/
   ```

2. SSH into the Raspberry Pi:
   ```bash
   ssh prox-admin@raspberrypi.local
   ```

3. Navigate to the directory and build:
   ```bash
   cd ~/virtual_desktop_arm64
   chmod +x build_arm64.sh
   ./build_arm64.sh virtual_desktop_arm64:latest
   ```

### Alternative: Direct build command

```bash
cd ~/virtual_desktop_arm64
docker build --platform linux/arm64 -t virtual_desktop_arm64:latest .
```

## Running the Container

### Basic run:
```bash
docker run -d \
  --name azuma_desktop \
  -p 6090:6080 \
  -e DISPLAY=:1 \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  virtual_desktop_arm64:latest
```

### With GPU support (if available):
```bash
docker run -d \
  --name azuma_desktop \
  --runtime=nvidia \
  -p 6090:6080 \
  -e DISPLAY=:1 \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  virtual_desktop_arm64:latest
```

## Accessing the Desktop

Open in your browser: http://localhost:6090

## Updating Your docker-compose.yaml

To use this image instead of the original, update your docker-compose.yaml:

```yaml
services:
  desktop:
    image: virtual_desktop_arm64:latest  # Changed from ghcr.io/matsuolab/virtual_desktop:latest
    # ... rest of your configuration
```

## Architecture Notes

This image is built specifically for ARM64 (linux/arm64) architecture and includes:
- Ubuntu 22.04 base
- TigerVNC server
- noVNC for browser access
- Openbox window manager
- Supervisor for process management

Note: VirtualGL may not be available for ARM64 and is conditionally installed only on amd64 systems.
