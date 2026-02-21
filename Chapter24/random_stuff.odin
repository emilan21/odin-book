package random_stuff

import "base:runtime"
import "core:fmt"
import "core:math/rand"
import "core:time"

main :: proc() {
	random_num := rand.uint32()
	random_num_range := rand.int_max(128)
	fmt.println(random_num)
	fmt.println(random_num_range)

	arr: [128]int

	for i in 0 ..< len(arr) {
		arr[i] = i
	}
	fmt.println(arr)

	rand.shuffle(arr[:])
	fmt.println(arr)

	// Set seed based on current time. This
	// give a different seed each time you
	// start the program
	seed := time.time_to_unix(time.now())
	rand.reset(u64(seed))

	// This will now use the global random
	// generator's seed:
	random_num_seeded := rand.uint32()
	fmt.println(random_num_seeded)

	// You can also create a random generator and explicitly
	// pass it to the prodecdures in the rand package
	random_state := rand.create(42) // seed is 42
	generator := runtime.default_random_generator(&random_state)
	random_num_state := rand.uint32(generator)
	fmt.println(random_num_state)
}
