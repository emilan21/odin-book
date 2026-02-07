package more_container_types_slice_example

import "core:fmt"

display_numbers :: proc(numbers: []int) {
	fmt.println(numbers)
}

main :: proc() {
	my_numbers: [128]int

	// Set the elements of my_numbers to
	// interesting values
	for i in 0 ..< len(my_numbers) {
		my_numbers[i] = i * i
	}

	// Slice my_numbers, 10 numbers per slice,
	// Send each slice into display_numbers for
	// printing on the screen.
	for i := 0; i < len(my_numbers); i += 10 {
		slice_end := min(i + 10, len(my_numbers))
		ten_numbers := my_numbers[i:slice_end]
		display_numbers(ten_numbers)
	}
}
