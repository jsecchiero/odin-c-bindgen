// SPDX-FileCopyrightText: 2023 Erin Catto
// SPDX-License-Identifier: MIT
package box2d

foreign import lib "box2d.lib"
_ :: lib

/// World id references a world instance. This should be treated as an opaque handle.
World_Id :: struct {
	index1:     u16,
	generation: u16,
}

/// Body id references a body instance. This should be treated as an opaque handle.
Body_Id :: struct {
	index1:     i32,
	world0:     u16,
	generation: u16,
}

/// Shape id references a shape instance. This should be treated as an opaque handle.
Shape_Id :: struct {
	index1:     i32,
	world0:     u16,
	generation: u16,
}

/// Chain id references a chain instances. This should be treated as an opaque handle.
Chain_Id :: struct {
	index1:     i32,
	world0:     u16,
	generation: u16,
}

/// Joint id references a joint instance. This should be treated as an opaque handle.
Joint_Id :: struct {
	index1:     i32,
	world0:     u16,
	generation: u16,
}

