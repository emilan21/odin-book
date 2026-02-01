package procedure_pointer_aliasing

import "core:fmt"

// As this is large than 16 bytes it will be passed to procedures as immutable references
// they are susceptiable to reference aliasing with is simlar to pointer aliasing when
// two pointers end up pointing to the same data
Person :: struct {
	name:            string,
	health:          int,
	age:             int,
	number_of_teeth: int,
	height_meters:   f32,
}

Couple_Data :: struct {
	person_1: Person,
	person_2: Person,
}

// As the pointer to Couple_Data is pointing to the same data as Person if used as it is
// in the main proc then changing couple_data will change person as well even though person is
// a immutable reference
aliasing_example :: proc(cd: ^Couple_Data, person: Person) {
	cd.person_1 = {
		name = "This modifies 'person' too",
	}

	fmt.println(person.name)
}

// A way around this is to make an explict copy of the parameter that you think would have the issue. In
// this example do person := person at the top of the procedure
aliasing_example_fixed :: proc(cd: ^Couple_Data, person: Person) {
	person := person

	cd.person_1 = {
		name = "This modifies 'person' too",
	}

	fmt.println(person.name) // Prints the original name
}

main :: proc() {
	couple_data := Couple_Data {
		person_1 = {name = "Hans", age = 65},
		person_2 = {name = "Maj-Britt", age = 50},
	}

	fmt.println(couple_data)
	aliasing_example(&couple_data, couple_data.person_1)
	fmt.println(couple_data)
}
