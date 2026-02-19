package main

import "core:fmt"
import "core:math"

import my_lib_2 "my_lib_2"

main :: proc() {
	fmt.println("=== Math Library Demo (No Callbacks) ===\n")
	
	// Just use the library directly - no setup needed!
	
	// 2D Vector
	v1 := my_lib_2.Vec2{x = 3.0, y = 4.0}
	v2 := my_lib_2.Vec2{x = 1.0, y = 2.0}
	
	result := my_lib_2.vec2_add(v1, v2)
	fmt.printf("v1 + v2 = (%.2f, %.2f)\n", result.x, result.y)
	
	length := my_lib_2.vec2_length(v1)
	fmt.printf("|v1| = %.2f\n\n", length)
	
	// 3D Vector
	a := my_lib_2.Vec3{x = 1.0, y = 0.0, z = 0.0}
	b := my_lib_2.Vec3{x = 0.0, y = 1.0, z = 0.0}
	
	cross := my_lib_2.vec3_cross(a, b)
	fmt.printf("a × b = (%.2f, %.2f, %.2f)\n\n", cross.x, cross.y, cross.z)
	
	// Matrix
	identity := my_lib_2.mat3_identity()
	fmt.println("Identity matrix:")
	for i in 0..<3 {
		fmt.printf("  [%.2f, %.2f, %.2f]\n", 
			identity.data[i][0], identity.data[i][1], identity.data[i][2])
	}
	
	// This works without any callback set!
	inverse := my_lib_2.mat3_inverse(identity)
	fmt.println("\nInverse works fine without callback")
	
	// Statistics
	values := [?]f32{10.0, 20.0, 30.0, 40.0, 50.0}
	mean := my_lib_2.mean(&values[0], 5)
	fmt.printf("\nMean: %.2f\n", mean)
	
	// Trig
	angle := my_lib_2.degrees_to_radians(90.0)
	fmt.printf("90° = %.4f radians\n", angle)
}
