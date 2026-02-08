package strings_construct_strings_fmt

import "core:fmt"

main :: proc() {
	// tprint
	name := "Pontus"
	age := 7
	str := fmt.tprint(name, "is", age, sep = " really ")
	fmt.println(str)

	// aprint allows you to specify an allocator
	str_2 := fmt.aprint(name, "is", age, allocator = context.temp_allocator)
	fmt.println(str_2)

	// Format string is more common
	str_3 := fmt.tprintf("%v is %v", name, age)
	fmt.println(str_3)

	// New line versions
	str_4 := fmt.tprintfln("%v is %v", name, age)
	fmt.println(str_4)

	// You can also not use any allocator at all
	// Use a buffer that lives on the stack combined with
	// fmt.bprintf
	buf: [128]byte
	str_5 := fmt.bprintf(buf[:], "%v is %v", name, age)
	fmt.println(str_5)

	free_all(context.temp_allocator)
}
