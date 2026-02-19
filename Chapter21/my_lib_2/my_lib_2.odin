package my_lib_2

import "core:c"

when ODIN_OS == .Windows {
	foreign import math_lib "windows/math_lib.lib"
} else when ODIN_OS == .Linux {
	foreign import math_lib "linux/math_lib.a"
} else when ODIN_OS == .Darwin {
	foreign import math_lib "macos/math_lib.a"
}

// Vector types
Vec2 :: struct {
	x: c.float,
	y: c.float,
}

Vec3 :: struct {
	x: c.float,
	y: c.float,
	z: c.float,
}

// 3x3 Matrix
Mat3 :: struct {
	data: [3][3]c.float,
}

// Progress callback type
ProgressCallback :: proc "c" (step: c.int, total: c.int, operation: cstring)

@(default_calling_convention = "c")
foreign math_lib {
	// Progress callback
	set_progress_callback :: proc(callback: ProgressCallback) ---
	
	// 2D Vector operations
	vec2_add :: proc(a: Vec2, b: Vec2) -> Vec2 ---
	vec2_sub :: proc(a: Vec2, b: Vec2) -> Vec2 ---
	vec2_scale :: proc(v: Vec2, scalar: c.float) -> Vec2 ---
	vec2_dot :: proc(a: Vec2, b: Vec2) -> c.float ---
	vec2_length :: proc(v: Vec2) -> c.float ---
	vec2_normalize :: proc(v: Vec2) -> Vec2 ---
	
	// 3D Vector operations
	vec3_add :: proc(a: Vec3, b: Vec3) -> Vec3 ---
	vec3_sub :: proc(a: Vec3, b: Vec3) -> Vec3 ---
	vec3_scale :: proc(v: Vec3, scalar: c.float) -> Vec3 ---
	vec3_cross :: proc(a: Vec3, b: Vec3) -> Vec3 ---
	vec3_dot :: proc(a: Vec3, b: Vec3) -> c.float ---
	vec3_length :: proc(v: Vec3) -> c.float ---
	vec3_normalize :: proc(v: Vec3) -> Vec3 ---
	
	// Matrix operations
	mat3_identity :: proc() -> Mat3 ---
	mat3_multiply :: proc(a: Mat3, b: Mat3) -> Mat3 ---
	mat3_multiply_vec3 :: proc(m: Mat3, v: Vec3) -> Vec3 ---
	mat3_transpose :: proc(m: Mat3) -> Mat3 ---
	mat3_determinant :: proc(m: Mat3) -> c.float ---
	mat3_inverse :: proc(m: Mat3) -> Mat3 ---
	
	// Statistics
	mean :: proc(values: [^]c.float, count: c.int) -> c.float ---
	variance :: proc(values: [^]c.float, count: c.int) -> c.float ---
	standard_deviation :: proc(values: [^]c.float, count: c.int) -> c.float ---
	min_value :: proc(values: [^]c.float, count: c.int) -> c.float ---
	max_value :: proc(values: [^]c.float, count: c.int) -> c.float ---
	
	// Trigonometry
	degrees_to_radians :: proc(degrees: c.float) -> c.float ---
	radians_to_degrees :: proc(radians: c.float) -> c.float ---
	lerp :: proc(a: c.float, b: c.float, t: c.float) -> c.float ---
	clamp :: proc(value: c.float, min: c.float, max: c.float) -> c.float ---
}
