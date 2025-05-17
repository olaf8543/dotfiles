Malloc is very important in C because it allows you to allocate memory to store data inside of a function and allows you to access that data outside of the function as well
#### Orphaned Storage

You do **not** want orphaned storage. Orphaned storage is when an [[Arrays and Pointers|pointer]] 


#### `free`()

`free(pointer)` will work when given an initial address for which there is `malloc`ed space, and ***only that `malloc`ed address***. Using a pointer with allocated space should always have a [[Arrays and Pointers#"Work" pointers|work pointer]] in order to not have memory leaks.