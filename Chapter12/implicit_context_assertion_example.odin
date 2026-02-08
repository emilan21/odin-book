package implicit_context_assertion_example

import "base:runtime"
import "core:fmt"

assert_fail :: proc(prefix, message: string, loc := #caller_location) -> ! {
	fmt.printfln("Oh no, an assertion at line: %v", loc)
	fmt.println(message)
	runtime.trap()
}

main :: proc() {
	context.assertion_failure_proc = assert_fail
	number := 5
	assert(number == 7, "Number has wrong value")

	// Assertions can be turned off at complie time with -disable-assert
	// Can use ensure(condition, "Failure message") which always works even if assertions
	// are disabled. Good when you need to check something no matter what
}
