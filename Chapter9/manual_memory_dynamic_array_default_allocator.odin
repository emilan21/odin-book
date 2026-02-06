package manual_memory_dynamic_array_default_allocator

import "core:fmt"
import "core:math/rand"
import "core:slice"

main :: proc() {

	// Don't do this as it can cause bad behavior
	dyn_arr: [dynamic]int
	append(&dyn_arr, 5)
	dyn_arr_2 := dyn_arr

	for i in 0 ..< 1024 {
		append(&dyn_arr, 5)
	}

	// This is bad because dyn_arr has changed and the values such as the
	// cap, len, and pointer have changed so dyn_arr_2 now points to the incorrect stuff

	// Do this if you want to copy a dynamic array
	dyn_arr_correct := slice.clone_to_dynamic(dyn_arr[:])

	great_algorithm()

	free_all(context.temp_allocator)
}

great_algorithm :: proc() {
	numbers := make([dynamic]int, context.temp_allocator)

	for i in 0 ..< 100 {
		append(&numbers, rand.int_max(1000))
	}

	for n in numbers {
		if n > 500 {
			fmt.println(n)
		}
	}
}
