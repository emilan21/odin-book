package implicit_context_random_generator

import "base:runtime"
import "core:fmt"
import "core:math/rand"

main :: proc() {
	// There is a random number generator setup by default. However, you
	// can modify context.random_generator, chaning how any code
	// that uses the random number generator. While you can write your
	// own random number generator it is more common to use the default one
	// but change how it is seeded

	// This code will always return 48 in the println because we are seeding it with the same number
	// 42, if we did not override the context.random_generator it would have generated a random number
	// because the default is setup like that
	random_state := rand.create(42)
	context.random_generator = runtime.default_random_generator(&random_state)
	fmt.println(rand.int_max(100))

	// This does the same thing
	rand.reset(42)
	fmt.println(rand.int_max(100))
}
