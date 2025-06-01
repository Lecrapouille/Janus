# Janus

Project-based on [Angel Uriot's Galaxy_simulation](https://github.com/angeluriot/Galaxy_simulation) in which
we add negative masses and apply either Newton (`m gamma = mM/d^2`) or anti-Newton law (`|m| gamma = mM/d^2`).
More information on this model: https://www.januscosmologicalmodel.fr/post/janus

## Compilation Linux

```bash
sudo apt-get install pkg-config ocl-icd-opencl-dev opencl-clhpp-headers libsfml-dev libglm-dev libglew-dev libglfw3-dev libdw-dev

git clone https://github.com/Lecrapouille/Janus.git --recursive
cd Janus
make download-external-libs
make -j`nproc --all`

./build/Janus
```

Note: You need SFML v2.6 (not the v 3.0).

## Possible issue

- Depending on whether you are using Ubuntu 20, Ubuntu 22, or Debian 11, you may need to modify the OpenCL header in [libraries.hpp](src/libraries.hpp).
Choose between `#include <CL/opencl.hpp>` and `#include <CL/cl2.hpp>`.
- Not working for MacOS because OpenCL cannot be used because Apple no longer supports OpenGL 4.x used by OpenCL.

## Some screenshots

Made with a saggy GT710.

Two colors: red for positive masses, green for negative masses.

![unnamed](https://github.com/user-attachments/assets/9af1cc4d-b39b-454e-96a1-71352aa53c0d)

![collision_newton_30p](https://github.com/user-attachments/assets/c4f4b58a-55ba-48a6-9a9e-0a6e6693e870)

![unnamed2](https://github.com/user-attachments/assets/1380e9d7-c0b4-480a-9399-89a4e3e06d56)
