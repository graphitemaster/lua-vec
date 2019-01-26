# lua-vec

Table constructions in Lua are expensive, creating and destroying
thousands of "vector" tables frame to frame in an engine can cause
serious performance problems when Lua's GC is triggered; this is a
vector library that attempts to solve this problem by interning
construction and reusing references

It's not safe to modify a vector that may be referenced multiple times
so this library also implements reasonably efficent read-only data types
through the use of `__index` metamethods.

## performance

construction cost in the uncached case is ~2x more expensive but
the same in the cached case, the real winnings comes from not having a
destruction phase ever occur, e.g seeing 60% of GC frame to frame occur
because of one-off vector constructions go away is quite significant,
vector comparisons are ~20x faster since it's just object identity, i.e
pointer comparison in the VM.

## memory

performance is made up by interning so if you're not careful you can
run out of memory rather quickly, make smart decisions when to call
`clear_cache()` on each of the vector caches.
