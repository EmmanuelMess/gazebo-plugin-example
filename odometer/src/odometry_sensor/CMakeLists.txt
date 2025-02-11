# WARNING The major version of this lib depends on gazebo version (see Dockerfile)
find_package(gz-sensors8 REQUIRED)
set(GZ_SENSORS_VER ${gz-sensors8_VERSION_MAJOR})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

# Static to prevent path issues when using the plugin
add_library(odometry_sensor STATIC Odometer.cc)

add_library(odometer::odometry_sensor ALIAS odometry_sensor)

target_link_libraries(
    odometry_sensor
    PRIVATE gz-sensors${GZ_SENSORS_VER}::gz-sensors${GZ_SENSORS_VER}
)

target_include_directories(odometry_sensor ${WARNING_GUARD} PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
                                                               $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>)

target_compile_features(odometry_sensor PUBLIC cxx_std_17)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(odometry_sensor PUBLIC SAMPLE_LIBRARY_STATIC_DEFINE)
endif()