package easier_memory_management_arena_allocators

import "core:fmt"
import vmem "core:mem/virtual"
import "core:strings"

Level :: struct {
	name:    string,
	objects: []Game_Object,
	tiles:   []Tiles,
	arena:   vmem.Arena,
}

generate_level :: proc(name: string) -> Level {
	level_arena: vmem.Arena
	arena_allocator := vmem.arena_allocator(&level_arena)

	tiles := generate_tiles(arena_allocator)
	objects := generate_objects(tiles, arena_allocator)
	return {
		name = strings.clone(name, arena_allocator),
		objects = objects,
		tiles = tiles,
		arena = level_arena,
	}
}

destroy_level :: proc(level: ^Level) {
	vmem.arena_destroy(&level.arena)
}

main :: proc() {
	// arena allocators can be used to group allocations that share a common lifetime. A shared lifetime means that a coup of allocations
	// should all be deallocated at the same time instead of one-by-one. The temp allocator is actually an arena allocator. You use
	// free_all(context.temp_allocator) to free everything in the arena

	// NOTE: You can only free the memory of the whole arena, not parts of it. Can be problmatic in some cases such as when you use
	// growing containers, such as dynamic arrays. When the array grow then it will allocate a bigger block of memory but since
	// it uses and arena allocator, the old block of memory can't be deallocated

	// Solutions to this
	// A. Preallocate your dynamic array with a sensible capacity: dyn_array := make([dynamic]My_Type, 0, 128, arena_allocator)
	// B. Figure out ways to not use dynamic arrays, instead allocate fixed-size slices of a reasonable size
	// Don't use an arena for your dynamic array, just ust the default allocator instead
}
