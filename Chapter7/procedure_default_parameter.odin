package procedure_default_parameter

import "core:fmt"

write_message :: proc(message: string, label: string = "Info") {
	if label != "" {
		fmt.print(label)
		fmt.print(": ")
	}

	fmt.println(message)
}

main :: proc() {
	write_message("Hellope!")
	write_message("Hellope!", "Very important info")
	// named arguments
	write_message(message = "Hellope!", label = "Very Very important info")
}
