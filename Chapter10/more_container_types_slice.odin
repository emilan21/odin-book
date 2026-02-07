package more_container_types_slice

import "core:fmt"

main :: proc() {
	// fixed size
	my_numbers: [50]int
	for i in 0 ..< len(my_numbers) {
		my_numbers[i] += i + 1
	}
	fmt.printfln("Array: %v", my_numbers)
	first_20 := my_numbers[0:20]
	fmt.printfln("Slice first_20: %v", first_20)
	last_20 := my_numbers[30:]
	fmt.printfln("Slice last_20: %v", last_20)

	my_dyn_numbers: [dynamic]f32

	for i in 0 ..< 200 {
		append(&my_dyn_numbers, f32(i * i))
	}

	// dynamic
	fmt.printfln("Dyn arr: %v", my_dyn_numbers[:])
	half_dyn_arr_size := len(my_dyn_numbers) / 2
	half_the_dyn_arr := my_dyn_numbers[:half_dyn_arr_size]
	fmt.printfln("Half Dyn arr: %v", half_the_dyn_arr)

	// Can loop over slice
	for v, i in half_the_dyn_arr {
		fmt.printfln("Index: %v, Item: %v", i, v)
	}
}
