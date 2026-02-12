package error_handling

import "core:encoding/json"
import "core:fmt"
import "core:os"

// Bool
Cat :: struct {
	name: string,
	age:  int,
}

find_cat_with_name :: proc(cats: []Cat, name: string) -> (Cat, bool) {
	for cat in cats {
		if cat.name == name {
			return cat, true
		}
	}

	return {}, false
}

// Enum
Load_Config_Error :: enum {
	None,
	File_Unreadable,
	Invalid_Format,
}

Config :: struct {
	fullscreen:      bool,
	window_position: [2]int,
}

load_config :: proc(filename: string) -> (Config, Load_Config_Error) {
	config_data, config_data_ok := os.read_entire_file(filename, context.temp_allocator)

	if !config_data_ok {
		return {}, .File_Unreadable
	}

	result: Config

	json_error := json.unmarshal(config_data, &result, allocator = context.temp_allocator)

	if json_error != nil {
		return {}, .Invalid_Format
	}

	return result, .None
}

DEFAULT_CONFIG :: Config {
	fullscreen      = false,
	window_position = {100, 100},
}

// Union
Help_Request_tmp :: distinct bool

Validation_Error_tmp :: struct {
	message: string,
}

// Use if you need complex error types
Error_tmp :: union {
	//Parse_Error_tmp,
	//Open_File_Error_tmp,
	Help_Request_tmp,
	Validation_Error_tmp,
}

main :: proc() {
	// Error handling in Odin is just returning an extra value in a procedure. They are normally bools, enums, or unions. No exceptions in odin
	// Bool example
	cats: [3]Cat = {Cat{"Molly", 12}, Cat{"Frank", 15}, Cat{"Dog", 7}}
	cat, cat_ok := find_cat_with_name(cats[:], "Molly")
	if cat_ok {
		fmt.println(cat)
	}

	// Two ways to use the error return value
	config, config_error := load_config("config.json")
	// This version is shorter and sets the default value but no printing or logging the error
	// or_return is similar as it will return a default in case of the conditional is false
	// needs named return values for or_return
	config_2 := load_config("config.ini") or_else DEFAULT_CONFIG

	if config_error != .None {
		fmt.eprintln("Failed loading config with error", config_error)
		config = DEFAULT_CONFIG
	}
	fmt.println(config)
	fmt.println(config_2)

	// the tag #optional_allocator_error can be used to make a the caller of a procedure to ignore the error return value
	// #optional_ok will allow the caller to ignore the last bool return value of a prodecure
}
