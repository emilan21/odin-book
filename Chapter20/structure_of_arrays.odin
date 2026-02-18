package structure_of_arrays

import "core:fmt"
import "core:math/rand"

Person :: struct {
	health: int,
	age:    int,
}

// As the computer grabs memory in blocks called cache lines when it fills the cache, then it is beneficial if the data needed next is as close as possible to the data you're
// currently grabbing

main :: proc() {
	// default approach, called Arrays of Structures (AoS)
	people: [dynamic]Person

	for i in 0 ..< 1000 {
		append(&people, Person{health = rand.int_max(101), age = rand.int_max(101)})
	}

	// memory layout of AoS
	// people[0].health
	// people[0].age
	// people[1].health
	// people[1].age

	// If you say loop through the array in order to sum the ages of all the people and then you average the sum
	// this loop is only accessing the age field. However, when it fetches people[0].age to put in the cache, then it is alos plucking out
	// an area around that value. So the cache line that gets fetched may also contain people[1].health which is not even needed in the loop
	// this can cause cache misses
	age_sum: int
	for &p in people {
		age_sum += p.age
	}
	age_avg := f32(age_sum) / f32(len(people))

	fmt.println(age_avg)

	// Structure of Arrays layout (SoA)
	// Two changes:
	// added #soa in front of the [dynamic] of people_2
	// We use append_soa instead of append()
	people_2: #soa[dynamic]Person

	for i in 0 ..< 1000 {
		append_soa(&people_2, Person{health = rand.int_max(101), age = rand.int_max(101)})
	}

	// memory layout of SoA
	// people_2[0].health
	// people_2[1].health
	// people_2[2].health
	// people_2[0].age
	// people_2[1].age
	// people_2[2].age

	// This loop will now have cache line data that is mostly age
	age_sum_2: int
	for &p_2 in people_2 {
		age_sum_2 += p_2.age
	}
	age_avg_2 := f32(age_sum_2) / f32(len(people_2))

	fmt.println(age_avg_2)
}

// use SoA when you can as it is easy to use
