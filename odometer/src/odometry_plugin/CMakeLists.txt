# WARNING The major version of this lib depends on gazebo version (see Dockerfile)
gz_find_package(gz-plugin2 REQUIRED COMPONENTS register)
set(GZ_PLUGIN_VER ${gz-plugin2_VERSION_MAJOR})

# WARNING The major version of this lib depends on gazebo version (see Dockerfile)
gz_find_package(gz-sim8 REQUIRED)
set(GZ_SIM_VER ${gz-sim8_VERSION_MAJOR})

# WARNING The major version of this lib depends on gazebo version (see Dockerfile)
find_package(gz-sensors8 REQUIRED)
set(GZ_SENSORS_VER ${gz-sensors8_VERSION_MAJOR})

add_library(odometry_plugin SHARED OdometerSystem.cc)
add_library(odometer::odometry_plugin ALIAS odometry_plugin)

target_link_libraries(
    odometry_plugin
    PRIVATE gz-plugin${GZ_PLUGIN_VER}::gz-plugin${GZ_PLUGIN_VER}
            gz-sim${GZ_SIM_VER}::gz-sim${GZ_SIM_VER}
            gz-sensors${GZ_SENSORS_VER}::gz-sensors${GZ_SENSORS_VER}
            odometer::odometry_sensor
)
target_include_directories(odometry_plugin ${WARNING_GUARD} PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
                                                               $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>)

target_compile_features(odometry_plugin PUBLIC cxx_std_17)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(odometry_plugin PUBLIC SAMPLE_LIBRARY_STATIC_DEFINE)
endif()

install(TARGETS odometry_plugin DESTINATION .)