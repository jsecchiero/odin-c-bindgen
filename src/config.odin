package bindgen2

// This is populated from a `bindgen.sjson` file
Config :: struct {
	// Inputs can be folders or files. If you provide a folder name, then the generator will look for
	// header (.h) files inside it. The bindings will be based on those headers. For each header,
	// you can create a `header_footer.odin` file with some additional code to append to the finished
	// bindings. If the header is called `raylib.h` then the footer would be `raylib_footer.odin`.
	inputs: []string,

	// Output folder. In there you'll find one .odin file per processed header.
	output_folder: string,

	// Remove this prefix from types names (structs, enums, etc)
	remove_type_prefix: string,

	// Remove this prefix from macro names
	remove_macro_prefix: string,

	// Remove this prefix from function names (and add it as link_prefix) to the foreign group
	remove_function_prefix: string,

	// Remove this suffix from type names (structs, enum, etc)
	remove_type_suffix: string,
	
	// Set to true to translate type names to Ada_Case (default: true)
	force_ada_case_types: Maybe(bool),

	// Set to true to translate enum member names to Ada_Case (default: true)
	force_ada_case_enum_members: Maybe(bool),

	// Set to true to translate procedure names to snake_case (default: true)
	force_snake_case_procedures: Maybe(bool),

	// Set to true to translate procedure parameter names to snake_case (default: true)
	force_snake_case_parameters: Maybe(bool),

	// Set to true to translate macro/constant names to SCREAMING_SNAKE_CASE (default: true)
	force_screaming_snake_case_constants: Maybe(bool),

	// Single lib file to import. Will be ignored if `imports_file` is set.
	import_lib: string,

	// The filename of a file that contains the foreign import declarations. In it you can do
	// platform-specific library imports etc. The contents of it will  be placed near the top of the
	// file.
	imports_file: string,

	// `package something` to put at top of each generated Odin binding file.
	package_name: string,
	
	// "Old_Name" = "New_Name"
	rename: map[string]string,

	// Override the mapping of C primitive types to Odin types.
	// Keys are C type names (e.g. "int", "unsigned int", "short").
	// Values are Odin type expressions (e.g. "c.int", "i32").
	// If the value starts with "c.", "libc.", or "posix.", the appropriate
	// import will be added automatically.
	primitive_type_overrides: map[string]string,

	// Turns an enum into a bit_set. Converts the values of the enum into appropriate values for a
	// bit_set (translates the enum values using a log2 procedure).
	//
	// Note that the enum will be turned into a bit_set type. There will be a new type created that
	// contains the actual enum, which the bit_set then references.
	bit_setify: map[string]string,

	// Completely override the definition of a type.
	type_overrides: map[string]string,

	// Override the type of a struct field.
	// 
	// You can also use `[^]` to augment an already existing type.
	struct_field_overrides: map[string]string,

	// Put these tags on the specified struct field
	struct_field_tags: map[string]string,

	// Add directives to struct definitions (e.g. #align, #packed).
	// Use the struct name as key and the directive as value.
	// Example: "Model" = "#align(align_of(uintptr))"
	struct_directives: map[string]string,

	// Remove a specific enum member. Write the C name of the member. You can also use wildcards
	// such as *_Count
	remove_enum_members: []string,

	// Enums automatically have any prefix that is sharred by all members removed. This sometimes
	// misbehaves for certain names. Use this setting to manually set the perfix to remove for a
	// certain enum type.
	remove_enum_member_prefix: map[string]string,

	// Overrides the type of a procedure parameter or return value. For a parameter use the key
	// Proc_Name.parameter_name. For a return value use the key Proc_Name.
	//
	// You can also use `[^]`, `#by_ptr` and `#any_int` to augment an already existing type.
	procedure_type_overrides: map[string]string,

	// Add in a default value to a procedure parameter. Use `Proc_Name.parameter_name` as key and
	// write the plain-text Odin value as value.
	//
	// You can also add defaults for proc parameters within structs. In that case you do:
	// `Struct_Name.proc_field.parameter_name` -- This does not currently support nested structs.
	procedure_parameter_defaults: map[string]string,

	// Put the names of declarations in here to remove them.	
	remove: []string,

	// Group all procedures at the end of the file.
	procedures_at_end: bool,
	
	// Additional include paths to send into clang. While generating the bindings clang will look into
	// this path in search for included headers.
	clang_include_paths: []string,

	// Force-include these files before processing each header. Useful when a header depends on types
	// from another header but doesn't include it directly.
	clang_force_includes: []string,

	clang_defines: map[string]string,
}
