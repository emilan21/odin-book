package extra_stuff

import "core:fmt"

// Built in support for matrices
// Built in support for quaternions
import "core:math/linalg"

// immutable array. Can index with variable
@(rodata)
numbers := [3]int{1, 2, 4}

// Struct tags
Cat :: struct {
	age: int "Cat's age",
}

// WASM support
import "vendor:wasm"

// Variadic procedures. Special syntax for making a procedure take an unspecified number of parameters

// defeered X attributes
// deferred_in, deferred_out, deferred_non and deferred_in_out are attributes you can give a procedure
// When a procdure has one of these attributes, then another procdure will automatically be called when the scope within
// which you called the orginal proc ends

// making libraries complie cleanly
// If you distributing a library as a package online then make sure it complies without problems for the people using it.
// Complie with -vet -strict-style
// Odin libraries are distrubuted as source code and complie as part of the program that imports it

// Code generation
// code generation can be seen as a form of "meta programming". That means that your generate some Odin code
// That you then complie as part of your program

main :: proc() {
	// loads files at compile time. Baked into the exe/bin
	// slice of bytes: []u8
	file_data := #load("my_file")

	// loads all files in the directory at complie time. Baked into the exe/bin
	// It is a array of Load_Directory_File
	/*	
	Load_Directory_file :: struct {
	    name: string,
	    data: []byte, // immutable data
	}
	*/
	directory := #load_directory(".")

	fmt.println(file_data)
	fmt.println(directory)

	i := 1
	fmt.println(numbers[i])
}
