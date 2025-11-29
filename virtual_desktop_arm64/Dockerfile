# ARM64 Virtual Desktop Dockerfile
# Based on matsuolab/virtual_desktop but optimized for ARM64 architecture

FROM ubuntu:22.04

# Build arguments
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USER_NAME=vnc

# Environment variables
ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=all \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    DISPLAY=:0 \
    VNC_PORT=5900 \
    NOVNC_PORT=6080

# Install base packages, display server, and VNC components
RUN apt-get update && apt-get install -y --no-install-recommends \
    openbox \
    supervisor \
    gosu \
    locales \
    tigervnc-standalone-server \
    tigervnc-common \
    websockify \
    curl \
    jq \
    ca-certificates \
    wget \
    x11-utils \
    x11-xserver-utils \
    xdotool \
    dbus-x11 \
    python3 \
    python3-numpy \
    fonts-dejavu \
    fonts-liberation \
    && locale-gen en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install noVNC
RUN mkdir -p /opt/noVNC/utils/websockify \
    && wget -qO- https://github.com/novnc/noVNC/archive/v1.5.0.tar.gz | tar xz --strip 1 -C /opt/noVNC \
    && wget -qO- https://github.com/novnc/websockify/archive/v0.11.0.tar.gz | tar xz --strip 1 -C /opt/noVNC/utils/websockify \
    && ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

# Install VirtualGL for ARM64 (if available, otherwise skip for pure ARM setups)
# Note: VirtualGL may not have ARM64 builds, so this is optional
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then \
        VGL_VERSION=$(curl -s https://api.github.com/repos/VirtualGL/virtualgl/releases/latest | jq -r '.tag_name') && \
        wget https://github.com/VirtualGL/virtualgl/releases/download/${VGL_VERSION}/virtualgl_${VGL_VERSION}_amd64.deb && \
        dpkg -i virtualgl_${VGL_VERSION}_amd64.deb || true && \
        rm virtualgl_${VGL_VERSION}_amd64.deb; \
    fi

# Create user
RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
    useradd -u ${USER_ID} -g ${GROUP_ID} -m -s /bin/bash ${USER_NAME} && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create necessary directories
RUN mkdir -p /tmp/.X11-unix && \
    chmod 1777 /tmp/.X11-unix && \
    chown root:root /tmp/.X11-unix

# Create supervisor config
RUN mkdir -p /etc/supervisor/conf.d
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create startup script
COPY start_x.sh /usr/local/bin/start_x.sh
RUN chmod +x /usr/local/bin/start_x.sh

# Expose ports
EXPOSE ${VNC_PORT} ${NOVNC_PORT}

# Set working directory
WORKDIR /home/${USER_NAME}

# Entry point
ENTRYPOINT ["/usr/local/bin/start_x.sh"]
