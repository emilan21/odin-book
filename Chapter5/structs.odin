package structs

import "core:fmt"

Rectangle :: struct {
	x:      f32,
	y:      f32,
	width:  f32,
	height: f32,
}

Person_Stats :: struct {
	health: int,
	age:    int,
}

Person :: struct {
	stats: Person_Stats,
	name:  string,
}

Person_Stats_2 :: struct {
	health: int,
	age:    int,
}

Person_2 :: struct {
	using stats: Person_Stats,
	name:        string,
}

main :: proc() {
	rect := Rectangle {
		width  = 20,
		height = 10,
	}

	p := Person {
		stats = {health = 7},
		name = "Bob",
	}

	p_2 := Person_2 {
		health = 9,
		name   = "Tom",
		age    = 45,
	}

	fmt.printfln(
		"Rect width: %f, Rect height: %f, Rect x: %f, Rect y: %f",
		rect.width,
		rect.height,
		rect.x,
		rect.y,
	)

	fmt.printfln("Person name: %s, Person_Stats: %v", p.name, p.stats)
	fmt.printfln(
		"Person name: %s, Person health: %d, Person age: %d",
		p.name,
		p.stats.health,
		p.stats.age,
	)

	fmt.printfln("Person name: %s, Person_Stats: %v", p_2.name, p_2.stats)
	fmt.printfln(
		"Person name: %s, Person health: %d, Person age: %d",
		p_2.name,
		p_2.health,
		p_2.age,
	)
}
