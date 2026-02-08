package implicit_context

import "core:fmt"

main :: proc() {
}

do_work :: proc() {
	make_lots_of_ints :: proc() -> []int {
		ints := make([]int, 4096)

		// Give the numbers of `ints` some values
		for &v, idx in ints {
			v = idx * 4
		}

		return ints
	}
	// allows you to change allocators
	// Only use this in 2 cases
	// One. The proc doesn't allow you to pass an allocator
	// Two. When you really want all code within a scope to use that allocator. Common to do this in the first few lines of code in a proc
	context.allocator = context.temp_allocator
	// this call will now use the temp_alocator even though we normally can't change it
	my_ints := make_lots_of_ints()
}

// Recommend that you make the procedures that allocate memory have an explicit allocator parameter
// This allows the user of the procedure to know that you allocating memory
do_work_2 :: proc() {
	// Default parameter value of context.allocator
	make_lots_of_ints :: proc(allocator := context.allocator) -> []int {
		ints := make([]int, 4096)

		// Give the numbers of `ints` some values
		for &v, idx in ints {
			v = idx * 4
		}

		return ints
	}
	// passing temp_allocator to use instead of context.allocator
	my_ints := make_lots_of_ints(context.temp_allocator)
}
