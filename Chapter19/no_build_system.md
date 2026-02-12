# No Build System Need (Probably) in Odin

At most you might need a single .bat script or .sh script for building

## Compiling your program

To compile a program navigate to the folder with the odin program and run

```bash
odin build .
```

This takes all the .odin files in the folder and compiles them as a single package

If you wish to skip some files then add this at the top of the file

```odin
#+build ignore
```

## Importing packages

when you type

```odin
import "core:fmt"
```

then you are importing all the files in <odin>/core/fmt. The Odin core is *not* pre-compiled. Therefore, when
importing libraries written in Odin, there are no dependencies on any pre-compiled binaries. So any package your program imports
also has all its files "picked up" by the compiler

## Importing non-Odin libraries

Your program may use libraries not written in Odin. Those libraries will need some kind of pre-compiled binary plus some Odin code
that describes how to interact with that binary. The Odin code that describes this interaction is called the bindings for the library

In the vendor collection you'll find bindings for many libraries written in other languages other than Odin. For example raylib

```odin
import rl "vendor:raylib"
```

Raylib is written in C and has pre-complied binaries but you do not need to manually link them

If you at vendor/raylib/raylib.din then you see this

```odin
when ODIN_OS == .Windows {
    @(extra_linker_flags="/NODEFAULTLIB:" + ("msvcrt" when RAYLIB_SHARED else "libcmt"))
    foreign import lib {
        "windows/raylibdll.lib" when RAYLIB_SHARED else "windows/raylib.lib" ,
        "system:Winmm.lib",
        "system:Gdi32.lib",
        "system:User32.lib",
        "system:Shell32.lib",
    }
} else when ODIN_OS == .Linux  {
    // etc etc
```

When raylib is imported, then the foreign import lib {} block tells the compiler which libraries to link for you. It's also possible to specify extra linker flags. The raylib bindings come with binaries for Windows, Linux, and macOS. You do not need to download and install any extra binaries for those platforms.

When raylib is imported, then the foreign import lib { line is jst a name, it is reused further down in raylib.odin 

```odin
@(default_calling_convention="c")
foreign lib {
    // Bindings to procs go here, such as:
    InitWindow :: proc(width, height: c.int, title: cstring) ---
}
```

The foreign import lib {} blocks tells the compiler which library files to link. The foreign lib {} block describes which procedures to make availabe from within the linked library. You list all the procedures and their signatures. Here "signature" refers to what parameters and return valuest he procedure has

Note the --- at the end of InitWindow, it is requried when you omit the body of the procedure. This means that we are leaving the procedure uninitialized, since it will get a value from library

The
```odin
@(default_calling_convention="c")
```

line is there because raylib is written in C, so the procedures in the must be called useing the C calling convention. Odin and C calls procedures in different ways. For example, remember that Odin passes along an implict context. C does not. The c calling convention is default for foreign lib blocks but included for clarity

## Caveats

non-Odin libraries tend to work well on Windows and macOS and most Linux systems. Some Linux systems do not and you might get linker errors due to things like mismatching glibc version. To fix replace the library file with one that works on your system.

Some libraries have configuration parameters. For example raylib does when compiling from source. If you need to change those then you have to rebuild raylib and change the bindings in raylib.odin. Recommend to make a copy of the library in your project folder if you have to change the library. Git source control that as well

## Platform specific code

If you want to make a file only compile on a specific platform, then there are two ways.

One add this to the top of the file
```odin
#+build linux, darwin, netbsd
```

for example will make the file only compile on those systems

Two, add a suffix to the filename such as logger_windows.odin. The that file will only compile on Windows

If you want it to not compile on two or more systems then do this at the top of the file

```odin
#+build !windows
#+build !linux
```

You can also use architecture names

```odin
#+build !amd64 windows
```

This skips compilation if you are on Windows but don't have an amd64 architecture

You may also want to create platform-specific abstractions. Perhaps you wnat a procedure called get_log_file_path() to be implemented differently on different platforms. In that case you can call get_log_file_path() in our platform-independent code and in the same package have log_windows.odin and log_linux.odin files and in those provide the get_log_file_path procedure for each platform

## Compiling multiple binaries

You might need to run the Odin compiler multiple times. For example you might need to first compile a DLL (shared library) and the nan executable. In that case you need to run two build commands.

```bash
odin build game-build-mode:dll
odin build main
```

Here we are (on Windows) compiling the game folder into a game.dll file, and the main folder into a main.exe file.

## More complicated build setups

Normally a script is best. You can use odin with cmake if need. python might be a good choice as well. Even an Odin script can be used if for example you need to download assets or dependencies from the internet first then build the odin project

## Summary

```bash
odin build .
```
* compiles all files in the current directory as a package. This can be thought of as your 'main program package'.
* As your program compiles, all Odin packages it imports also get compiled. Odin packages are usually not pre-compiled, so a package written purely in Odin has no binary dependencies.
* A package that contains bindings to a library written in another language needs to have some binary library files linked. The package that provides the bindings can specify which binary files to pass on to the linker as well as what procedures to expose from within that library.
* You can create platform specific files using #+build windows tags or a _windows.odin file suffix.
* If you need to compile several binaries as part of your build process, then just make a tiny batch / bash script that runs multiple odin build commands.
* For really complicated build set ups you could use something like CMake. But you're probably better off with a build script written in for example Python or Odin. The other points on this list simplifies the build process enough, making CMake "overkill" for the problem.
