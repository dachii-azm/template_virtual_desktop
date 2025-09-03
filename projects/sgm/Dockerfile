# Use CUDA 11.3 base image with Python 3.7
FROM nvidia/cuda:11.3.1-devel-ubuntu18.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV CUDA_HOME=/usr/local/cuda
ENV PATH=${CUDA_HOME}/bin:${PATH}
ENV LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}
ENV CONDA_ALWAYS_YES=yes
ENV CONDA_AUTO_UPDATE_CONDA=false
ENV CONDA_QUIET=true

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    vim \
    build-essential \
    cmake \
    pkg-config \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    libstdc++6 \
    libgfortran5 \
    libopenblas-dev \
    liblapack-dev \
    libhdf5-dev \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libwebp-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libgtk-3-dev \
    libatlas-base-dev \
    gfortran \
    unzip \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p /opt/conda \
    && rm /tmp/miniconda.sh

# Add conda to PATH
ENV PATH="/opt/conda/bin:$PATH"

# Configure conda to accept terms of service
RUN conda config --set always_yes yes --set changeps1 no && \
    conda config --add channels conda-forge && \
    conda config --set channel_priority strict && \
    conda config --set auto_update_conda false && \
    echo "channels:" > ~/.condarc && \
    echo "  - conda-forge" >> ~/.condarc && \
    echo "  - defaults" >> ~/.condarc && \
    echo "always_yes: true" >> ~/.condarc && \
    echo "auto_update_conda: false" >> ~/.condarc && \
    echo "_verbosity: 0" >> ~/.condarc

# Copy environment.yml and create conda environment
COPY environment.yml /tmp/environment.yml
# Create conda environment
RUN conda env create -f /tmp/environment.yml

# Activate conda environment
SHELL ["conda", "run", "-n", "sgm", "/bin/bash", "-c"]

# Set working directory
WORKDIR /workspace

# Copy the current directory contents
COPY . /workspace/

# Set the default command to activate the conda environment
CMD ["conda", "run", "-n", "sgm", "/bin/bash"]
