# Janus

Project-based on [Angel Uriot's Galaxy_simulation](https://github.com/angeluriot/Galaxy_simulation) in which
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

Probable issue: Depending on whether you are on Ubuntu 20 or 22 or Debian 11, you may have to change the OpenCL header in [libraries.hpp](src/libraries.hpp).
Choose between `#include <CL/opencl.hpp>` and `#include <CL/cl2.hpp>`.

## Some screenshots

Made with a sagy GT710

![unnamed](https://github.com/user-attachments/assets/9af1cc4d-b39b-454e-96a1-71352aa53c0d)

![colision_newton_30p](https://github.com/user-attachments/assets/c4f4b58a-55ba-48a6-9a9e-0a6e6693e870)

![unnamed2](https://github.com/user-attachments/assets/1380e9d7-c0b4-480a-9399-89a4e3e06d56)
