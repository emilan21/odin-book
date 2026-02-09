# Manual Memory Management Advice Guide

* Use the tracking allocator
* Use the temporary allocator for most intermediate data processing. Use it for creating string you need to display on the screen. Use it when you load a file, but only need part of it: Then load the file on the temporary allocator and just extract what you need from that data.
* Use arena allocators if you feel the need to group allocations that should be deallocated at the same time. But you don't have to use arena allocators. If you're not sure if you need one, then don't use one and instead just stick to the first to points of this list
* If you encounter crashes. Try running your program from within a debugger. If you crashes seem very random or you set lots of strange issues, then try running your program with the flags -debug -sanitize:address. This may help finding certian bugs. One use when investigating issues as this causes the program to run very slow.
