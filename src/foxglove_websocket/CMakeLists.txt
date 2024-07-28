cmake_minimum_required(VERSION 3.8)
project(foxglove_websocket)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()


# Find dependencies
find_package(ament_cmake REQUIRED)
find_package(nlohmann_json REQUIRED)
find_package(websocketpp REQUIRED)

# Creamos la librería
add_library(foxglove_websocket src/base64.cpp src/parameter.cpp src/serialization.cpp src/server_factory.cpp)
target_include_directories(foxglove_websocket PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include> $<INSTALL_INTERFACE:include>)
target_link_libraries(foxglove_websocket nlohmann_json::nlohmann_json websocketpp::websocketpp)
set_target_properties(foxglove_websocket PROPERTIES CXX_STANDARD 17 CXX_STANDARD_REQUIRED ON)

# this line to exports the library
ament_export_targets(foxglove_websocket HAS_LIBRARY_TARGET)

# install the include/my_cpp_library directory to the install/include/my_cpp_library
install(
  DIRECTORY include/foxglove
  DESTINATION include
)
 
install(
  TARGETS foxglove_websocket
  EXPORT foxglove_websocket
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
  INCLUDES DESTINATION include
)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # comment the line when a copyright and license is added to all source files
  set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # comment the line when this package is in a git repo and when
  # a copyright and license is added to all source files
  set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()


ament_package()

