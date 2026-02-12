package reflection_rtti

import "core:fmt"
import "core:reflect"

// Odin allows you to get information about the type of an object while the program is running. This is known as Run-time Type Information (RTTI). RTTI allows
// you to ask question such as: What are the field names of a struct? What are the names of an enum's members? What variants does a union have? This is called reflection

Cat_Color :: enum {
	None,
	Tabby,
	Orange,
	Calico,
}

main :: proc() {
	color_name := "Orange"

	if color, ok := reflect.enum_from_name(Cat_Color, color_name); ok {
		fmt.println(int(color), color)
	}
}
