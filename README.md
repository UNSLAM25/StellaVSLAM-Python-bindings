# StellaVSLAM-Python-bindings
**This repository is based on [Alejandro Silvestri](https://github.com/AlejandroSilvestri)'s previous work. All credits go to him.**

Python bindings for [StellaVSLAM](https://github.com/stella-cv/stella_vslam), an ORB based visual SLAM similar to ORB-SLAM2.

By compiling the provided cpp file, you get the module **stellavslam** that lets you control stellavslam' system from Python. **StellaVSLAM must be already installed in your system, along with its dependencies.** You'll be able to run stellavslam, load & save maps, feed images and get the pose matrix.

Right now no bindings for viewers are provided, so do not expect to see the 3D map nor the features over the image.

## Building the bindings
In order to get a **stellavslam** module you can import from Python, you need to:

* install [StellaVSLAM](https://stella-cv.readthedocs.io/en/latest/installation.html#chapter-installation)
* install [PyBind11](https://github.com/pybind/pybind11)
  * like ```pip install pybind11```
* compile _stellavslam-bindings.cpp_ 

This is an example of command line compilation in Linux:

    /usr/bin/g++ -O3 -Wall -shared -std=c++11 -fPIC $(python3 -m pybind11 --includes) -I/usr/local/include/stellavslam/3rd/json/include -DUSE_DBOW2 ./stellavslam_bindings.cpp -o stellavslam$(python3-config --extension-suffix) -lstellavslam

In this command line you can remove -DUSE_DBOW2 if you don't want to use DBoW2, and use fbow instead:

    /usr/bin/g++ -O3 -Wall -shared -std=c++11 -fPIC $(python3 -m pybind11 --includes) -I/usr/local/include/stella_vslam/3rd/json/include/./stellavslam_bindings.cpp -o stella_vslam$(python3-config --extension-suffix) -lstella_vslam 

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
    sudo apt-get install python-numpy

## Testing the module

In order to run stellavslam you always need a configuration file and a vocabulary file.  You can get the vocabulary [orb_vocab.dbow2 file from stellavslam](https://github.com/StellaVSLAM-Community/DBoW2_orb_vocab).

Two tests are available in Python, inside the 'tests' folder.

_test1.py_ is a minimal proof of operation, it starts and shuts down stellavslam.  A random _config.yaml_ file is provided in this project to facilitate this test.  Don't rest until you get this test running without errors.

_test2.py_ is a more complete demo, inspired in [run_video_slam](https://github.com/stella-cv/stella_vslam/blob/main/example/run_video_slam.cc) example.  You'll need a video with the right config.yaml.  You can download them from the [datasets stellavslam made public](https://stella-cv.readthedocs.io/en/latest/example.html#section-example-standard-datasets). Here are the direct links:

* [omnidirectional camera dataset (equirectanulgar)](https://drive.google.com/drive/folders/1A_gq8LYuENePhNHsuscLZQPhbJJwzAq4)
* [fisheye camera dataset](https://drive.google.com/drive/folders/1SVDsgz-ydm1pAbrdmhRQTmWhJnUl_xr8)

Each zip contains a video and the appropiate _config.yaml_.

You can execute the tests using the following command inside the tests folder:

    python3 test2.py -c ./aist_entrance_hall_1/config.yaml -m ./aist_entrance_hall_1/video.mp4 -v orb_vocab.fbow


## What is in the module
_stellavslam_ module contains two clases: _config_ and _system_.  The former is only used to pass config.yaml to _system_ initialization.  You do all the work with a _system_ object.

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
