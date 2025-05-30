###################################################
# Project definition
#
PROJECT_NAME := Janus
PROJECT_VERSION := 0.1.0
TARGET_NAME := $(PROJECT_NAME)
TARGET_DESCRIPTION := Galaxy simulation
CXX_STANDARD := --std=c++17
COMPILATION_MODE := debug

###################################################
# Function to list subdirectories
#
define rsubdirs
$(shell find $(1) -type d ! -path $(1) 2>/dev/null | sort)
endef

###################################################
# Location of the project directory and Makefiles
#
P := .
M := $(P)/.makefile
include $(M)/project/Makefile

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
USER_CCFLAGS += -Wno-sign-conversion -Wno-float-equal
USER_CXXFLAGS += -Wno-undef -Wno-switch-enum -Wno-enum-compare

###################################################
# Set thirdpart glm
#
DEFINES += -DGLM_ENABLE_EXPERIMENTAL

###################################################
# Set thirdpart Dimension3D
#
INCLUDES += $(THIRDPART)/Dimension3D/includes $(call rsubdirs,$(THIRDPART)/Dimension3D/includes)
DIMENSION3D_SUBDIRS := $(call rsubdirs,$(THIRDPART)/Dimension3D/sources)
VPATH += $(DIMENSION3D_SUBDIRS)
SRC_FILES += $(call rwildcard,$(DIMENSION3D_SUBDIRS),*.cpp)
USER_CXXFLAGS += -Wno-useless-cast -Wno-conversion -Wno-sign-conversion -Wno-float-equal
USER_CXXFLAGS += -Wno-float-equal -Wno-float-conversion -Wno-shadow -Wno-unused-parameter
USER_CXXFLAGS += -Wno-unused-result -Wno-double-promotion -Wno-cast-qual
USER_CXXFLAGS += -Wno-unused-variable

###################################################
# Set thirdpart Dear ImGui
#
INCLUDES += $(THIRDPART)/imgui $(THIRDPART)/imgui/misc/cpp $(THIRDPART)/imgui-sfml
VPATH += $(THIRDPART)/imgui $(THIRDPART)/imgui-sfml $(THIRDPART)/imgui/misc/cpp
SRC_FILES += $(THIRDPART)/imgui/imgui_widgets.cpp $(THIRDPART)/imgui/imgui_draw.cpp
SRC_FILES += $(THIRDPART)/imgui/imgui_tables.cpp $(THIRDPART)/imgui/imgui.cpp
SRC_FILES += $(THIRDPART)/imgui/misc/cpp/imgui_stdlib.cpp $(THIRDPART)/imgui-sfml/imgui-SFML.cpp
USER_CXXFLAGS += -Wno-old-style-cast

###################################################
# OpenGL: glfw and glew libraries
#
ifeq ($(OS),Darwin)
INCLUDES += -I/usr/local/include -I/opt/local/include
LINKER_FLAGS += -framework OpenGL -framework Cocoa
LINKER_FLAGS += -framework IOKit -framework CoreVideo
LINKER_FLAGS += -L/usr/local/lib -L/opt/local/lib
LINKER_FLAGS += -lGLEW -lglfw
else ifeq ($(OS),Linux)
LINKER_FLAGS += -lGLEW -lGL
PKG_LIBS += --static glfw3
else ifneq ($(OS),Emscripten)
$(error Unknown architecture $(ARCHI) for OpenGL)
endif

###################################################
# Linkage
#
PKG_LIBS += sfml-graphics sfml-window sfml-system glm
LINKER_FLAGS += -ldl -lpthread

ifeq ($(OS),Darwin)
PKG_LIBS += OpenCL OpenCL-CLHPP
else
PKG_LIBS += OpenCL
endif

###################################################
# Make the list of compiled files for the application
#
SRC_FILES += $(call rwildcard,$(P)/src,*.cpp)

###################################################
# Sharable informations between all Makefiles
include $(M)/rules/Makefile