# Compilar e instalar las librerías de Foxglove websocket
export CPPSTD=17
export ASIO=standalone

conan create foxglove-websocket -s compiler.cppstd=$CPPSTD --build=missing -o foxglove-websocket*:asio=$ASIO

# Compilar el codigo desarrollado
conan build . -s compiler.cppstd=$CPPSTD --build=missing