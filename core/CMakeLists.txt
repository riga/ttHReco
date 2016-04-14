# core/CMakeLists.txt

#
# add shared libraries using sources
#

ADD_LIBRARY(ttHReco-core SHARED
    src/test.cc
    # ...
)


#
# install
#

ttHReco_INSTALL_LIBRARY(ttHReco-core)
