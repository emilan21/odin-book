package parametric_polymorphism

import "base:intrinsics"
import "core:fmt"
import "core:math/rand"

// Using $T means the complier will use the val type for the rest of the types
// In this version you need types that work with <= and >=. As we want only numbers
// we added where intrinsics.type_is_numeric(T) to force it to only allow numbers
// as stirngs for example can use <= and >=
clamp :: proc(val: $T, min: T, max: T) -> T where intrinsics.type_is_numeric(T) {
	if val <= min {
		return min
	}

	if val >= max {
		return max
	}

	return val
}

// Explicitly passing a type to a procedure
// This will allow you to pass it what type you want and it will return that type
// In this case if I pass it a f32 then the slice returned will be a slice of f32
make_random_sized_slice :: proc($T: typeid) -> []T {
	// `random_size` will be an integer
	// between 0 and 1024.
	random_size := rand.int_max(1024)
	return make([]T, random_size)
}

// Can also use this $-on-the-parameter-name to pass compile-time constants of other types than typeid
// a common example is to pass a compile-time constant integer
make_array_of_7 :: proc($N: int, $T: typeid) -> [N]T {
	res: [N]T
	for &v in res {
		v = 7
	}
	return res
}

main :: proc() {
	number_float: f32 = 15.0
	min_float: f32 = 2.0
	max_float: f32 = 8.0
	result_float := clamp(number_float, min_float, max_float)
	fmt.println(result_float)

	number_int: int = 7
	min_int: int = 2
	max_int: int = 8
	result_int := clamp(number_int, min_int, max_int)
	fmt.println(result_int)

	slice_f32 := make_random_sized_slice(f32)
	slice_int := make_random_sized_slice(int)

	// Use $T: typeid when you need to reason about a type at compile-time, but you got no value of that type
	// Use val: $T when you need a value of a type, but you also want to be able to reason about the type T at compile-time

	arr := make_array_of_7(128, f32)
}
