###################################################
# Project definition
#
PROJECT = Janus
TARGET = $(PROJECT)
DESCRIPTION = Galaxy simulation
STANDARD = --std=c++14
BUILD_TYPE = release

###################################################
# Location of the project directory and Makefiles
#
P := .
M := $(P)/.makefile
include $(M)/Makefile.header

###################################################
# Inform Makefile where to find *.cpp files
#
VPATH += $(P)/src

###################################################
# Inform Makefile where to find header files
#
INCLUDES += -I$(P)/include -I$(P)/src -I$(P)/external

###################################################
# Project defines
#
DEFINES += -DDATADIR=\"$(DATADIR):$(abspath $(P))/data/:data/\"

###################################################
# Reduce warnings
#
CCFLAGS += -Wno-sign-conversion -Wno-float-equal
CXXFLAGS += -Wno-undef -Wno-switch-enum -Wno-enum-compare

###################################################
# Set thirdpart glm
#
DEFINES += -DGLM_ENABLE_EXPERIMENTAL

###################################################
# Set thirdpart Dimension3D
#
INCLUDES += -I$(THIRDPART)/Dimension3D/includes
INCLUDES += -I$(THIRDPART)/Dimension3D/includes/dim/cameras
INCLUDES += -I$(THIRDPART)/Dimension3D/includes/dim/controllers
INCLUDES += -I$(THIRDPART)/Dimension3D/includes/dim/lights
INCLUDES += -I$(THIRDPART)/Dimension3D/includes/dim/objects
INCLUDES += -I$(THIRDPART)/Dimension3D/includes/dim/opengl
INCLUDES += -I$(THIRDPART)/Dimension3D/includes/dim/utils
INCLUDES += -I$(THIRDPART)/Dimension3D/includes/dim/vectors
INCLUDES += -I$(THIRDPART)/Dimension3D/includes/dim/windows
VPATH += $(THIRDPART)/Dimension3D/sources/cameras
VPATH += $(THIRDPART)/Dimension3D/sources/controllers
VPATH += $(THIRDPART)/Dimension3D/sources/lights
VPATH += $(THIRDPART)/Dimension3D/sources/objects
VPATH += $(THIRDPART)/Dimension3D/sources/opengl
VPATH += $(THIRDPART)/Dimension3D/sources/utils
VPATH += $(THIRDPART)/Dimension3D/sources/vectors
VPATH += $(THIRDPART)/Dimension3D/sources/windows
VPATH += $(THIRDPART)/Dimension3D/sources/
OBJS += Camera2D.o AmbientLight.o Shader.o Vector3int.o
OBJS += Camera.o DirectionalLight.o Texture.o Vector4.o
OBJS += OrthographicCamera.o Light.o VertexBuffer.o Vector4int.o
OBJS += PerspectiveCamera.o PointLight.o Color.o vectors.o
OBJS += Controller.o Material.o utils.o Scene.o
OBJS += DragController.o Mesh.o Vector2.o Window.o
OBJS += FlyController.o Object.o Vector2int.o OrbitController.o
OBJS += FrameBuffer.o Vector3.o dimension3D.o

###################################################
# Set thirdpart Dear ImGui
#
INCLUDES += -I$(THIRDPART)/imgui -I$(THIRDPART)/imgui/misc/cpp -I$(THIRDPART)/imgui-sfml
VPATH += $(THIRDPART)/imgui $(THIRDPART)/imgui-sfml $(THIRDPART)/imgui/misc/cpp
OBJS += imgui_widgets.o imgui_draw.o imgui_tables.o imgui.o imgui_stdlib.o imgui-SFML.o

###################################################
# OpenGL: glfw and glew libraries
#
ifeq ($(ARCHI),Darwin)
INCLUDES += -I/usr/local/include -I/opt/local/include
LINKER_FLAGS += -framework OpenGL -framework Cocoa
LINKER_FLAGS += -framework IOKit -framework CoreVideo
LINKER_FLAGS += -L/usr/local/lib -L/opt/local/lib
LINKER_FLAGS += -lGLEW -lglfw
else ifeq ($(ARCHI),Linux)
LINKER_FLAGS += -lGLEW -lGL
PKG_LIBS += --static glfw3
else ifneq ($(ARCHI),Emscripten)
$(error Unknown architecture $(ARCHI) for OpenGL)
endif

###################################################
# Linkage
#
PKG_LIBS += sfml-graphics glm OpenCL
LINKER_FLAGS += -ldl -lpthread

###################################################
# Make the list of compiled files for the application
#
OBJS += Menu.o Computer.o Renderer.o Simulator.o ComputeShader.o main.o

###################################################
# Sharable informations between all Makefiles
include $(M)/Makefile.footer
