HUMBLE_VOLUME = "${HOME}/oscar_ros_ws"
NOETIC_VOLUME = "${HOME}/catkin_ws"

DOCKER_NOETIC_VOLUME = \
    --volume="${NOETIC_VOLUME}:/catkin_ws"

DOCKER_HUMBLE_VOLUME = \
	--volume="${HUMBLE_VOLUME}:/colcon_ws"

DOCKER_X11_LOCAL = \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--volume="/dev:/dev"

DOCKER_X11_REMOTE = \
	--volume="${HOME}/.Xauthority:/root/.Xauthority:rw"

DOCKER_ENV_VARS = \
	--env="DISPLAY" \

DOCKER_ENV_VARS_LOCAL = \
	--env="QT_X11_NO_MITSHM=1"

DOCKER_ARGS = ${DOCKER_ENV_VARS} -it --net=host --pid=host --privileged --rm

DOCKER_ARGS_LOCAL =  ${DOCKER_ARGS} ${DOCKER_X11_LOCAL} ${DOCKER_ENV_VARS_LOCAL}

DOCKER_ARGS_REMOTE = ${DOCKER_ARGS} ${DOCKER_X11_REMOTE}

.PHONY: build-noetic
build-noetic:
	@docker build -f ${PWD}/ros-noetic -t ros-noetic .

.PHONY: build-humble
build-humble:
	@docker build -f ${PWD}/ros-humble -t ros-humble .

.PHONY: build-bridge
build-bridge:
	@docker build -f ${PWD}/ros-humble-bridge -t ros-humble-bridge .

.PHONY: build-humble-jetson
build-humble-jetson:
	@docker build -f ${PWD}/ros-humble-jetson -t ros-humble .

.PHONY: build-zed-jetson
build-zed-jetson:
	@docker build -f ${PWD}/ros-zed-jetson -t ros-zed-jetson .

.PHONY: build-zed-jetson-final
build-zed-jetson-final:
	@docker build -f ${PWD}/ros-zed-jetson-final -t ros-zed-jetson-final .

.PHONY: build-zed-jetson-cross
build-zed-jetson-cross:
	@docker buildx build --platform linux/arm64 -f ${PWD}/ros-zed-jetson -t ros-zed-jetson .

.PHONY: build
build: build-humble build-noetic

.PHONY: noetic
noetic:
	@docker run ${DOCKER_ARGS_LOCAL} ${DOCKER_NOETIC_VOLUME} --privileged -v /dev/bus/usb:/dev/bus/usb ros-noetic bash

.PHONY: humble
humble:
	@docker run ${DOCKER_ARGS_LOCAL} ${DOCKER_HUMBLE_VOLUME} ros-humble bash

.PHONY: bridge
bridge:
	@docker run -it --rm -p 9090:9090 ros-humble-bridge

.PHONY: noetic_remote
noetic_remote:
	@docker run ${DOCKER_ARGS_REMOTE} ${DOCKER_NOETIC_VOLUME} ros-noetic bash

.PHONY: humble_remote
humble_remote:
	@docker run ${DOCKER_ARGS_REMOTE} ${DOCKER_HUMBLE_VOLUME} ros-humble bash

.PHONY: jetson
jetson:
	@docker run ${DOCKER_ARGS_REMOTE} ${DOCKER_HUMBLE_VOLUME} --runtime nvidia ros-humble bash

.PHONY: zed-jetson
zed-jetson:
	@docker run ${DOCKER_ARGS_REMOTE} ${DOCKER_HUMBLE_VOLUME} -v /dev/bus/usb:/dev/bus/usb --runtime nvidia ros-zed-jetson-final bash

.PHONY: perms
perms:
	@sudo chown -R ${USER} ${NOETIC_VOLUME}
	@sudo chown -R ${USER} ${HUMBLE_VOLUME}

.PHONY: ccs
ccs:
	@sed -i "s@/colcon_ws@${HUMBLE_VOLUME}@g" ../compile_commands.json
