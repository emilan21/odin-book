package printer

import "core:fmt"

Printer_Interface :: struct {
	print:       proc(msg: string),
	end_of_work: proc(),
}

interface: Printer_Interface

do_work :: proc() {
	fmt.println("First")

	if interface.print != nil {
		interface.print("Middle")
	}

	fmt.println("Last")

	if interface.end_of_work != nil {
		interface.end_of_work()
	}
}
