# Order of parameters for .so compilation
# https://stackoverflow.com/questions/11643666/python-importerror-undefined-symbol-for-custom-c-module
CXX = /usr/bin/g++

# set non-optional compiler flags here
CXXFLAGS += -O3 -Wall -Wextra -shared -std=c++11 -fPIC

LIBS := -L/usr/local/lib -lstella_vslam -lpangolin_viewer -lpangolin $(shell pkg-config --libs opencv)
# set non-optional preprocessor flags here
# eg. project specific include directories
# -I/usr/local/include/opencv2 
CPPFLAGS += -I/usr/local/include/ $(shell pkg-config --cflags opencv) $(shell python3 -m pybind11 --includes) -I/usr/local/include/stella_vslam/3rd/json/include/
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

