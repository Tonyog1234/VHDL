add wave x
add wave y
add wave add_sub
add wave func 
add wave logic_func

add wave zero
add wave output
add wave overflow

force x 00000000000000000000000000000001
force y 00000000000000000000000000000001
force add_sub 1
force func 10
force logic_func 00
run 4
run 4

force add_sub 0
run 4
run 4

force func 00
run 4
run 4

force func 01
run 4
run 4

force func 11
force x 00000000000000000000000000000010
run 4
run 4

force logic_func 01
run 4
run 4

force logic_func 10
run 4
run 4

force logic_func 11
run 4
run 4



