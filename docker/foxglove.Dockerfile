# Imagen base
FROM ubuntu:22.04

# Argumentos
ARG UID
ARG GID

# Instalar algunas herramientas
RUN apt-get update -y && apt-get upgrade -y && apt-get autoremove -y && apt install -y apt-utils git pip unzip wget qtbase5-dev qt5-qmake cmake libasound2

# Instalar Foxglobe Studio
RUN wget https://get.foxglove.dev/desktop/latest/foxglove-studio-2.9.0-linux-amd64.deb
RUN apt install -y ./foxglove-studio-*.deb
RUN rm foxglove-studio-2.9.0-linux-amd64.deb
RUN apt update && apt install -y foxglove-studio

# Crear el usuario nonroot con los mismos permisos que el host y perteneciente a sudoers
RUN apt update && \
    apt install -y sudo && \
    addgroup --gid $GID nonroot && \
    adduser --uid $UID --gid $GID --disabled-password --gecos "" nonroot && \
    echo 'nonroot ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Establecemos el nuevo usuario y el directorio de trabajo
USER nonroot
WORKDIR /home/nonroot/

# Entrypoint
CMD foxglove-studio --no-sandbox
