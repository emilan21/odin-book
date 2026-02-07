package more_container_types_cat_simulation

import "core:fmt"
import "core:math/rand"

Cat :: struct {
	name: string,
	age:  int,
}

add_cat_of_random_age :: proc(cats: ^[dynamic]Cat, name: string) {
	random_age := rand.int_max(12) + 2
	append(cats, Cat{name = name, age = random_age})
}

print_cats :: proc(cats: []Cat) {
	for cat in cats {
		fmt.printfln("%v is %v years old", cat.name, cat.age)
	}
}

mutate_cats :: proc(cats: []Cat) {
	for &cat in cats {
		cat.age = rand.int_max(12) + 2
	}
}

main :: proc() {
	all_the_cats: [dynamic]Cat
	add_cat_of_random_age(&all_the_cats, "Klucke")
	add_cat_of_random_age(&all_the_cats, "Pontus")

	print_cats(all_the_cats[:])
	mutate_cats(all_the_cats[:])
	print_cats(all_the_cats[:])
}
