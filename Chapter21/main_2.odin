package main

import "base:runtime"
import "core:c"
import "core:fmt"
import "core:math"

import my_lib_2 "my_lib_2"

custom_context: runtime.Context

// Progress callback to track long operations
progress_callback :: proc "c" (step: c.int, total: c.int, operation: cstring) {
	context = custom_context
	fmt.printf("[%d/%d] %s\n", step, total, operation)
}

main :: proc() {
	custom_context = context
	
	fmt.println("=== Math Library Demo ===\n")
	
	// Set up progress callback
	my_lib_2.set_progress_callback(progress_callback)
	
	// 2D Vector examples
	fmt.println("--- 2D Vector Operations ---")
	v1 := my_lib_2.Vec2{x = 3.0, y = 4.0}
	v2 := my_lib_2.Vec2{x = 1.0, y = 2.0}
	
	fmt.printf("v1 = (%.2f, %.2f)\n", v1.x, v1.y)
	fmt.printf("v2 = (%.2f, %.2f)\n", v2.x, v2.y)
	
	v_add := my_lib_2.vec2_add(v1, v2)
	fmt.printf("v1 + v2 = (%.2f, %.2f)\n", v_add.x, v_add.y)
	
	v_sub := my_lib_2.vec2_sub(v1, v2)
	fmt.printf("v1 - v2 = (%.2f, %.2f)\n", v_sub.x, v_sub.y)
	
	v_scaled := my_lib_2.vec2_scale(v1, 2.0)
	fmt.printf("v1 * 2 = (%.2f, %.2f)\n", v_scaled.x, v_scaled.y)
	
	dot2 := my_lib_2.vec2_dot(v1, v2)
	fmt.printf("v1 · v2 = %.2f\n", dot2)
	
	len2 := my_lib_2.vec2_length(v1)
	fmt.printf("|v1| = %.2f\n", len2)
	
	v_norm := my_lib_2.vec2_normalize(v1)
	fmt.printf("normalize(v1) = (%.2f, %.2f)\n\n", v_norm.x, v_norm.y)
	
	// 3D Vector examples
	fmt.println("--- 3D Vector Operations ---")
	a := my_lib_2.Vec3{x = 1.0, y = 0.0, z = 0.0}
	b := my_lib_2.Vec3{x = 0.0, y = 1.0, z = 0.0}
	
	fmt.printf("a = (%.2f, %.2f, %.2f)\n", a.x, a.y, a.z)
	fmt.printf("b = (%.2f, %.2f, %.2f)\n", b.x, b.y, b.z)
	
	cross := my_lib_2.vec3_cross(a, b)
	fmt.printf("a × b = (%.2f, %.2f, %.2f)\n", cross.x, cross.y, cross.z)
	
	dot3 := my_lib_2.vec3_dot(a, b)
	fmt.printf("a · b = %.2f\n", dot3)
	
	len3a := my_lib_2.vec3_length(a)
	fmt.printf("|a| = %.2f\n\n", len3a)
	
	// Matrix examples
	fmt.println("--- Matrix Operations ---")
	identity := my_lib_2.mat3_identity()
	fmt.println("Identity matrix:")
	for i in 0..<3 {
		fmt.printf("  [%.2f, %.2f, %.2f]\n", 
			identity.data[i][0], identity.data[i][1], identity.data[i][2])
	}
	
	// Create a rotation matrix (90 degrees around Z)
	angle := my_lib_2.degrees_to_radians(90.0)
	rotation := my_lib_2.Mat3{
		data = {
			{math.cos_f32(angle), -math.sin_f32(angle), 0.0},
			{math.sin_f32(angle), math.cos_f32(angle), 0.0},
			{0.0, 0.0, 1.0},
		},
	}
	
	fmt.println("\nRotation matrix (90°):")
	for i in 0..<3 {
		fmt.printf("  [%.2f, %.2f, %.2f]\n", 
			rotation.data[i][0], rotation.data[i][1], rotation.data[i][2])
	}
	
	// Test matrix-vector multiplication
	test_vec := my_lib_2.Vec3{x = 1.0, y = 0.0, z = 0.0}
	rotated := my_lib_2.mat3_multiply_vec3(rotation, test_vec)
	fmt.printf("\nRotated vector: (%.2f, %.2f, %.2f)\n\n", rotated.x, rotated.y, rotated.z)
	
	// Statistics examples
	fmt.println("--- Statistics ---")
	values := [?]f32{23.0, 45.0, 67.0, 89.0, 12.0, 34.0, 56.0, 78.0}
	count := i32(len(values))
	
	fmt.printf("Data: %v\n", values)
	fmt.printf("Mean: %.2f\n", my_lib_2.mean(&values[0], count))
	fmt.printf("Variance: %.2f\n", my_lib_2.variance(&values[0], count))
	fmt.printf("Std Dev: %.2f\n", my_lib_2.standard_deviation(&values[0], count))
	fmt.printf("Min: %.2f\n", my_lib_2.min_value(&values[0], count))
	fmt.printf("Max: %.2f\n\n", my_lib_2.max_value(&values[0], count))
	
	// Trigonometry examples
	fmt.println("--- Trigonometry ---")
	degrees := f32(45.0)
	radians := my_lib_2.degrees_to_radians(degrees)
	fmt.printf("%.0f° = %.4f radians\n", degrees, radians)
	fmt.printf("%.4f rad = %.2f°\n", radians, my_lib_2.radians_to_degrees(radians))
	
	lerp_result := my_lib_2.lerp(0.0, 100.0, 0.75)
	fmt.printf("lerp(0, 100, 0.75) = %.2f\n", lerp_result)
	
	clamped := my_lib_2.clamp(150.0, 0.0, 100.0)
	fmt.printf("clamp(150, 0, 100) = %.2f\n\n", clamped)
	
	fmt.println("=== Demo Complete ===")
}
