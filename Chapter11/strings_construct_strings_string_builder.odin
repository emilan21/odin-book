package strings_construct_strings_string_builder

import "core:fmt"
import "core:strings"

main :: proc() {
	// Using string builder
	lines := []string{"I like", "I look for", "Where are the"}

	b := strings.builder_make()

	for l, i in lines {
		strings.write_string(&b, l)
		if i != len(lines) - 1 {
			strings.write_string(&b, " cats.\n")
		} else {
			strings.write_string(&b, " cats?")
		}
	}

	str := strings.to_string(b)
	fmt.println(str)
	strings.builder_destroy(&b)

	// Using string builder with temp allocator
	lines_2 := []string{"I like", "I look for", "Where are the"}

	b_2 := strings.builder_make(context.temp_allocator)

	for l, i in lines_2 {
		strings.write_string(&b_2, l)
		if i != len(lines_2) - 1 {
			strings.write_string(&b_2, " cats.\n")
		} else {
			strings.write_string(&b_2, " cats?")
		}
	}

	str_2 := strings.to_string(b_2)
	fmt.println(str_2)

	// Example of using the temp allocator and keeping a string after temp allocator
	// is free
	b_3 := strings.builder_make(context.temp_allocator)

	strings.write_string(&b_3, "I have")
	strings.write_int(&b_3, 7)
	strings.write_string(&b_3, " cats.")

	str_3 := strings.clone(strings.to_string(b_3))
	fmt.println(str_3)

	free_all(context.temp_allocator)
}
