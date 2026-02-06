package manual_memory_dynamic_array

import "core:fmt"

main :: proc() {

	dyn_arr: [dynamic]int
	fmt.println(dyn_arr[:])
	append(&dyn_arr, 5)
	fmt.println(dyn_arr[0])
	append(&dyn_arr, 7)
	fmt.println(dyn_arr[0])
	fmt.println(dyn_arr[1])
	fmt.println(dyn_arr[:])
	dyn_arr[0] = 18
	fmt.println(dyn_arr[:])
	for v, i in dyn_arr {
		fmt.printfln("index: %v, element: %v", i, v)
	}
	fmt.printfln("len: %v", len(dyn_arr))
	fmt.printfln("cap: %v", cap(dyn_arr))
}
