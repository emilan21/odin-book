package implicit_context_logger_console

import "core:log"

main :: proc() {
	// Odin comes with a logger functionality in core:log. You can use log.info and log.error instead of fmt.println everywhere
	// You can also setup your logger to go to a file or console, or wherever
	// NOTE: context.logger is not set by default so core:log will not do anything at the start of the program until you
	// set it up
	context.logger = log.create_console_logger()

	log.info("Program started")
	// Rest of program here

	log.destroy_console_logger(context.logger)
}
