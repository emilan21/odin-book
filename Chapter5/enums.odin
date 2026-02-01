package enums

import "core:fmt"

Computer_Type :: enum {
	Laptop, // value 0
	Desktop, // value 1
	Mainframe, // value 2
}

Computer_Type_2 :: enum {
	Laptop = 1, // value 1
	Desktop, // value 2
	Mainframe, // value 3
}

main :: proc() {

	// As this is not initalized this will default to value 0 or laptop as laptop is 0
	ct: Computer_Type

	// As this is not initalized this will default to value 0 which is nothing in Computer_Type_2 as the first value is set to 1
	ct_2: Computer_Type_2

	switch ct {
	case .Laptop:
		fmt.println("It's a laptop")
	case .Desktop:
		fmt.println("It's a desktop")
	case .Mainframe:
		fmt.println("It's a mainframe")
	}

	ct = .Mainframe

	switch ct {
	case .Laptop:
		fmt.println("It's a laptop")
	case .Desktop:
		fmt.println("It's a desktop")
	case .Mainframe:
		fmt.println("It's a mainframe")
	}

	// In this case nothing with print because the default value for ct_2 is 0 which is none of the enum options
	switch ct_2 {
	case .Laptop:
		fmt.println("It's a laptop")
	case .Desktop:
		fmt.println("It's a desktop")
	case .Mainframe:
		fmt.println("It's a mainframe")
	}

	ct_2 = .Desktop

	switch ct_2 {
	case .Laptop:
		fmt.println("It's a laptop")
	case .Desktop:
		fmt.println("It's a desktop")
	case .Mainframe:
		fmt.println("It's a mainframe")
	}
}
