add wave *

force reset 1
force clk 0
force din 0001
force sel 00
run 2

force reset 0
run 1

force clk 1
run 2
force clk 0
run 2

force din 1000
force clk 1

run 2 

force clk 0
run 2

force din 0010
force clk 1
force ld_max 1
force ld_min 1
run 2 

force clk 0
force sel 00
run 2

force din 1001
force clk 1

run 2 

force clk 0
force sel 01
run 2

force din 0011
force clk 1

run 2 

force clk 0
run 2

force din 1010
force clk 1

run 2 

force clk 0
run 2

force din 1111
force clk 1

run 2 

force clk 0
force sel 11
run 2



