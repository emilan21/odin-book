#+private file
package private_folder

import "core:fmt"

// Can only be used in this file
some_int: int

// Can be used in whole package
@(private = "package")
some_proc :: proc() {
	fmt.println("can be used in whole package")
}
