package private_folder

import "core:fmt"

@(private = "file", require_results)
get_number :: proc() -> int {
	some_proc()
	return 5
}

print_number :: proc() {
	number := get_number()
	fmt.println(number)
}
