# Simulator vs Device

Currently there is a slight difference in the way `MTLDepthStencilState` pointers are allocated
from calling the `makeDepthStencilState` function on the current device.

This simple project attempts to clearly show this difference by creating a million `MTLDepthStencilState` objects in a frame and if the pointer to the previous depth stencil state
object is the same as the new one we increment the `t` variable, and we increment the `f` variable otherwise. At the end of the million iterations we print out the numbers and there is a difference
between what happens if you run this on the simulator vs the device.

## Simulator

Running this on the simulator we get that every single one of the million allocations
doesn't match the previous pointer.

Example Output
```
t 0 f 1000000
t 0 f 1000000
t 0 f 1000000
t 0 f 1000000
t 0 f 1000000
t 0 f 1000000
t 0 f 1000000
t 0 f 1000000
t 0 f 1000000
```

## Device

Running this on the device we get that a large portion of the million allocations 
uses a pointer that matches the previous pointer.

Example Output
```
t 991626 f 8374
t 796872 f 203128
t 764462 f 235538
t 735596 f 264404
t 976502 f 23498
t 597882 f 402118
```

Example output after retaining the depth stencil state object in a dictionary within a single draw
```
t 999999 f 1
t 999999 f 1
t 999999 f 1
t 999999 f 1
t 999999 f 1
t 999999 f 1
t 999999 f 1
t 999999 f 1
t 999999 f 1
```
