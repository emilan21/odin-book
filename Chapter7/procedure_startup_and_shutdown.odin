#+feature global-context

package procedure_startup_and_shutdown

import "core:fmt"

// Put @init in front of a procedure to automatically run it when your program starts
// Put @fini in front of a procedure to automatically run it when your program shuts down
main :: proc() {
	fmt.println("Program running")
}

@(init)
startup :: proc() {
	fmt.println("Program started")
}

@(fini)
shutdown :: proc() {
	fmt.println("Program shutting down")
}
