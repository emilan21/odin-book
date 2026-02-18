# Data-oriented design

Odin is marketed as a "data-oriented language"

What does that mean? Data-oriented means writing code in such a way that the code can make efficient use of modern CPUs. A lot of data-oriented design revolves around writing code that is cache friendly. The goal is to keep the L1, L2, and L3 cache full in that order.

## Avoid doing many small heap allocations

look at example heap_allocations.odin
