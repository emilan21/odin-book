package manual_memory_dynamic_array_dynamic_struct

import "core:fmt"

Cat :: struct {
	age:  int,
	name: string,
}

make_cat :: proc(name: string, age: int) -> ^Cat {
	cat := new(Cat)
	cat^ = {
		name = name,
		age  = age,
	}

	return cat
}

cat_simulation :: proc() {
	cat := make_cat("Fluffy", 12)

	// Cat simulation code goes here

	free(cat)
}

Program_Memory :: struct {
	big_array_of_numbers: [10000000]int,
}

memory: ^Program_Memory

main :: proc() {

	memory = new(Program_Memory)
	cat_simulation()

	// Rest of program can use
	// global variable `memory`.


	// No need to free memory as it is a global and will
	// free on program close but you can if you want
	free(memory)
}
