package fixed_arrays_simple

import "core:fmt"

Rectangle :: struct {
	x:      f32,
	y:      f32,
	width:  f32,
	height: f32,
}

main :: proc() {
	// fixed array containing 7 integers - zero-initialized
	some_ints: [7]int

	// If you have to set the values at assignment
	some_ints_2 := [7]int{51, 21, 621, 1, 51, 7, 12}

	// To fetch values
	fmt.printfln("some_ints[4]: %v", some_ints[4])

	// To loop over array
	for v in some_ints {
		fmt.println(v)
	}

	// To loop with index as well
	for v, i in some_ints {
		// This will print:
		// `value at o is <some number>`
		//etc
		fmt.printfln("value at %v is %v", i, v)
	}

	// To loop over array
	// v is immutable so add & in front of v if you need to modify the variable
	for &v in some_ints {
		v *= 2
		fmt.println(v)
	}

	// Get length
	fmt.printfln("The length of some_ints is %v", len(some_ints))

	// Can do structs or other complex types as well
	rectangles: [10]Rectangle
	fmt.println(rectangles)

	// Memory for fixed arrays is on the stack. Fixed arrays copy the same way as
	// other basic variables like ints. It makes a new variable with a separate copy of the data
	// Note works the same if the fixed array is in a struct
	some_ints_3: [100]int
	some_ints_3[10] = 2
	some_ints_4 := some_ints_3
	some_ints_4[10] = 5
	fmt.println(some_ints_3[10]) // 2
	fmt.println(some_ints_4[10]) // 5
}
