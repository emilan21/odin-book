package heap_allocations

// If you separately heap allocate all the elements of an array, then the elements may get scattered in memory.
// When they are scattered it becomes very hard to keep the CPU cache filled which could make the program run slower

Person :: struct {
	health: int,
	age:    int,
}

// Array of pointers to Person object not yet made until add_person called
people: [dynamic]^Person

// This function does a new allocate of an object of type Person when it runs. This could make each Person struct
// end up in a bunch of different memory locations than each other.
add_person :: proc(health: int, age: int) {
	p := new(Person)

	p^ = {
		health = health,
		age    = age,
	}

	append(&people, p)
}

// Removed the ^ in front of the Person in people_2: [dynamic]Person. Also not running new within add_person_better. This makes the memory layout
// much simpler, as illustrated in the image in the book. Each element of the array directly contains its own data without any
// indirection. All the elements are packaed one-net-to-the-other in memory.

// This is just an arrary that can group but it is still an array
people_2: [dynamic]Person

add_person_better :: proc(health: int, age: int) {
	p := Person {
		health = health,
		age    = age,
	}

	append(&people_2, p)
}

// Say that our program has been running for a long time and elements have been added to people every now and then
// resulting in a big array

// If we now want to calculate the average age of all the people then this code would work regardles of which memeroy layout we chose earlier.

/*
average_age := 0
for &p in people {
    average_age += p.age
}

average_age /= len(people)
*/

// In the case where we separately heap allocated each item of the array (the scattered case): For each lap of the loop p.age is fetech. But this p can be anywhere in memory,
// because of all the separate heap allocations. So for each lap of the loop, the computer has to jump around a lot in memory in a very disorganzied way. This makes it very
// hard to keep the CPU cache filled, and thereby amke it hard for the program to run at optimal speed.

// Two reasons for this

// 1. When the computer fetches some data from main memory, then it also brings along some additional data in the nearby memory regions. This block of data is known as a cache line or cache block
// 2. When the computer fetches data several times, such as in a loop, then the computer starts guessing what will be fetched next. Based on these access patterns, it will try to prefetch data and put it in the CPU cache.

// In the case where everything is separately heap allocated, it's unlikely that any of these methods for filling the cache will workd. It is likely that the cahce has to be refilled, instead of immediately used.
// This is known as a cache miss. Going to main memory is far slower than using the CPU cache

// In the case of the non-separately allocated array ( the tight case ) Each item of the array lives next to the other. If the array elements are small enought then point (1) above will ensure that several elements
// are in the cache at once. Since the elements are laid out in a very predictable way, point (2) may help fill the cache as well. So when the loop fetches p.age then it is likely already in the cache due to the previous laps of
// the loop having filled the cache.

// While doing this on a single array will not do much in terms of performace if you program this way in gerenal then your program will be much fasters

main :: proc() {

}
