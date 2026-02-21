package start_thread

import "core:thread"

Worker_Thread_Data :: struct {
	// run is optional, it's useful if your
	// thread needs to run in a loop until
	// you tell it to stop. IF the thread
	// just needs to do a task and then
	// stop, then you can skip this bool
	// and the code that uses it.
	run:    bool,

	// Add data your thread needs here.
	thread: ^thread.Thread,
}

worker_thread_proc :: proc(t: ^thread.Thread) {
	d := (^Worker_Thread_Data)(t.data)
	for d.run {
		// Let your thread do stuff!

		// You can make this thread run a
		// little slower using a sleep:
		// time.sleep(10*time.Millissecond)
		// (needs `core:time`)
	}
}

start_worker_thread :: proc(d: ^Worker_Thread_Data) {
	d.run = true
	if d.thread = thread.create(worker_thread_proc); d.thread != nil {
		d.thread.init_context = context
		d.thread.data = rawptr(d)
		thread.start(d.thread)
	}
}

stop_worker_thread :: proc(d: ^Worker_Thread_Data) {
	d.run = false
	thread.join(d.thread)
	thread.destroy(d.thread)
}

main :: proc() {

}
