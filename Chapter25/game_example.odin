package game_example

// bindings for raylib, a library for creating video games,
// raylib can open windows, draw graphics, play sound, and process input
import rl "vendor:raylib"

// Write platform-independent rendering code using SOKOL
// SOKOL is a collection of cross-platform libraries for doig platform-independent
// real time rendering, window management and more. It can be used when you don't
// want to choose if you are going to use Bulkan, OpenGL, Metal or Direct3D. It provides
// an abstraction of those APIS
import sokol "ven"

// Rendering code using vulkan
// Vulkan is a library for writing low level rendering code. Very close the to c api
import vulkan "vendor:vulkan"

// 2D game physics using Box2D
// Box2D is a physics library for 2D games
import box "vendor:box2d"

// Example of opening a window and start a game loop that constantly
// clears the screen with a blue color
main :: proc() {
	rl.InitWindow(1280, 720, "Raylib Game")
	rl.SetTargetFPS(120)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLUE)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
