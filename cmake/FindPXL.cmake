# Try to find PXL. Once done, this will define
#     PXL_FOUND - system has PXL
#     PXL_INCLUDE_DIRS - the PXL include directories
#     PXL_LIBRARIES_DIR - link these to use PXL
#     PXL_PLUGIN_INSTALL_PATH - path to the default plugins
#        (e.g. $HOME/.pxl-3.0/plugins)
#
# Note that this only configures the pxl-core system to add a pxl
# plugin, use the PXL_ADD_PLUGIN(name), where name is e.g. pxl-astro
# Use pkg-config to get hints about paths

# define options
OPTION(INSTALL_PXL_USER "Install PXL modules in user plugin path" ON)

# find pxl via pkgconfig using pxl-core as its representation
FIND_PACKAGE(PkgConfig REQUIRED)
PKG_CHECK_MODULES(PXL pxl-core)

# PXL_INCLUDE_DIRS as already set by pkgconfig, so set PXL_LIBRARIES_DIR
set(PXL_LIBRARIES_DIR ${PXL_LIBRARY_DIRS})

# when PXL_PLUGIN_INSTALL_PATH is undefined, try to assign a good default
IF(NOT DEFINED PXL_PLUGIN_INSTALL_PATH)
    SET(PXLRUN_PATH "${PXL_LIBRARY_DIRS}/../bin/pxlrun")
    IF(INSTALL_PXL_USER)
        EXECUTE_PROCESS(COMMAND ${PXLRUN_PATH} --getUserPluginPath
                        OUTPUT_VARIABLE PXL_PLUGIN_INSTALL_PATH
                        OUTPUT_STRIP_TRAILING_WHITESPACE)
    ELSE(INSTALL_PXL_USER)
        EXECUTE_PROCESS(COMMAND ${PXLRUN_PATH} --getDefaultPluginPath
                        OUTPUT_VARIABLE PXL_PLUGIN_INSTALL_PATH
                        OUTPUT_STRIP_TRAILING_WHITESPACE)
    ENDIF(INSTALL_PXL_USER)
ENDIF(NOT DEFINED PXL_PLUGIN_INSTALL_PATH)
MESSAGE(STATUS "Install PXL modules to " ${PXL_PLUGIN_INSTALL_PATH})

# macro to add a pxl plugin
MACRO(ADD_PXL_PLUGIN name)
    MESSAGE(STATUS "Adding PXL plugin " ${name})
    FIND_LIBRARY(lib_${name}_library NAMES ${name} HINTS ${PXL_LIBRARIES_DIR})
    LIST(APPEND PXL_LIBRARIES ${lib_${name}_library}) 
ENDMACRO(ADD_PXL_PLUGIN name)

# macro to add a new module to cmake
MACRO(ADD_PXL_MODULE PXLMODULENAME CPPFILE)
    IF(APPLE)
        ADD_LIBRARY(${PXLMODULENAME} SHARED MODULE ${CPPFILE})
    ELSE(APPLE)
        ADD_LIBRARY(${PXLMODULENAME} SHARED ${CPPFILE})
    ENDIF(APPLE)

    TARGET_LINK_LIBRARIES(${PXLMODULENAME} ${PXL_LIBRARIES})

    SET_TARGET_PROPERTIES(${PXLMODULENAME} PROPERTIES COMPILE_FLAGS -fPIC)
    INSTALL(TARGETS ${PXLMODULENAME} LIBRARY DESTINATION ${PXL_PLUGIN_INSTALL_PATH})
ENDMACRO(ADD_PXL_MODULE name)

# add pxl core plugin by default
ADD_PXL_PLUGIN(pxl-core)

