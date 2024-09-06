FROM osrf/ros:humble-desktop

SHELL ["/bin/bash", "-c"]

# Setup system dependencies
RUN apt update -y && apt upgrade -y && apt-get install -y \
libx11-xcb1 \
libgl1-mesa-glx \
libxkbcommon-x11-0 \
python3-pip \
&& rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install rosbags

# Set up working directory and permissions
WORKDIR /home/dv_ws
RUN mkdir -p src && chmod -R 777 /home/dv_ws
RUN mkdir -p /home/rosbag2 && chmod -R 777 /home/rosbag2

# Source ROS2 environment
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

# Copy start script into container
COPY dv_ws/start.sh /home/dv_ws/start.sh
RUN chmod +x /home/dv_ws/start.sh

# Build workspace
RUN /bin/bash -c "source /opt/ros/humble/setup.bash"

# Set the entrypoint
ENTRYPOINT ["/home/dv_ws/start.sh"]

