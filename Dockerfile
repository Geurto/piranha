ENV ROS_DISTRO humble
FROM ros:${ROS_DISTRO}

ENV WORKSPACE_DIR=/microros
ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir ${WORKSPACE_DIR} && cd ${WORKSPACE_DIR}

RUN git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup

RUN apt-get update && apt-get install \
    python3-pip

RUN apt-get update && rosdep update

RUN rosdep install \
    --from-paths src \
    --ignore-src y

RUN colcon build && source ${WORKSPACE_DIR}/install/setup.bash

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["sleep", "infinity"]