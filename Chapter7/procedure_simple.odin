package procedure_simple

import "core:fmt"

is_bigger_than :: proc(number: int, compare_to: int) -> bool {
	return number > compare_to
}

main :: proc() {
	result := is_bigger_than(5, 2)
	fmt.println(result)
}
