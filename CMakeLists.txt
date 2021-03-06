# CMakeLists.txt

#
# project setup
#

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
PROJECT(ttHReco)
LIST(APPEND CMAKE_MODULE_PATH $ENV{CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)


#
# versioning
#

SET(ttHReco_MAJOR_VERSION 0)
SET(ttHReco_MINOR_VERSION 0)
SET(ttHReco_BUGFIX_VERSION 1)

SET(ttHReco_VERSION ${ttHReco_MAJOR_VERSION}.${ttHReco_MINOR_VERSION}.${ttHReco_BUGFIX_VERSION})

MESSAGE(STATUS "ttHReco version ${ttHReco_VERSION}")


#
# installation directories
#

SET(ttHReco_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
SET(ttHReco_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include)
SET(ttHReco_PCDIR ${CMAKE_INSTALL_PREFIX}/lib/pkgconfig)
SET(ttHReco_SHAREDIR ${CMAKE_INSTALL_PREFIX}/share)


#
# find and setup packages
#

# create lists
LIST(APPEND VAR_INCLUDE_DIRECTORIES "")
LIST(APPEND VAR_LINK_LIBRARIES "")

# ROOT
FIND_PACKAGE(ROOT)
LIST(APPEND VAR_INCLUDE_DIRECTORIES ${ROOT_INCLUDE_DIR})
LIST(APPEND VAR_LINK_LIBRARIES ${ROOT_LIBRARIES})

# PXL
# FIND_PACKAGE(PXL)
# ADD_PXL_PLUGIN(pxl-core)
# ADD_PXL_PLUGIN(pxl-modules)
# ADD_PXL_PLUGIN(pxl-hep)
# LIST(APPEND VAR_INCLUDE_DIRECTORIES ${PXL_INCLUDE_DIRS})
# LIST(APPEND VAR_LINK_LIBRARIES ${PXL_LIBRARIES} ${PXL_LDFLAGS})


INCLUDE_DIRECTORIES(${VAR_INCLUDE_DIRECTORIES})


#
# define macros
#

MACRO(ttHReco_INSTALL_LIBRARY name)
    INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/include)
    TARGET_LINK_LIBRARIES(${name} ${VAR_LINK_LIBRARIES})
    SET_TARGET_PROPERTIES(${name} PROPERTIES COMPILE_FLAGS -fPIC)

    INSTALL(TARGETS ${name} LIBRARY DESTINATION ${ttHReco_LIBDIR})
    INSTALL(DIRECTORY include/ttHReco DESTINATION ${ttHReco_INCLUDEDIR} FILES_MATCHING PATTERN "*.h" PATTERN ".*" EXCLUDE)
ENDMACRO(ttHReco_INSTALL_LIBRARY name)


#
# add subdirectories
#

ADD_SUBDIRECTORY(core)


#
# install additional files
#

install(FILES pkgconfig/ttHReco.pc DESTINATION ${ttHReco_PCDIR})
install(FILES share/FindttHReco.cmake DESTINATION ${ttHReco_SHAREDIR})
