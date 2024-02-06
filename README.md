# Janus

Project based on [Angel Uriot's Galaxy_simulation](https://github.com/angeluriot/Galaxy_simulation) in which
we add negative masses and apply either Newton (`m gamma = mM/d^2`) or anti-Newton law (`|m| gamma = mM/d^2`).

## Compilation Linux

```
sudo apt-get install pkg-config ocl-icd-opencl-dev opencl-clhpp-headers libsfml-dev libglm-dev libglew-dev libglfw3-dev libdw-dev
w

git clone https://github.com/Lecrapouille/Janus.git --recursive
cd Janus
make download-external-libs
make -j`nproc --all`

./build/Janus
```

Probable issue: depending on if you are on Ubuntu 20 or 22 or Debian 11 ... you may have to change the OpenCL header in [libraries.hpp](src/libraries.hpp).
Chooise between: `#include <CL/opencl.hpp>` and `#include <CL/cl2.hpp>`.

## Compilation Mac OS X

```
brew install pkg-config opencl-icd-loader opencl-headers opencl-clhpp-headers sfml glm glew glfw

export PKG_CONFIG_PATH="/usr/local/opt/opencl-icd-loader/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/opencl-headers/share/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/opencl-clhpp-headers/share/pkgconfig:$PKG_CONFIG_PATH"

git clone https://github.com/Lecrapouille/Janus.git --recursive
cd Janus
make download-external-libs
make -j`sysctl -n hw.logicalcpu`

./build/Janus
```