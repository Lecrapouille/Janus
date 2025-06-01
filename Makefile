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
# Set third party glm
#
DEFINES += -DGLM_ENABLE_EXPERIMENTAL

###################################################
# Set third party Dimension3D
#
INCLUDES += $(THIRD_PARTIES_DIR)/Dimension3D/includes $(call rsubdirs,$(THIRD_PARTIES_DIR)/Dimension3D/includes)
DIMENSION3D_SUBDIRS := $(call rsubdirs,$(THIRD_PARTIES_DIR)/Dimension3D/sources)
VPATH += $(DIMENSION3D_SUBDIRS)
SRC_FILES += $(call rwildcard,$(DIMENSION3D_SUBDIRS),*.cpp) $(THIRD_PARTIES_DIR)/Dimension3D/sources/dimension3D.cpp
USER_CXXFLAGS += -Wno-useless-cast -Wno-conversion -Wno-sign-conversion -Wno-float-equal
USER_CXXFLAGS += -Wno-float-equal -Wno-float-conversion -Wno-shadow -Wno-unused-parameter
USER_CXXFLAGS += -Wno-unused-result -Wno-double-promotion -Wno-cast-qual
USER_CXXFLAGS += -Wno-unused-variable

###################################################
# Set third party Dear ImGui
#
IMGUI_DIR := $(THIRD_PARTIES_DIR)/imgui
INCLUDES += $(IMGUI_DIR) $(IMGUI_DIR)/misc/cpp $(IMGUI_DIR)/imgui-sfml
VPATH += $(IMGUI_DIR) $(IMGUI_DIR)/imgui-sfml $(IMGUI_DIR)/misc/cpp
SRC_FILES += $(IMGUI_DIR)/imgui_widgets.cpp $(IMGUI_DIR)/imgui_draw.cpp
SRC_FILES += $(IMGUI_DIR)/imgui_tables.cpp $(IMGUI_DIR)/imgui.cpp
SRC_FILES += $(IMGUI_DIR)/misc/cpp/imgui_stdlib.cpp

INCLUDES += $(THIRD_PARTIES_DIR)/imgui-sfml
SRC_FILES += $(THIRD_PARTIES_DIR)/imgui-sfml/imgui-SFML.cpp
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
$(error Unknown architecture $(OS) for OpenGL)
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
# Sharable information between all Makefiles
include $(M)/rules/Makefile

###################################################
# Post-download
#
download-external-libs::
	@cp $(THIRD_PARTIES_DIR)/imgui-sfml/imconfig-SFML.h $(THIRD_PARTIES_DIR)/imgui/imconfig.h