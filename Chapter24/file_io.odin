package file_io

import "core:os"

main :: proc() {
	// Read entire file
	if data, ok := os.read_entire_file("my_file"); ok {
		// The file was successfully read
		// data is of type []byte. It's a slice
		// containing the whole contents of the file
		// in the form of bytes.

		// Will normally use the context.allocator. Temp allocator is a good choice if you
		// are going to process the file and then only need to keep the processed data
	}

	// With temp allocator
	if data, ok := os.read_entire_file("my_file", context.temp_allocator); ok {
		// use data
		// if you need a string of the data just do string(data). Can also do
		// strings.clone_from_bytes(data) to get an allocated clone.
	}

	// Writing to a file
	// data needs to by of type []byte
	if os.write_entire_file("my_file", data) == false {
		// Something went wrong
		// print error
	}
}
