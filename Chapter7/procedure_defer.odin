package procedure_defer

import "core:bufio"
import "core:fmt"
import "core:mem"
import "core:os"
import "core:strings"
import rl "vendor:raylib"

most_green_color :: proc(filename: cstring) -> rl.Color {
	img := rl.LoadImage(filename)

	if img.data == nil || img.width == 0 || img.height == 0 {
		fmt.println("No data")
		return {}
	}

	defer rl.UnloadImage(img)

	most_green_color := rl.GetImageColor(img, 0, 0)

	for x in 0 ..< img.width {
		for y in 0 ..< img.height {
			color := rl.GetImageColor(img, i32(x), i32(y))

			if color.g == 255 {
				// r.UnloadImage(img) happens after this line
				return color
			}

			if color.g > most_green_color.g {
				most_green_color = color
			}
		}
	}

	return most_green_color
} // rl.UnloadImage(img) happens here.

main :: proc() {
	// Get input from stdin
	fmt.print("Enter a filename: ")

	persisten_string: string

	// Get a stream from the standard input handle
	stdin_stream := os.stream_from_handle(os.stdin)

	// Initialize a scanner with the stdin stream and a temporary allocator
	scanner: bufio.Scanner
	bufio.scanner_init(&scanner, stdin_stream, context.temp_allocator)

	// Scan for the next line (token separated by newline by default)
	if bufio.scanner_scan(&scanner) {
		// Retrieve the scanned text as a string
		input_string := bufio.scanner_text(&scanner)

		// clone the string ifyou need it to persist outside the current scope
		persisten_string = strings.clone(input_string, context.allocator)
	}

	// Check for errors during scanning
	if err := bufio.scanner_error(&scanner); err != nil {
		fmt.eprintfln("Error scanning input: %v", err)
	}
	defer free_all(context.temp_allocator)

	cstring_in := strings.clone_to_cstring(persisten_string) // covert to cstring
	defer mem.free(cast(rawptr)cstring_in)

	most_green_color := most_green_color(cstring_in)
	fmt.println(most_green_color)
}
