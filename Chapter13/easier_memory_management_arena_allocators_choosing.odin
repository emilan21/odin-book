package easier_memory_management_arena_allocators_choosing

import "core:fmt"
import "core:mem"
import vmem "core:mem/virtual"
import "core:strings"

main :: proc() {
	// Odin comes with 3 different arena allocators
	// One in core:mem/virtual - use this one in 99% of cases
	// One in core:mem - use if the system doesn't support virtual memory
	// One in base:runtime - don't use

	// Three arena kinds as well
	// 1. Growing = 0 - default. Chained memory blocks
	// 2. Static = 1 - Fixed reservation sized
	// 3. Buffer = 2 - Uses a fixed sized buffer

	// Growing examples
	// These are the same
	// We are just explictly calling the init_growing for a growing allocator
	// NOTE: We are checking if there was an error and asserting on it if there is
	// to crash the program
	// NOTE: As this is virutal memory the memory allocations can happen in two steps:
	// 1. First you can reserve memory, which just tells the operating system that
	// you want X bytes of continuous virtual memory. No physical memory is used at this step
	// so memory usage on the system will not got up.
	// 2. Next the memory is commited already reserved memory that is then physically allocated
	// in small chunks
	// by default 1 megabyte is reserve per block but if need it will reserve more
	arena: vmem.Arena
	arena_allocator := vmem.arena_allocator(&arena)
	vmem.arena_destroy(&arena)

	arena_2: vmem.Arena
	err := vmem.arena_init_growing(&arena_2)
	assert(err == .None)
	arena_allocator_2 := vmem.arena_allocator(&arena_2)
	vmem.arena_destroy(&arena_2)

	// There is an optional second parameter of arena_init_growing that can be used to pre-reserve the arena with an inital
	// block of that size
	arena_3: vmem.Arena
	err_2 := vmem.arena_init_growing(&arena_3, 100 * mem.Megabyte)
	assert(err == .None)
	arena_allocator_3 := vmem.arena_allocator(&arena_3)
	vmem.arena_destroy(&arena_3)

	// Static examples
	// uses virtual memory, in the sense that it reserves a block of virtual memory and then commits parts of it as you do your allocations.
	// However, this static arena will never reserve new blocks. The block size you tell it to use at the start will be all the memory
	// it has availabe.
	// Some people use this to reserve all the memory the program needs at the start and then set the context.allocator to the arena which means
	// all allocations will happen within the arena
	arena_5: vmem.Arena
	err_3 := vmem.arena_init_static(&arena_5, 1 * mem.Gigabyte) // 1 Gigabyte block
	assert(err_3 == .None)
	arena_allocator_4 := vmem.arena_allocator(&arena_5)
	vmem.arena_destroy(&arena_5)

	// Fixed buffer examples
	// Simliar to static as it is a fixed size arena but instead you can feed it any block of memory buffer you hav laying around
	// Using make for the buffer here but could put it on the stack
	arena_5: vmem.Arena
	buf := make([]byte, 10 * mem.Megabyte)
	err_4 := vmem.arena_init_buffer(&arena_5, buf[:]) // 10 megabyte block
	assert(err_4 == .None)
	arena_allocator_5 := vmem.arena_allocator(&arena_5)
	delete(buf)
}
