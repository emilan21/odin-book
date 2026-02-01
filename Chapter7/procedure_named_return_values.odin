package procedure_named_return_values

import "core:fmt"

divide_and_double :: proc(n: f32, d: f32) -> (res: f32, ok: bool) {
	if d == 0 {
		return
	}

	res = (n / d) * 2
	ok = true

	return
}

main :: proc() {
	result, ok := divide_and_double(2.0, 4.0)

	if ok {
		fmt.println(result)
	}
}
