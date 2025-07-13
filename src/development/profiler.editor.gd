class_name Profiler
extends RefCounted


## Allow easy code execution time test
## 
## [b]Note:[/b] This should be excluded from exports as it is useless outside
## of development.
## 
## [b]Warning:[/b] This class is mean't to be referenced temporarly only,
## remove references to it before exporting your project, as it should be
## excluded from the export, and thus raise an error when trying to use it.


static var global_start_usec: int
static var last_stamp_usec: int


## Strat timing code execution duration
static func start() -> void:
	global_start_usec = Time.get_ticks_usec()
	last_stamp_usec = global_start_usec


## Get elapsed time in microseconds since last [method start] call.
static func get_elapsed_usec() -> int:
	return Time.get_ticks_usec() - global_start_usec


## Get elapsed time in milliseconds since last [method start] call.
static func get_elapsed_msec() -> float:
	return get_elapsed_usec() / 1000.0
	

## Shorthand for [method stamp_usec]
static func stamp(name: String = "unnamed stamp") -> void:
	stamp_usec(name)


## Print [method get_elapsed_usec] with given [param name] prefixed.
## [codeblock]
## print_usec("descriptive name of profiled code")
## >>> descriptive name of profiled code: 1235 μs
## [/codeblock]
static func stamp_usec(name: String = "unnamed stamp") -> void:
	print(
		name,
		": %9d μs" % (Time.get_ticks_usec() - last_stamp_usec),
		"\t(total: %9d μs)" % get_elapsed_usec()
	)
	last_stamp_usec = Time.get_ticks_usec()


## Print [method get_elapsed_msec] with given [param name] prefixed.
## [codeblock]
## print_msec("descriptive name of profiled code")
## >>> descriptive name of profiled code: 1.235 ms
## [/codeblock]
static func stamp_msec(name: String = "unnamed stamp") -> void:
	print(
		name,
		": %9.3f ms" % ((Time.get_ticks_usec() - last_stamp_usec) / 1000.0),
		"\t(total: %9.3f ms)" % get_elapsed_msec()
	)
	last_stamp_usec = Time.get_ticks_usec()
