package easier_memory_management_debugging_memory

import "core:fmt"

main :: proc() {
	// Buggy program
	number: f32 = 7
	number64_ptr := cast(^f64)(&number)
	fmt.println(number64_ptr^)
}
