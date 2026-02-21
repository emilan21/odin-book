package linear_algebra

import "core:fmt"
import "core:math/linalg"

Vector3 :: [3]f32

main :: proc() {
	v := Vector3{2, 3, 5}
	v_length := linalg.length(v)
	v_normalized := linalg.normalize0(v)
	fmt.println(v_length)
	fmt.println(v_normalized)
}
