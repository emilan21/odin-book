package implicit_context_assertion

import "core:fmt"

main :: proc() {
	number := 5
	// The program will crash on purpose because the condition of the aseert was false
	assert(number == 7)
}
