package fixed_arrays_vectors_and_array_programming

import "core:fmt"

// Vector3 alias
Vector3 :: [3]f32

// If you are writing some 3D visualization software or a video game then you need to represent positions in 3D space.
// You can do this using a fixed array of three decimal numbers. A fixed two decimal array for 2D.
main :: proc() {
	position := [3]f32{7, 1, 2}

	fmt.printfln(
		"x position: %v, y position: %v, z position: %v",
		position.x,
		position.y,
		position.z,
	)

	// This is swizzling common in shaders like HLSL or GLSL
	zx_pos := position.zx
	xxyy_pos := position.xxyy

	fmt.println(zx_pos)
	fmt.println(xxyy_pos)

	// Using Vector3 and array math
	// add
	position_add_1: Vector3
	velocity := Vector3{0, 0, 10}
	position_add_1 += velocity
	fmt.println(position_add_1)

	// subtract
	position_subtract_1 := Vector3{10, 21, 1}
	position_subtract_2 := Vector3{9, 1, 3}
	from_1_to_2 := position_subtract_2 - position_subtract_1
	fmt.println(from_1_to_2) // [-1, -20, 2]

	// multiply element-wise
	xz_vector := Vector3{10, 0, -2}
	z_scaled_up := xz_vector * {1, 1, 10}
	fmt.println(z_scaled_up) // [10, 0, -20]

	// multiply by single number
	one_meter_ahead := Vector3{0, 0, 1}
	ten_meters_ahead := one_meter_ahead * 10
	fmt.println(ten_meters_ahead) // [0, 0, 10]
}
