package fixed_arrays_enumerated

import "core:fmt"

Nice_People :: enum {
	Bob,
	Klucke,
	Tim,
}

// Either meantion all of the enum members, none of the enum members, or use #partial to only specify some enum members
nice_rating := [Nice_People]int {
	.Bob    = 5,
	.Klucke = 7,
	.Tim    = 3,
}

main :: proc() {
	bobs_niceness := nice_rating[.Bob]
	fmt.println(bobs_niceness)
}
