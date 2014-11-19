#String Theory

##Philosophy
Generative Design is a groundbreaking way of approaching computing technology and its applications. It has a myraid number of applications ranging from machine learning to data visualization to even simple creative code projects such as this one. This project in particular only scratches the surface of the potential of field, with a limitless well of potential avenues that it can be taken into.

##Overview
This simple Processing application represents an experimental Generative Design application that uses a particle simulation to draw ever changing and dynamic graphics onto the screen. The program defines 4 classes, Primordial, Attractors, Emitters, and Spawn.
* Primordial is the controller class and draws the window and manages the other three objects.
* Attractors defines an object that, as its name implies, exerts an attactive force on other objects.
* Emitters defines an object which continuously outputs streams of the next class, Spawn.
* Spawn are minute objects that are born out of the Emitters and feel attractive forces from the Attractors.

The system works in fidelity of the 2D gravitational paradigm, with one exception. Attractors and Spawn consist of matter, and so feel attractive forces between each other, however, the Emitters can be thought of as consisting of different *material* altogether and so are unaffected by the gravity. 

In addition, the attractors and emitters are moved around by the Perlin noise function. More on that [here](https://www.processing.org/reference/noise_.html).

The example images were recorded at 4K resolution and scaled down.
More detailed images and explanation can be found on my [website](http://www.theseventhline.net/2014/07/string-theory/).

##Requirement
Processing 2.0 or above.

##License
This project uses the [MIT License](https://github.com/Satre95/String-Theory/blob/master/LICENSE)
