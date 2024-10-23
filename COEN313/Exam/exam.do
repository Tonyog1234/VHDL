add wave keith
add wave reset
add wave clk
add wave ld
add wave toggle
add wave size 
add wave keith_out

force keith 11111111
force reset 1
force clk 1
force ld 0
force toggle 0
force size 00
run 2

force reset 0
force clk 0
run 2

force clk 1
run 2

force clk 0
force ld 1
run 2

force clk 1
force ld 0
run 2

force clk 0
force toggle 1
run 2

force clk 1
run 2

force clk 0
force size 01
run 2

force clk 1
run 2

force clk 0
force size 10
run 2

force clk 1
run 2

force clk 0
force size 11
run 2

force clk 1
run 2

force clk 0 
run 2




