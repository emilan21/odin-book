package more_container_types_maps

import "core:fmt"

main :: proc() {
	// maps are like dictionaries in python, key value pairs
	// this is a map of string keys and int values
	age_by_name: map[string]int

	// Add extries by writing...
	age_by_name["Karl"] = 35
	age_by_name["Klucke"] = 7

	// inerate maps as follows
	// if you put & if front of value you can modify the value
	for key, value in age_by_name {
		fmt.printfln("key: %v, value: %v", key, value)
	}

	// maps are dynamic memory so you need to delete them
	delete(age_by_name)

	// Can provide an initial capacity to make
	age_by_name_2 := make(map[string]int, 64, context.temp_allocator)

	delete(age_by_name_2)

	// maps are good for alot of things like if you don't know all possible keys.
	// If you do then use a enum and an enum array as they are faster

	// making a set with a map. A set is a collection where each item can only appear once
	set_of_names: map[string]struct{}

	// Add to set
	// We us {}, and empty struct as a value because it uses 0 bytes of memory
	set_of_names["Pontus"] = {}
	set_of_names["Bob"] = {}
	fmt.println(set_of_names)

	// Check if set contains "Pontus"
	if "Pontus" in set_of_names {
		fmt.printfln("Pontus in names set")
	}

	// Iterate set
	for key in set_of_names {
		fmt.printfln("key: %v, value: %v", key, set_of_names[key])
	}

	// Remove from set
	delete_key(&set_of_names, "Pontus")
	for key in set_of_names {
		fmt.println(key)
	}
}
