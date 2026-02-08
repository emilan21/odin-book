package strings_deallocating_strings_mixed

import "core:fmt"
import vmem "core:mem/virtual"
import "core:strings"

main :: proc() {
	/*
	strs := make_some_strings()

	// Inset code here that uses `strs`

	for s in strs {
		delete(s)
	}

	delete(strs)

	fmt.println("Will crash because of delete(s)")
	*/

	// Two ways to fix this issue
	// One make all strings in the array dynamic
	strs := make_some_strings_dynamic()

	// Insert code here that uses `strs`

	for s in strs {
		delete(s)
	}

	delete(strs)

	fmt.println("Got here!")

	// Second method, memory arenas
	strs_2, strs_2_arena := make_some_strings_arena()

	// Insert code here that uses `strs_2`

	vmem.arena_destroy(&strs_2_arena)
	delete(strs_2)

	fmt.println("Got here!")

	// Option 1 is easier but uses more memory than option 2
}

// Wrong
// Program will crash if you try to delete the strings
make_some_strings :: proc() -> [dynamic]string {
	strs: [dynamic]string
	append(&strs, "Hellope!")
	append(&strs, "Hi!")
	append(&strs, strings.clone("Dynamically allocated!"))
	append(&strs, "Constant!")
	append(&strs, strings.clone("Dynamic!"))
	return strs
}

// Make all strings dynamic, doesn't crash on delete
make_some_strings_dynamic :: proc() -> [dynamic]string {
	strs: [dynamic]string

	strs_add :: proc(strs: ^[dynamic]string, s: string) {
		append(strs, strings.clone(s))
	}

	strs_add(&strs, "Hellope!")
	strs_add(&strs, "Hi!")
	strs_add(&strs, strings.clone("Dynamically allocated!"))
	strs_add(&strs, "Constant!")
	strs_add(&strs, strings.clone("Dynamic!"))
	return strs
}

// Use memory arenas
make_some_strings_arena :: proc() -> ([dynamic]string, vmem.Arena) {
	arena: vmem.Arena
	strs: [dynamic]string
	arena_allocator := vmem.arena_allocator(&arena)
	append(&strs, "Hellope!")
	append(&strs, "Hi!")
	append(&strs, strings.clone("Dynamically allocated!", arena_allocator))
	append(&strs, "Constant!")
	append(&strs, strings.clone("Dynamic!", arena_allocator))
	return strs, arena
}
