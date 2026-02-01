package pointers

import "core:fmt"

main :: proc() {
	number := 7
	number_pointer := &number
	increment_number(number_pointer)
	fmt.println(number) // 8
}

increment_number :: proc(num: ^int) {
	num^ += 1
}
