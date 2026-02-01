package procedure_always_immutable

import "core:fmt"

divide_numbers :: proc(n: f32, d: f32) -> f32 {
	// Not legal
	//n = n / d
	//return n

	// legal
	// This creates a copy of the parameter n and stores it in a new variable with the same name.
	// Can now modify n as it is not the immutable parameter but a new variable
	// This is called shadowing. The complier flag -vet disallows shadowing, however this special case
	// where you "self-shadow" a procedure parameter in order to get a mutable copy is still allowed.
	n := n
	n = n / d
	return n
}

// You can also use pointers
increase_number :: proc(n: ^int, amount: int) {
	n^ += amount

	// But you can not change what n or the pointer points to
	// Not legal
	// some_other_int := 7
	// n = &some_other_int
	// n^ += amount
}

main :: proc() {
	result := divide_numbers(8.0, 4.0)
	fmt.println(result)
}
