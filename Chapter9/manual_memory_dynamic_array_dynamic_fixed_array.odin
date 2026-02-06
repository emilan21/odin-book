package manual_memory_dynamic_array_dynamic_fixed_array

import "core:fmt"

main :: proc() {

	// On stack
	ints_stack: [128]int

	// dynamic fixed array
	// probably use a slice instead
	ints := new([128]int)

	// this changes item 10 of both ints and ints_2 as assigning
	// ints_2 to ints is just a pointer so they point to the same
	// memory
	ints[10] = 5
	ints_2 := ints
	ints_2[10] = 7
	fmt.println(ints[10]) //7
	fmt.println(ints_2[10]) //7

	// free ints
	free(ints)
}
