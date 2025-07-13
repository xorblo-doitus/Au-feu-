class_name Bitwise
extends Object


## A static class to help handling binary.


## Return whether or not the [param index]'s bit of [param mask] is enabled.
static func is_bit_enabled(mask: int, index: int) -> int:
	return mask & (1 << index) != 0


## Return whether or not the [param index]-th bit of [param mask] is disabled.
static func is_bit_disabled(mask: int, index: int) -> int:
	return mask & (1 << index) == 0


## Enable the [param index]-th bit of [param mask].
static func bit_enabled(mask: int, index: int) -> int:
	return mask | (1 << index)


## Disable the [param index]-th bit of [param mask].
static func bit_disabled(mask: int, index: int) -> int:
	return mask & ~(1 << index)
