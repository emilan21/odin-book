package avoid_separate_heap_allocs_benchmark

import fmt "core:fmt"
import "core:math/rand"
import "core:mem"
import "core:time"

Person :: struct {
	health: int,
	age:    int,
}

NUM_ELEMS :: 10000
NUM_TEST_ITERS :: 10

make_person :: proc() -> Person {
	health := int(rand.int31_max(101))
	age := int(rand.int31_max(101))

	return {health = health, age = age}
}

benchmark_scattered_array :: proc() -> f64 {
	people: [dynamic]^Person

	for _ in 0 ..< NUM_ELEMS {
		for i in 0 ..< 100 {
			_, _ = mem.alloc(rand.int_max(8) + 8)
		}

		p := new(Person)
		p^ = make_person()
		append(&people, p)
	}

	age_sum: int
	start := time.now()
	for i in 0 ..< NUM_TEST_ITERS {
		for &p in people {
			age_sum += p.age
		}
	}

	end := time.now()
	fmt.println("Scattered array age sum:", f32(age_sum) / (NUM_TEST_ITERS * NUM_ELEMS))

	return time.duration_milliseconds(time.diff(start, end))
}

// Could be a slight problem with this method. As this array can grow if you make pointers to it then they can become invalid
// For storing permanent references to an array element, use handles. A handle is essentially the index of the element plus a "generation" counter
// that tells you if the thing at the index has been destroyed. Would look like below.
/*
Handle :: struct {
    index: u32,
    generation: u32,
}
*/

benchmark_tight_array :: proc() -> f64 {
	people: [dynamic]Person

	for i in 0 ..< NUM_ELEMS {
		p := make_person()
		append(&people, p)
	}

	age_sum: int
	start := time.now()
	for i in 0 ..< NUM_TEST_ITERS {
		for &p in people {
			age_sum += p.age
		}
	}

	end := time.now()
	fmt.println("Tight array age sum:", f32(age_sum) / (NUM_TEST_ITERS * NUM_ELEMS))

	return time.duration_milliseconds(time.diff(start, end))
}

// One thing to know is that the benchmark_scattered_array gets a bit of an unfair advanagtage because the array in allocated in a loop
// In a real program you would add a person do other work, add a person so it is far more likely that the memory ends up scattered. This is not an issue
// with the benchmark_tight_array

// simulateing that by allocating some memory just berfor the p := new(Person)
main :: proc() {
	time_scattered := benchmark_scattered_array()
	time_tight := benchmark_tight_array()
	fmt.printfln("Cache friendly method is %.2f times faster", time_scattered / time_tight)
}
