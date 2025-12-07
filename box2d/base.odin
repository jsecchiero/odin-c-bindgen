// SPDX-FileCopyrightText: 2023 Erin Catto
// SPDX-License-Identifier: MIT
package box2d

foreign import lib "box2d.lib"
_ :: lib

/// Prototype for user allocation function
/// @param size the allocation size in bytes
/// @param alignment the required alignment, guaranteed to be a power of 2
Alloc_Fcn :: proc "c" (size: u32, alignment: i32) -> rawptr

/// Prototype for user free function
/// @param mem the memory previously allocated through `b2AllocFcn`
Free_Fcn :: proc "c" (mem: rawptr)

/// Prototype for the user assert callback. Return 0 to skip the debugger break.
Assert_Fcn :: proc "c" (condition: cstring, fileName: cstring, lineNumber: i32) -> i32

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// This allows the user to override the allocation functions. These should be
	/// set during application startup.
	@(link_name="b2SetAllocator")
	set_allocator :: proc(allocFcn: Alloc_Fcn, freeFcn: Free_Fcn) ---

	/// @return the total bytes allocated by Box2D
	@(link_name="b2GetByteCount")
	get_byte_count :: proc() -> i32 ---

	/// Override the default assert callback
	/// @param assertFcn a non-null assert callback
	@(link_name="b2SetAssertFcn")
	set_assert_fcn      :: proc(assertFcn: Assert_Fcn) ---
	@(link_name="b2InternalAssertFcn")
	internal_assert_fcn :: proc(condition: cstring, fileName: cstring, lineNumber: i32) -> i32 ---
}

/// Version numbering scheme.
/// See https://semver.org/
Version :: struct {
	/// Significant changes
	major: i32,

	/// Incremental changes
	minor: i32,

	/// Bug fixes
	revision: i32,
}

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Get the current version of Box2D
	@(link_name="b2GetVersion")
	get_version :: proc() -> Version ---

	/// Get the absolute number of system ticks. The value is platform specific.
	@(link_name="b2GetTicks")
	get_ticks :: proc() -> u64 ---

	/// Get the milliseconds passed from an initial tick value.
	@(link_name="b2GetMilliseconds")
	get_milliseconds :: proc(ticks: u64) -> f32 ---

	/// Get the milliseconds passed from an initial tick value.
	@(link_name="b2GetMillisecondsAndReset")
	get_milliseconds_and_reset :: proc(ticks: ^u64) -> f32 ---

	/// Yield to be used in a busy loop.
	@(link_name="b2Yield")
	yield :: proc() ---
}

/// Simple djb2 hash function for determinism testing
HASH_INIT :: 5381

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	@(link_name="b2Hash")
	hash :: proc(hash: u32, data: ^u8, count: i32) -> u32 ---
}

