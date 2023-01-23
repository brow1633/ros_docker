DOCKER_VOLUMES = \
	--volume="${HOME}/research_ws":"/ws":rw \
	--volume="${HOME}/catkin_ws":"/catkin_ws":rw

DOCKER_X11_LOCAL = \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--volume="/dev:/dev"

DOCKER_X11_REMOTE = \
	--volume="${HOME}/.Xauthority:/root/.Xauthority:rw"

DOCKER_ENV_VARS = \
	--env="DISPLAY" \

DOCKER_ENV_VARS_LOCAL = \
	--env="QT_X11_NO_MITSHM=1"

DOCKER_ARGS_LOCAL = ${DOCKER_VOLUMES} ${DOCKER_X11_LOCAL} ${DOCKER_ENV_VARS} ${DOCKER_ENV_VARS_LOCAL} --privileged --rm

DOCKER_ARGS_REMOTE = ${DOCKER_VOLUMES} ${DOCKER_X11_REMOTE} ${DOCKER_ENV_VARS} --rm

.PHONY: build-noetic
build-noetic:
	@docker build -f ${PWD}/ros-noetic -t ros-noetic .

.PHONY: build-humble
build-humble:
	@docker build -f ${PWD}/ros-humble -t ros-humble .

.PHONY: build
build: build-humble build-noetic

.PHONY: noetic
noetic:
	@docker run -it --net=host \
		${DOCKER_ARGS_LOCAL} ros-noetic bash

.PHONY: humble
humble:
	@docker run -it --net=host \
		${DOCKER_ARGS_LOCAL} ros-humble bash

.PHONY: noetic_remote
noetic_remote:
	@docker run -it --net=host \
		${DOCKER_ARGS_REMOTE} ros-noetic bash

.PHONY: humble_remote
humble_remote:
	@docker run -it --net=host \
		${DOCKER_ARGS_REMOTE} ros-humble bash
