
#### "Work" pointers

Work pointers are a term used to describe a pointer that the code actually works with. We often use work pointers because we should always have a pointer that is referencing the initial `malloc`ed address. We do this because of the implementation of the [[Malloc#`free`()|free()]] function.