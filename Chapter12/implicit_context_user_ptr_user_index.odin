package implicit_context_user_ptr_user_index

import "core:fmt"
import "core:slice"

Sort_Settings :: struct {
	put_at_end: int,
}

sorting_proc :: proc(i, j: int) -> bool {
	sort_settings := (^Sort_Settings)(context.user_ptr)

	if sort_settings != nil {
		if i == sort_settings.put_at_end {
			return false
		}

		if j == sort_settings.put_at_end {
			return true
		}
	}

	return i < j
}

main :: proc() {
	numbers := []int{2, 7, 42, 1}
	sort_settings := Sort_Settings {
		put_at_end = 2,
	}

	context.user_ptr = &sort_settings
	slice.sort_by(numbers, sorting_proc)
	fmt.println(numbers) // [1, 7, 42, 2]
}
