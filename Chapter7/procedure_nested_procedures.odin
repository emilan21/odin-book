package procedure_nested_procedures

import "core:fmt"

// global var
global_state: int
// global constant
CONSTANT_NUMBER :: 7

do_stuff :: proc() {
	// local to do_stuff but not accessiable by print_message
	local_variable: int

	// You can nest procedures in other procedures. Keeps global scope cleaner
	// print_message() can use these things:
	// The parameter msg
	// The global variable global_state
	// The global constant CONSTANT_NUMBER
	print_message :: proc(msg: string) {
		fmt.println(msg)
		fmt.println(global_state)
		fmt.println(CONSTANT_NUMBER)
	}

	print_message("Hellope!")
}

main :: proc() {
	do_stuff()
}
