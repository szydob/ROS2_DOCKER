#!/bin/bash

cd /home/dv_ws


source /opt/ros/humble/setup.bash
colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release
cd ..
source /home/dv_ws/install/setup.bash

# Play rosbag
ros2 bag play /home/rosbag2/bag1 -l &

source /home/dv_ws/install/setup.bash
# Launch the ROS2 node
ros2 launch patchworkpp patchworkpp.launch.py

