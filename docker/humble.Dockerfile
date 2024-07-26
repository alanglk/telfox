# Imagen base
FROM ros:humble

# Argumentos
ARG UID
ARG GID

# Instalar dependencias python
RUN apt-get update -y && apt-get upgrade -y && apt-get autoremove -y && apt install -y apt-utils git pip python3-tk python3-rosdep unzip wget qtbase5-dev qt5-qmake cmake ros-humble-rqt-common-plugins ros-humble-ackermann-msgs
COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt && rm requirements.txt && pip install numexpr==2.8.4 bottleneck==1.3.6

# Crear el usuario nonroot con los mismos permisos que el host y perteneciente a sudoers
RUN apt update && \
    apt install -y sudo && \
    addgroup --gid $GID nonroot && \
    adduser --uid $UID --gid $GID --disabled-password --gecos "" nonroot && \
    echo 'nonroot ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Establecemos el nuevo usuario y el directorio de trabajo
USER nonroot
WORKDIR /home/nonroot/

# Sourceamos ROS
RUN echo "source /opt/ros/humble/setup.bash" >> .bashrc

CMD [ "/bin/bash" ]
