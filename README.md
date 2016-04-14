# ttHReco
Common ttH Reconstruction package

## Installation

```bash
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/path/to/target/directory
make
make install
```


## Package Usage

##### 1. Environment setup:

```
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/path/to/ttHReco/lib/pkgconfig"
export CMAKE_MODULE_PATH="$CMAKE_MODULE_PATH;/path/to/ttHReco/share"
```


##### 2a. Using cmake:

```
FIND_PACKAGE(ttHReco)

# now you have the following variables to be used in e.g.
# INCLUDE_DIRECTORIES or TARGET_LINK_LIBRARIES:
#    ${ttHReco_INCLUDE_DIRS}
#    ${ttHReco_LIBRARY_DIRS}
#    ${ttHReco_LIBRARIES}
```

##### 2b. Manual compilation:

```
g++ -L /path/to/ttHReco/lib -l ttHReco-core -o myProg myFile.cc
```


## Code Usage

TODO
