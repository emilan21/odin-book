package manual_memory_dynamic_array_dynamic_variables

import "core:fmt"

main :: proc() {

	// On the stack
	stack_number: f32

	// Dynamic
	number := new(f32)


	// Must free
	free(number)
}
