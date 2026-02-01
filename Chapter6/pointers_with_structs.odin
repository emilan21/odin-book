package pointers_with_structs

import "core:fmt"

Cat :: struct {
	name:  string,
	age:   int,
	color: Cat_Color,
}

Cat_Color :: enum {
	Black,
	White,
	Orange,
	Tabby,
	Calico,
}

main :: proc() {
	my_cat := Cat {
		name  = "Patches",
		age   = 7,
		color = .Calico,
	}

	process_cat_birthday(&my_cat)

	// Hooray, Patches is now 8 years old!
	fmt.printfln("Hooray, %v is now %v years old!", my_cat.name, my_cat.age)

	replace_cat(&my_cat)

	fmt.printfln("Cat name: %v, Cat age: %v, Cat color: %v", my_cat.name, my_cat.age, my_cat.color)
}

process_cat_birthday :: proc(cat: ^Cat) {
	if cat == nil {
		return
	}

	cat.age += 1
}

replace_cat :: proc(cat: ^Cat) {
	if cat == nil {
		return
	}

	cat^ = {
		name  = "Klucke",
		age   = 6,
		color = .Tabby,
	}
}
