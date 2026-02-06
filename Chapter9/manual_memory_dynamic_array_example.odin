package manual_memory_dynamic_array_example

import "core:fmt"

main :: proc() {

	dyn_arr: [dynamic]int

	// Will make `dyn_arr` grow:
	append(&dyn_arr, 5)

	fmt.println("After first append:")
	fmt.println("Capacity: ", cap(dyn_arr)) // 8
	fmt.println("Length: ", len(dyn_arr)) // 1

	// append 7 numbers to the dynamic
	// array. This will not make `dyn_arr`
	// grow since capacity is `8` after
	// the first `append`.
	for i in 0 ..< 7 {
		append(&dyn_arr, i)
	}

	fmt.println("\nAfter 7 more appends:")
	fmt.println("Capacity: ", cap(dyn_arr)) // 8
	fmt.println("Length: ", len(dyn_arr)) // 8

	// Capacity is 8, length is 8. This
	// call to `append` will make `dyn_arr`
	// grow:
	append(&dyn_arr, 5)

	fmt.println("\nAfter one more appends:")
	fmt.println("Capacity: ", cap(dyn_arr)) // 24
	fmt.println("Length: ", len(dyn_arr)) // 9

	// This clears the contents of the array but keeps the same allocation
	// so it will have the same cap
	clear(&dyn_arr)

	append(&dyn_arr, 5)

	fmt.println("\nAfter clear:")
	fmt.println("Capacity: ", cap(dyn_arr)) // 8
	fmt.println("Length: ", len(dyn_arr)) // 1

	for i in 0 ..< 7 {
		append(&dyn_arr, i)
	}

	fmt.println("\nAfter appending 7 more items:")
	fmt.println("Capacity: ", cap(dyn_arr)) // 8
	fmt.println("Length: ", len(dyn_arr)) // 1
	fmt.println("Array: ", dyn_arr)

	// Two ways to remove items from a dynamic array
	unordered_remove(&dyn_arr, 4)

	fmt.println("\nAfter removing index 5:")
	fmt.println("Capacity: ", cap(dyn_arr)) // 8
	fmt.println("Length: ", len(dyn_arr)) // 1
	fmt.println("Array: ", dyn_arr)

	ordered_remove(&dyn_arr, 2)

	fmt.println("\nAfter removing index 5:")
	fmt.println("Capacity: ", cap(dyn_arr)) // 8
	fmt.println("Length: ", len(dyn_arr)) // 1
	fmt.println("Array: ", dyn_arr)

	// Can use shrink to make the array cap match the length
	shrink(&dyn_arr)
	fmt.println("\nAfter shrink:")
	fmt.println("Capacity: ", cap(dyn_arr))
	fmt.println("Length: ", len(dyn_arr))

	// Free/deallocate the memory
	delete(dyn_arr)

	// Preallocated dynamic arrays
	// This will make a dynamic array with the length of 0
	// but the cap for 20 items
	dyn_arr_2 := make([dynamic]int, 0, 20)
	fmt.println("\nCapacity: ", cap(dyn_arr_2))
	fmt.println("Length: ", len(dyn_arr_2))
	fmt.println("Array: ", dyn_arr_2)

	// This will make a dynamic array with the length of 20
	// and the cap for 20 items
	dyn_arr_3 := make([dynamic]int, 20)
	fmt.println("\nCapacity: ", cap(dyn_arr_3))
	fmt.println("Length: ", len(dyn_arr_3))
	fmt.println("Array: ", dyn_arr_3)
}
