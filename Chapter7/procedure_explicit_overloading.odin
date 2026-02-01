package procedure_explicit_overloading

import "core:fmt"
import "core:math"

// Use explicit overloading to make two or more procedures exist under the same name. Here
// is an example of how to implement a procedure length that accepts both [2]f32 and [3]f32 arguments.
// These fixed arrays as 2 and 3 dimensional vectors
length :: proc {
	length_float2,
	length_float3,
}

length_float2 :: proc(v: [2]f32) -> f32 {
	return math.sqrt(v.x * v.x + v.y * v.y)
}

length_float3 :: proc(v: [3]f32) -> f32 {
	return math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
}

main :: proc() {
	v2 := [2]f32{3, 3}
	v3 := [3]f32{3, 3, 3}

	len_v2 := length(v2)
	len_v3 := length(v3)

	fmt.printfln("v2: %v, len_v2: %v", v2, len_v2)
	fmt.printfln("v3: %v, len_v3: %v", v3, len_v3)
}
