package more_container_types_slice_own_memory

import "core:fmt"
import "core:slice"

main :: proc() {
	my_numbers: [128]int
	first_20 := my_numbers[:20]
	// This will make a clone of the slice with its own memory. Useful if you have
	// temporary memory, but you wish to permanently clone it or a section of it
	first_20_clone := slice.clone(first_20)

	delete(first_20_clone)

	// From sratch slice with its own memory
	ints := make([]int, 128)

	delete(ints)

	// Slices with their own memory can be seen as a way to dynamicallly allocate an array with a fixed size
	// Fixed array
	// On stack
	my_numbers_stack: [128]int
	// slice
	// dynamic memory allocation
	my_numbers_slice := make([]int, 128)
	delete(my_numbers_slice)

	// Use dynamic if you need a dynamically allocated array that doesn't need to grow

	// slice proc on fixed array
	my_numbers_fixed := [3]int{1, 2, 3}
	print_numbers(my_numbers_fixed[:])

	// or
	my_numbers_fixed_2 := []int{1, 2, 3}
	print_numbers(my_numbers_fixed)

	// can do this even
	print_numbers({1, 2, 3})

}

// Sometimes you want to run a procedure that needs a slice, but you only have a fixed array
// You can slice the fixed array
print_numbers :: proc(numbers: []int) {
	for n in numbers {
		fmt.println(n)
	}
}
