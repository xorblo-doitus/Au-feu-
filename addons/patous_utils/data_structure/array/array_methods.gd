class_name ArrayMethods
extends Object


## A set of methods wich help with [Array].



## Like [method Dictionary.get], but for [Array].
static func get_with_default(array: Array, index: int, default = null):
	if is_index_valid(array, index):
		return array[index]
	return default


## Return true if the [param index] is not out of [param array]'s range.
static func is_index_valid(array: Array, index: int) -> bool:
	return index < array.size() and index >= array.size() * -1