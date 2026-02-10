package parametric_polymorphism_structs_unions

import "base:intrinsics"
import "core:fmt"
import "core:math/rand"

Special_Array :: struct($T: typeid, $N: int) {
	items:          [N]T,
	num_items_used: int,
}

find_random_thing_in_special_array :: proc(arr: Special_Array($T, $N)) -> T {
	return arr.items[rand.int_max(arr.num_items_used)]
}

main :: proc() {
	array_f64: Special_Array(f64, 128)
	array_u32: Special_Array(u32, 4096)

	// Fill `array` with 32 items of random data.
	for i in 0 ..< 32 {
		array_f64.items[i] = rand.float64_range(-10, 10)
		array_f64.num_items_used += 1
	}

	for y in 0 ..< 1024 {
		array_u32.items[y] = rand.uint32()
		array_u32.num_items_used += 1
	}

	random_f64 := find_random_thing_in_special_array(array_f64)
	fmt.println(random_f64)
	random_u32 := find_random_thing_in_special_array(array_u32)
	fmt.println(random_u32)

	// unions can use $T as well. Not done often but the builtin type Maybe has this
	m: Maybe(f64)
	m = 4.32
	m_2: Maybe(int)
	m_2 = 0

	if m_val, m_val_ok := m.?; m_val_ok {
		fmt.println(m_val) // 4.32
	}

	if m_2_val, m_2_val_ok := m_2.?; m_2_val_ok {
		fmt.println(m_2_val)
	}
}
