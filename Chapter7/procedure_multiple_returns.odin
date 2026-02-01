package procedure_multiple_returns

import "core:fmt"

divide_and_double :: proc(n: f32, d: f32) -> (f32, bool) {
	if d == 0 {
		return 0, false
	}

	return (n / d) * 2, true
}

@(require_results)
divide_and_double_required :: proc(n: f32, d: f32) -> (f32, bool) {
	if d == 0 {
		return 0, false
	}

	return (n / d) * 2, true
}

main :: proc() {
	res, ok := divide_and_double(2, 4)

	if ok {
		fmt.println(res)
	}

	// ignore bool
	res, _ = divide_and_double(2, 4)

	fmt.println(res)

	// will not complie
	//divide_and_double_required(2, 4)

	// nicer way to call this style of function
	if result, good := divide_and_double(2, 4); good {
		fmt.println(res)
	}
}
