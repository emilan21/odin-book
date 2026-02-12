package callback_test

import "core:fmt"
import "printer"

print_message :: proc(msg: string) {
	fmt.println(msg)
}

end_of_work :: proc() {
	fmt.println("Let's all go home")
}

main :: proc() {
	interface := printer.Printer_Interface {
		print       = print_message,
		end_of_work = end_of_work,
	}

	printer.interface = interface
	printer.do_work()
}
