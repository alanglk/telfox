# Imagen base
FROM fsbdriverless/roshumble:latest

# Instalar dependencias c++
RUN sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get autoremove -y && sudo apt install -y cmake make clang clang-format
RUN git clone https://github.com/zaphoyd/websocketpp.git && cd websocketpp && cmake . && make && sudo make install && cd .. && rm -rf websocketpp
RUN git clone https://github.com/nlohmann/json.git && cd json && camke . && make && sudo make install && cd .. && rm -rf json

# Entrypoint
CMD [ "/bin/bash" ]
