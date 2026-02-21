package time_stuff

import "core:fmt"
import "core:time"

main :: proc() {
	start_time := time.now()
	last_print_time := time.now()

	for {
		current_time := time.now()

		if time.duration_seconds(time.diff(last_print_time, current_time)) > 1 {
			fmt.println("One second passed")
			last_print_time = current_time
		}

		if time.duration_minutes(time.since(start_time)) > 2 {
			fmt.println("Two minutes has passed, shutting down!")
			break
		}
	}
}
