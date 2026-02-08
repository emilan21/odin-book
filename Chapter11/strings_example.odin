package strings_example

import "core:fmt"
import "core:strings"
import "core:unicode/utf8"

main :: proc() {
	// String literal
	my_string: string
	my_string = "Hellope!"
	fmt.println(my_string)

	my_string_2 := "Hellope!"
	fmt.println(my_string_2)

	// dynamic string
	allocated_string := strings.clone("Hellope!", context.allocator)
	fmt.println(allocated_string)

	delete(allocated_string)

	str := "Important Words"

	// Loop over string as runes
	for r in str {
		fmt.println(r)
	}

	// Substrings
	// Goes off of the bytes number not the rune count
	// In english as runes are 1 byte then the byte number and rune count is the same
	// Other lanauges like chinese are 3 bytes so 3 bytes is the first rune
	str_2 := "Little Cat"
	fmt.println(str_2)
	sub_str := str_2[7:]
	fmt.println(sub_str)

	// Substring from the rune not bytes
	sub_str_2, _ := strings.substring_from(str_2, 7)
	fmt.println(sub_str_2)

	// Len will tell you the bytes, rune count will tell you the number of runes
	fmt.printfln("Len: %v, Rune count: %v", len(str_2), strings.rune_count(str_2))

	// Loop over runes and get back an index
	for r, i in str_2 {
		fmt.printfln("index: %v, rune: %v", i, r)
	}

	// Construct a slice
	str_3 := "小猫咪"

	// Odd output because the rune byte size is not taken into account
	for r, i in str_3 {
		from_start := str_3[:i]
		fmt.println(from_start)
	}

	// Right way
	// utf8.rune_size() gives you the size of the rune so we are adding the
	// rune size to i to get the right run
	for r, i in str_3 {
		from_start := str_3[:i + utf8.rune_size(r)]
		fmt.println(from_start)
	}

	// There are some cases where one rune is not equivalent to one character. These are
	// called grapheme clusters which is something that appears to be a single character but
	// is really multiple runes
	str_4 := "ü"

	for r in str_4 {
		fmt.println(r)
		fmt.printfln(
			"len: %v, rune count: %v, rune size: %v",
			len(str_4),
			strings.rune_count(str_4),
			utf8.rune_size(r),
		)
	}
}
