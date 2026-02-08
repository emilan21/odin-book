package implicit_context_logger_file

import "core:log"
import "core:os"

main :: proc() {
	// Logging to a file requries a bit more setup
	mode: int = 0
	when ODIN_OS == .Linux || ODIN_OS == .Darwin {
		mode = os.S_IRUSR | os.S_IWUSR | os.S_IRGRP | os.S_IROTH
	}

	logh, logh_err := os.open("log.txt", (os.O_CREATE | os.O_TRUNC | os.O_RDWR), mode)

	// Optional. This redirects fmt.println and fmt.eprintln for example to the log
	// Probably best not to do this and use the functions in core:log
	// Available logging procedures are
	// log.debug()
	// log.info()
	// log.warn()
	// log.error()
	// log.fatal()
	// log.panic()
	// These are in the order of severity
	// log.panic() is special in that it is a log but also crashes the program on purpose
	// All of these procedures have a version that ends with f, such as log.infof()
	// which allows you to do string formatting on the message
	if logh_err == os.ERROR_NONE {
		os.stdout = logh
		os.stderr = logh
	}

	logger :=
		logh_err == os.ERROR_NONE ? log.create_file_logger(logh) : log.create_console_logger()
	context.logger = logger

	log.info("Program started")
	// Rest of program here
	// It will use context.logger any time you use log.info or log.error
	// Also fmt.println will be redirected to the logger, due to the
	// `os.stdout = logh` lines

	log.info("Program finished")

	if logh_err == os.ERROR_NONE {
		log.destroy_file_logger(logger)
	} else {
		log.destroy_console_logger(logger)
	}
}
