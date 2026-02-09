package easier_memory_management_allocation_tracker

import "core:fmt"
import "core:mem"

main :: proc() {
	// Tracking allocator setup. In use when you pass -debug when running or building the program
	// Should get used to setting this up for all projects as it will help find memory leaks, then
	// as the prod build will not use the -debug flag it will not run it the prod build
	when ODIN_DEBUG {
		track: mem.Tracking_Allocator
		mem.tracking_allocator_init(&track, context.allocator)
		context.allocator = mem.tracking_allocator(&track)

		defer {
			if len(track.allocation_map) > 0 {
				for _, entry in track.allocation_map {
					fmt.eprintf("%v leaked %v bytes\n", entry.location, entry.size)
				}
			}
			mem.tracking_allocator_destroy(&track)
		}
	}

	// rest of program
	ints := make([]int, 4096)

	//delete(ints)

	// Cleaner reports
	n1 := allocate_7()
	n2 := allocate_7()
	n3 := allocate_7()
	//free(n1)
	//free(n2)
	//free(n3)
}

// Example of cleaner reports
// In this example the tracker will only give the line numbers of the
// new(int), not the calling of the function so you don't know where
// allocate_7 was called.
/*
allocate_7 :: proc() -> ^int {
	number := new(int)
	number^ = 7
	return number
}
*/

// This one fixes that by passing the #caller_location as
// this will pass the source code location
// This is recommended whenever you have a procedure that returns dynamically allocated memory
// especially when the caller of the procedure is responsible for deallocating the memory

// Also would generally add an allocator paraementer as well
// Rule of thumb here is:
// One. If you make a procedure that dynamically allocates a return value, then add in an allocator
// parameter and use it when allocating the memory. This is a good hint to the user of the proc
// that its return value is dynamically allocated. It also makes it possible to change the
// allocator without modifying context.allocator
// Two. Whenever you do have an allocator parameter, then also add a loc := #caller_location parameter and pass that on when allocating memory
// The programmer that looks at memory leak reports is interested in where they call the producre that allocated the memory,
// not how the proc did the allocation
allocate_7 :: proc(allocator := context.allocator, loc := #caller_location) -> ^int {
	number := new(int, allocator = allocator, loc = loc)
	number^ = 7
	return number
}
