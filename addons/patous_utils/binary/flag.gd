class_name Flag
extends Object


## A static class to help handling flags.


## Create the flag with the bit n°[param index] enabled.
static func from_index(index: int) -> int:
	return 1 << index


## Return wich index this flag is.
static func to_index(flag: int) -> int:
	return round(log(flag) / 0.693147) # Log2


## Return whether or not the [param flag] of [param mask] is enabled.
static func is_flag_enabled(mask: int, flag: int) -> int:
	return mask & flag != 0


## Return whether or not the [param flag] of [param mask] is disabled.
static func is_flag_disabled(mask: int, flag: int) -> int:
	return mask & flag == 0


## Enable the [param flag] of [param mask].
static func flag_enabled(mask: int, flag: int) -> int:
	return mask | flag


## Disable the [param flag] of [param mask].
static func flag_disabled(mask: int, flag: int) -> int:
	return mask & ~flag
