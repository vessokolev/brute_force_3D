## Brute Force point accommodation on 3D lattice

### Simple simulator that demonstrates how slow and uneffective the brute force technique could be.

#### Author: Veselin Kolev <vesso.kolev@gmail.com>
#### Released under GPLv2 licence.
#### Version: 2017110900

#### Content:

#### 1. Introduction.
#### 2. How to download the source code of the project.
#### 3. Compiling of the source code.
##### 3.1. Using Intel Fortran Compiler (ifort).
##### 3.2. Using PGI Fortran Compiler (pgfortran).
##### 3.3. Using GCC Fortran Compiler (gfortran).
#### 4. Running the compiled executable.
#### 5. Plotting the results.


_1. Introduction_

The goal of providing this simulator if to demonstrate how to generate close packing of particles in 3D by using brute force probing, supported by exclusion diameter to triger rejections when two points are too close. See the code in the file brute_force_3D to charge the value of the exclusion diameter, or any other one.

Refer to the discussion here:

https://www.youtube.com/watch?v=wJqbLQqh9Hw

for more inforation and details about the method implemented in the code.

_2. How to download the source code of the project._

The preferable method for obtaining the code is to use the tool ``git`` and clone the source tree locally to your file system:

```
git clone https://github.com/vessokolev/brute_force_3D.git
```

You may download the source as a ZIP-archive by pressing the button "Clone or download" in the web-interface on GitHub, or by using wget:

```
wget https://github.com/vessokolev/brute_force_3D/archive/master.zip
```

_3. Compiling of the source code._

You can compile the code by using your favorite compiler:

_3.1. Using Intel Fortran Compiler (ifort)._

```
$ make -f Makefile.intel
```

_3.2. Using PGI Fortran Compiler (pgfortran)._

```
$ make -f Makefile.pgi
```

_3.3. Using GCC Fortran Compiler (gfortran)._

```
$ make -f Makefile.gcc
```

_4. Running the compiled executable._

```
$ ./brute_force_3D
```

_5. Plotting the results._

Use gnuplot to plot the result:

```
gnuplot> splot 'points.txt' pt 8 ps 2
```
