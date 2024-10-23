# do file to test the regfile

add wave reset
add wave clk
add wave din
add wave write
add wave read_a
add wave read_b
add wave write_address
add wave R
add wave out_a
add wave out_b

# reset

force reset 1
force clk 0
force din X"10001000"
force write 0
force write_address "00101"
force read_a "00101"
force read_b "01111"
run 2

force reset 0
run 2

#test read_a
force write 1
force clk 1
run 2

force clk 0
run 2

# test read_b
force write_address 01111
force clk 1
run 2

force clk 0
run 2

#test other value
force din X"FAFA3B3B"
force clk 1
run 2

force clk 0
