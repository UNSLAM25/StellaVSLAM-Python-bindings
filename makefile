# Order of parameters for .so compilation
# https://stackoverflow.com/questions/11643666/python-importerror-undefined-symbol-for-custom-c-module
CXX = /usr/bin/g++

# set non-optional compiler flags here
CXXFLAGS += -O3 -Wall -Wextra -shared -std=c++17 -fPIC

LIBS := -L/usr/local/lib -lstella_vslam 
# Adjust as needed depending on your installed opencv version
# https://stackoverflow.com/questions/15320267/package-opencv-was-not-found-in-the-pkg-config-search-path
LIBS += $(shell pkg-config --libs opencv4)
# LIBS += $(shell pkg-config --libs opencv)
# Adjust as needed depending on which viewer you have installed
# LIBS += -lpangolin_viewer -lpangolin
LIBS += -liridescence -liridescence_viewer


# set non-optional preprocessor flags here
# eg. project specific include directories
# -I/usr/local/include/opencv2 
CPPFLAGS += -I/usr/local/include/
CPPFLAGS += $(shell python3 -m pybind11 --includes) $(shell python3-config --includes) $(shell python3 -c "import numpy; print ('-I' + numpy.get_include())")
CPPFLAGS += $(shell pkg-config --cflags opencv4)
# CPPFLAGS += $(shell pkg-config --cflags opencv)
CPPFLAGS += -I/usr/local/include/stella_vslam/3rd/json/include/
CPPFLAGS += -I/usr/local/include/stella_vslam/3rd/spdlog/include -I/usr/local/include/eigen3

# set sources
SOURCES := stellavslam_bindings.cpp

# set headers
# HEADERS := $(shell find ./src/ -name '*.h')

OUTPUT := stella_vslam$(shell python3-config --extension-suffix)

all: $(OUTPUT)

# $(OUTPUT): $(SOURCES) $(HEADERS)
$(OUTPUT): $(SOURCES)
	$(CXX) $(CXXFLAGS) -o $(OUTPUT) $(SOURCES) $(LIBS) $(CPPFLAGS) 

clean:
	$(RM) $(OUTPUT)

