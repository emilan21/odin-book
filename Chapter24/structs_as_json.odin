package structs_as_json

import "core:encoding/json"
import "core:fmt"
import vmem "core:mem/virtual"
import "core:os"

Some_Struct :: struct {
	some_field: int,
}

main :: proc() {
	// odin comes with a json library that can convert structs into JSON (marshal) and then also covert
	// that JSON back into structs (unmarshal)
	my_struct := Some_Struct {
		some_field = 7,
	}

	// json.marshal() will covert my_struct into JSON. Note the second return value of json.marshal()
	// is a union. This union is nil if there was no error.
	if json_data, err := json.marshal(my_struct, allocator = context.temp_allocator); err == nil {
		// json_data is of type []byte
		// so can write it directly to a file
		if !os.write_entire_file("my_struct_file", json_data) {
			fmt.eprintln("Couldn't write file!")
		}
	} else {
		fmt.eprintln("Couldn't marshal struct")
	}

	// Read back a json file and unmarshal

	// Note the json.unmarshal() may allocate memory if your struct contains slices, dynamic arrays or strings. It is up to you to free this
	// memory. One way to group all the memory allocations done during the unmarshal is by passing an arena alocator
	if json_data, ok := os.read_entire_file("my_struct_file", context.temp_allocator); ok {
		my_struct: Some_Struct

		arena: vmem.Arena
		arena_allocator := vmem.arena_allocator(&arena)


		// Any allocations that are needed during the unmarshal are done into the arena
		if json.unmarshal(json_data, &my_struct, allocator = arena_allocator) == nil {
			// my_struct now contains the data from the file
			fmt.printfln("My struct: %v", my_struct)
			fmt.printfln("Arena: %v", arena)
			vmem.arena_destroy(&arena)
		} else {
			fmt.eprintln("Failed to unmarshal JSON")
			vmem.arena_destroy(&arena)
		}
	} else {
		fmt.eprintln("Failed to read file")
	}
}
