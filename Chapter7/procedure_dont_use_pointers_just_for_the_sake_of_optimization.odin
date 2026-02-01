package procedure_dont_user_pointers_just_for_the_sake_of_optimization

import "core:fmt"

// 48 bytes in size
// can find size by using size_of(p)
Person :: struct {
	name:            string,
	health:          int,
	age:             int,
	number_of_teeth: int,
	height_meters:   f32,
}

// A parameter that is larger than 16 bytes is automatically passed as an immutable reference so there is not overhead
// Immutable means use can use p but can not change the fields of Person in p
print_person_info :: proc(p: Person) {
	fmt.printfln(
		"%v is %v years old and has %v teeth. Their health is %v.",
		p.name,
		p.age,
		p.number_of_teeth,
		p.health,
	)
}

// If you need to change the fields in Person you can either make a local copy by doing the following
set_person_health :: proc(health: int, p: Person) -> Person {
	p := p
	p.health = health
	return p
}

// or you can use a pointer to p
set_person_age :: proc(age: int, p: ^Person) {
	p^.age = age
}

main :: proc() {
	p := Person {
		name            = "Bob",
		health          = 100,
		age             = 45,
		number_of_teeth = 26,
		height_meters   = 3.2,
	}

	// Because Person is larger than 16 bytes odain will automatically be passed as an immutable reference and not copied
	// when print_person_info() is called. So no need for a pointer
	fmt.printfln("Person is %v bytes.", size_of(p))
	print_person_info(p)

	new_p := set_person_health(200, p)
	print_person_info(new_p)

	set_person_age(23, &p)
	print_person_info(p)
}
