# ros_docker
docker/makefile scripts for ROS


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
- Run `make build-bridge`, this will take some time
- To start the bridge, from the `ros_docker` folder, type make bridge
