package c_stuff

// Access to most of the C11 standard library
// For example could use the libc package to run
// system commands like so
import "core:c/libc"
import "core:fmt"
// Different than c/libc. Give you c types such as c.int
// Good for bindings to c libraries
import "core:c"
// Linux api
import linux "core:sys/linux"
// Windows Win32 API
import windows "core:sys/windows"

main :: proc() {
	libc.system("ls")
}
