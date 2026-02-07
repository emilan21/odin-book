package more_container_types_custom_iterators

import "core:fmt"

Slot :: struct {
	important_value: int,
	used:            bool,
}

Slots_Iterator :: struct {
	index: int,
	data:  []Slot,
}

make_slots_iterator :: proc(data: []Slot) -> Slots_Iterator {
	return {data = data}
}

slots_iterator :: proc(it: ^Slots_Iterator) -> (val: Slot, idx: int, cond: bool) {
	cond = it.index < len(it.data)

	for ; cond; cond = it.index < len(it.data) {
		if !it.data[it.index].used {
			it.index += 1
			continue
		}

		val = it.data[it.index]
		idx = it.index
		it.index += 1
		break
	}

	return
}

slots_iterator_ptr :: proc(it: ^Slots_Iterator) -> (val: ^Slot, idx: int, cond: bool) {
	cond = it.index < len(it.data)

	for ; cond; cond = it.index < len(it.data) {
		if !it.data[it.index].used {
			it.index += 1
			continue
		}

		val = &it.data[it.index]
		idx = it.index
		it.index += 1
		break
	}

	return
}

main :: proc() {
	slots := make([]Slot, 128)

	slots[10] = {
		important_value = 7,
		used            = true,
	}

	it := make_slots_iterator(slots[:])

	for val in slots_iterator(&it) {
		fmt.println(val)
	}

	it_ptr := make_slots_iterator(slots[:])

	for val in slots_iterator_ptr(&it_ptr) {
		fmt.println(val)
	}
}
