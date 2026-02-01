package unions

import "core:fmt"

My_Union :: union {
	f32,
	int,
	Person_Data,
}

Person_Data :: struct {
	health: int,
	age:    int,
}

Shape :: union {
	Shape_Circle,
	Shape_Square,
}

Shape_2 :: union #no_nil {
	Shape_Circle,
	Shape_Square,
}

Shape_Circle :: struct {
	radius: f32,
}

Shape_Square :: struct {
	width: f32,
}

main :: proc() {

	val: My_Union = int(12)

	switch v in val {
	case f32:
		fmt.println("It is an f32!")
	case int:
		fmt.println("It is an int!")
	case Person_Data:
		fmt.println("It is an Person_Data!")
	}

	f32_val, f32_val_ok := val.(f32)
	int_val, int_val_ok := val.(int)
	person_data_val, person_data_val_ok := val.(Person_Data)

	if f32_val_ok {
		fmt.printfln("val: %f", f32_val)
	}
	if int_val_ok {
		fmt.printfln("val: %d", int_val)
	}
	if person_data_val_ok {
		fmt.printfln("val: %v", person_data_val)
	}

	val_2: My_Union = f32(14.45)

	switch &v_2 in val_2 {
	case f32:
		fmt.printfln("v_2: %f", v_2)
		fmt.println("It is an f32!")
		v_2 = 45.31
		fmt.printfln("v_2: %f", v_2)
	case int:
		fmt.println("It is an int!")
	case Person_Data:
		fmt.println("It is an Person_Data!")
	}

	if f32_val_2, ok := &val_2.(f32); ok {
		fmt.printfln("val_2: %f", f32_val_2)
		f32_val_2^ = 87.298
		fmt.printfln("val_2: %f", f32_val_2)
	}
	if int_val_2, int_val_2_ok := val_2.(int); int_val_2_ok {
		fmt.printfln("val_2: %d", int_val_2)
	}
	if person_data_val_2, person_data_val_2_ok := val_2.(Person_Data); person_data_val_2_ok {
		fmt.printfln("val_2: %v", person_data_val_2)
	}

	val_3: My_Union = Person_Data {
		health = 76,
		age    = 14,
	}

	switch v_3 in val_3 {
	case f32:
		fmt.println("It is an f32!")
	case int:
		fmt.println("It is an int!")
	case Person_Data:
		fmt.println("It is an Person_Data!")
	}

	f32_val_3, f32_val_3_ok := val_3.(f32)
	int_val_3, int_val_3_ok := val_3.(int)
	person_data_val_3, person_data_val_3_ok := val_3.(Person_Data)

	if f32_val_3_ok {
		fmt.printfln("val_3: %f", f32_val_3)
	}
	if int_val_3_ok {
		fmt.printfln("val_3: %d", int_val_3)
	}
	if person_data_val_3_ok {
		fmt.printfln("val_3: %v", person_data_val_3)
	}

	// Zero value: nil
	shape: Shape
	fmt.printfln("shape: %v", shape)

	// Zero value:
	// Variant Shape_Circle
	shape_2: Shape_2
	fmt.printfln("shape_2: %v", shape_2)
}
