#!/bin/bash

rosmaster --core &

source /rosbridge_suite/devel/setup.bash

roslaunch rosbridge_server rosbridge_tcp.launch bson_only_mode:=True &

source /ros2_humble/install/setup.bash
source /ros1_bridge/install/setup.bash

ros2 run ros1_bridge dynamic_bridge