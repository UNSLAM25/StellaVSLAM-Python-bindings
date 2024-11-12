# StellaVSLAM-Python-bindings
**This repository is based on [Alejandro Silvestri](https://github.com/AlejandroSilvestri)'s previous work. All credits go to him.**

Python bindings for [StellaVSLAM](https://github.com/stella-cv/stella_vslam), an ORB based visual SLAM similar to ORB-SLAM2.

By compiling the provided cpp file, you get the module **stellavslam** that lets you control stellavslam' system from Python. **StellaVSLAM must be already installed in your system, along with its dependencies.** You'll be able to run stellavslam, load & save maps, feed images and get the pose matrix.

**Now with VIEWER BINDINGS!** This project includes bindings compatible with the Pangolin Viewer. This allows you to see the frames being fed into the SLAM system, visualize keypoints, and the map that's being generated.

As of today, no work has been done to use Socket Publisher. 

## Building the bindings
In order to get a **stellavslam** module you can import from Python, you need to:

* install [StellaVSLAM](https://stella-cv.readthedocs.io/en/latest/installation.html#chapter-installation)
* install [PyBind11](https://github.com/pybind/pybind11)
  * like ```pip install pybind11```
  * or ```sudo apt install pybind11-dev```
* compile _stellavslam-bindings.cpp_ 

A makefile is included to simplify the compilation process. You can (or should) modify it in the following cases:

* If you have OpenCV version 4 or greater installed, add the following include directory

        -I/usr/local/include/opencv4

```
g++ -O3 -Wall -shared -std=c++11 -fPIC $(python3-config --includes) -I/usr/local/include/stella_vslam/3rd/json/include -I/usr/local/include/eigen3 -I/usr/local/include/opencv4 ./stella_vslam_bindings.cpp -o stellavslam$(python3-config --extension-suffix) -lstellavslam
```

The result of the compilation process is a module in a form of a shared library, like:

    stellavslam.cpython-38-x86_64-linux-gnu.so

You can import this module in your Python code simply like:

    import stellavslam
    
provided the module file is reachable, for example being in the working directory.

## Posible errors during building

If there is an error related to eigen3, please execute the following command:

    sudo ln -s /usr/local/include/eigen3/Eigen /usr/include/Eigen

If there is an error related to numpy, try this:

    pip install numpy
    sudo apt-get install python3-numpy

If you have any other errors, please be sure to check that you have the StellaVSLAM dependencies installed correctly. For the time being, this project has been built and tested with:
* StellaVSLAM 0.5.0
* OpenCV 4.10.0
* Python 3.12
* Ubuntu 24.04 LTS
* (All the other dependencies of StellaVSLAM that appear on its installation page)

## Testing the module

In order to run stellavslam you always need a configuration file and a vocabulary file. You can get the vocabulary [orb_vocab.dbow2 file from stellavslam](https://github.com/StellaVSLAM-Community/DBoW2_orb_vocab).

Tests are available in Python, inside the 'tests' folder.

_test1.py_ is a minimal proof of operation, it starts and shuts down stellavslam.  A random _config.yaml_ file is provided in this project to facilitate this test.  Don't rest until you get this test running without errors.

_test2.py_ is a more complete demo, inspired in [run_video_slam](https://github.com/stella-cv/stella_vslam/blob/main/example/run_video_slam.cc) example.  You'll need a video with the right config.yaml.  You can download them from the [datasets stellavslam made public](https://stella-cv.readthedocs.io/en/latest/example.html#section-example-standard-datasets). Here are the direct links:

* [omnidirectional camera dataset (equirectanulgar)](https://drive.google.com/drive/folders/1A_gq8LYuENePhNHsuscLZQPhbJJwzAq4)
* [fisheye camera dataset](https://drive.google.com/drive/folders/1SVDsgz-ydm1pAbrdmhRQTmWhJnUl_xr8)

Each zip contains a video and the appropiate _config.yaml_.

_test3.py_ creates an instance of the Pangolin Viewer that runs along with the SLAM system. This allows you to view the keypoints detected on a frame and the map that's being generated.

You can execute the tests using the following command inside the tests folder:

    python3 test2.py -c ./aist_entrance_hall_1/config.yaml -m ./aist_entrance_hall_1/video.mp4 -v orb_vocab.fbow


## What is in the module
_stellavslam_ module contains four clases: _config_, _system_, _viewer_, and _YamlNode_. Config is used to pass config.yaml to _system_ initialization, and also to extract the viewer configuration. 

The _system_ object allows you to startup SLAM, feed it frames, etc. 

The _viewer_ is used to create instances of the Pangolin Viewer.

At the end of _stellavslam_binding.cpp_ you'll find the list of bound functions accessible from Python.  Tests serve as example of use.

## License
3-clause BSD license (see LICENSE)

This project uses code from the following third party libraries:

* NDArrayConverter from [edmBernard/pybind11_opencv_numpy](https://github.com/edmBernard/pybind11_opencv_numpy), Apache License 2.0
* NDArrayConverter uses code from [OpenCV 3.1.0](https://github.com/opencv/opencv/tree/3.1.0), 3-clause BSD license
* NDArrayConverter is based on the work of [yati-sagade/opencv-ndarray-conversion](https://github.com/yati-sagade/opencv-ndarray-conversion), MIT license

## Thanks
Many thanks to [Jack Cai](https://github.com/JackCai1206/stellavslam/blob/master/python/bindings.cc) whose non appropiable code inspired this project.

And again, thanks to [Alejandro Silvestri](https://github.com/AlejandroSilvestri) for making the original repository.

## Help needed
All help is welcome to facilitate installation with cmake.  From cmakelists.txt to the documentation with examples of use.
We can communicate through Dicussions.
