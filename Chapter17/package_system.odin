package package_system

import "core:fmt"
import "hello"

main :: proc() {
	fmt.println(hello.say_hello())
}
