# Use NVIDIA CUDA base image
FROM nvcr.io/nvidia/cuda:11.6.0-cudnn8-devel-ubuntu20.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    wget \
    git \
    build-essential \
    cmake \
    libopenblas-dev \
    libopencv-dev \
    lsb-release \
    vim \
    sudo \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install Cmake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository "deb https://apt.kitware.com/ubuntu/ focal main" && \
    apt update && apt install cmake -y

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
    && bash miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh

# Add conda to PATH
ENV PATH /opt/conda/bin

# Initialize conda for shell interaction
RUN conda init bash

# Create and activate conda environment
RUN conda create -n test python=3.8 -y

# Set up the environment
SHELL ["/bin/bash", "--login", "-c"]

SHELL ["conda", "run", "-n", "test", "/bin/bash", "-c"]
# Activate conda environment and install dependencies
RUN pip install torch==1.13.1+cu116 torchvision==0.14.1+cu116 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cu116
    
RUN conda install openblas-devel -c anaconda

# Set working directory
WORKDIR /home/daichi.azuma/workspace/

ENV CUDA_HOME /usr/local/cuda-11.6

# Set default command
CMD ["/bin/bash"] 
