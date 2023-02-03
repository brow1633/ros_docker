# ros_docker
Collection of Dockerfile's and a Makefile script to allow easy building and running.  Currently includes:
- ros-humble

  - ROS2 Humble with some standard additions
- ros-humble-bridge 
 
  - Includes a minimal ROS2, ROS1 install w/ ROS1 bridge and rosbridge_suite to communicate between remote ROS2 nodes and Unreal Engine via ROSIntegration Plugin
- ros-humble-jetson
  
  - Similar to ros-humble, less gazebo and with required nvidia CUDA packages
 
- ros-noetic

  - Noetic desktop install with some basic additions
  
The Makefile does the majority of the setup regarding mapping directories and setting up GUIs.  On linux, you'll have to run `xhost +` (unsafe) before using GUIs.  To build an image, run `make build-<name>` and to run the image, type `make <name>`.


# TO INSTALL #
- Open powershell (windows key, "powershell")
- Ensuring you are in `C\Users\<YourUsername>` type `notepad .wslconfig` and put the following inside:

```
swap=24GB
swapFile=%USERPROFILE%\AppData\Local\Temp\swap.vhdx
```
- Run `wsl --install`
- Install Docker Desktop
- Open WSL Ubuntu (windows key, "ubuntu")
- Clone this repository (`git clone https://github.com/brow1633/ros_docker.git`)
- Navigate into the directory (`cd ros_docker`)
- Run `make build-<name>`, this will take some time
- To start the container, from the `ros_docker` folder, type `make <name>`
