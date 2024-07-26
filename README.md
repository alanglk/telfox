# TelFox
Foxglove es una herramienta que permite trabajar y depurar datos recogidos por robots. Se puede entender como un _rviz_ pero con vitaminas. En el contexto de los sistemas autónomos para vehículos Formula Student, Foxglove se presenta como una buena opción para realizar tareas de debug de logs ya tomados o visualizar en tiempo real los datos que se están recogiendo en el vehículo.

En este repositorio se pretende explorar las ventajas de esta herramienta y diseñar un sistema de telemetría y procesado de logs.


## Live Data
Existen 3 formas principales de conectar un _stream_ de datos a Foxglove:

- __WebSockets__: Socket UDP directo de comunicación
- __ROSbridge__: Un wrapper de todo ROS
- __Ficheros Remotos__: Hay que habilitar [CORS](https://docs.foxglove.dev/docs/connecting-to-data/live-data#cross-origin-resource-sharing-cors-setup) pero es una opción para acceder a logs ya grabados en un dispositivo remoto

Para diseñar un sistema de telemetría en tiempo real, la tercera opción queda descartada. De las dos opciones restantes, la seleccionada son los __WebSockets__ debido a que realizar un __ROSbridge__ supone mucha carga computacional tanto para la máquina servidora como el dispositivo de visualización. Además, los __WebSockets__ son la opción recomendada por Foxglove y es más flexible. 



## Visualización de Logs

> [!WARNING]
> Foxglove solo puede trabajar con formatos MCAP para los ros2 bags, por lo que hay que realizar la conversión de SQLite a MCAP. Más detalles en el siguiente [link](https://mcap.dev/guides/getting-started/ros-2)

```bash
sudo apt-get install ros-$ROS_DISTRO-rosbag2-storage-mcap # Instalar el plugin de MCAP para ROS

cat << EOF > convert.yaml
output_bags:
  - uri: ros2_output
    storage_id: mcap
    all: true
EOF
ros2 bag convert -i ros2_input.db3 -o convert.yaml # Convertir a MCAP
```

```bash
ros2 bag record -s mcap --all # -s establece el formato de record en MCAP
```

