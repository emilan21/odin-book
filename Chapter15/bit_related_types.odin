package bit_related_types

import "core:fmt"

// bit_set enum
Keycard :: enum {
	Red,
	Green,
	Blue,
	Yellow,
}

// bit field enum
Packet_type :: enum {
	Handshake,
	Message,
	Disconnect,
}

Network_Packet_Header :: bit_field i32 {
	type:         Packet_type | 8,
	receiver_id:  uint        | 8,
	payload_size: uint        | 16,
}

main :: proc() {
	// bit_set
	keycards: bit_set[Keycard]
	keycards += {.Red, .Blue}
	fmt.println(keycards)

	// bit_set, setting and clearing bits
	keycards_2 := bit_set[Keycard]{.Red, .Blue, .Green}
	keycards_2 += {.Yellow}
	keycards_2 -= {.Red, .Green}
	fmt.println(keycards_2)

	// bit_set, checking if bits are set or not
	keycards_3 := bit_set[Keycard]{.Red, .Blue, .Green}
	fmt.println(.Red in keycards_3)
	fmt.println(.Yellow not_in keycards_3)

	// bit_set, combining bit set based on the values two bit_sets have in common
	keycards_4 := bit_set[Keycard]{.Red, .Blue}
	keycards_5 := bit_set[Keycard]{.Yellow, .Blue}
	in_common := keycards_4 & keycards_5
	fmt.println(in_common)

	// bit_set, forcing backing type
	keycards_6: bit_set[Keycard;i64]

	// bit_set, you can also use a range of letters or numbers
	numbers: bit_set[0 ..= 5]
	numbers += {4, 2}
	fmt.println(numbers)
	fmt.println(2 in numbers)

	letters: bit_set['A' ..= 'Z']
	letters += {'B', 'Q'}
	fmt.println('E' in letters)

	// bit_field, example
	h := Network_Packet_Header {
		type         = .Message,
		receiver_id  = 4,
		payload_size = 1200,
	}

	size := h.payload_size
	fmt.println(size)

	// Use a bit field whenever you want a struct-like type, but you want to be specific about how much data each
	// field uses. However, if you make a bit_field that only uses fields of type bool that are all of size 1, then
	// use a bit_set instead.
}
