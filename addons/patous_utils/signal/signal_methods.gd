extends Node
class_name SignalMethods


## Utilities for [Signal]s


## Disconnect only if already connected.
func soft_disconnect(signal_: Signal, callable: Callable) -> bool:
	if signal_.is_connected(callable):
		signal_.disconnect(callable)
		return true
	
	return false
