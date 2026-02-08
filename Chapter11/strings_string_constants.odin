package strings_string_constants

import "core:fmt"

main :: proc() {
	A_CONSTANT :: "Hellope!"
	// + can't be used with variables. use fmt or the string builder instead
	my_string := A_CONSTANT + " How are you?"
	fmt.println(my_string)
}
