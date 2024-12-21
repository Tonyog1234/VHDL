

add wave pc
add wave rs
add wave rt
add wave target_address
add wave pc_sel

add wave branch_type
add wave next_pc


force pc X"00000000"
force rt X"00001000"
force rs X"00001001"
force target_address "00000000000000000000000001"
force pc_sel 00
force branch_type 00
run 2

#beq fail
force pc X"00000001"
force branch_type 01
run 2

#beq work
force pc X"00000002"
force rs X"00001000"
force branch_type 01
run 2

#bne fail
force pc X"00000003"
force branch_type 10
run 2

#bne work
force pc X"00000004"
force rs X"00001001"
force branch_type 10
run 2

#bltz fail
force pc X"00000005"
force branch_type 11
run 2

#bltz work
force pc X"00000005"
force rs X"80001001"
force branch_type 11
run 2

#jump
force pc_sel 01
force target_address "10000110000001100001000001"
run 2

#jump register

force pc_sel 10
run 2





add wave pc
add wave rs
add wave rt
add wave target_address
add wave pc_sel

add wave branch_type
add wave next_pc


force pc X"00000000"
force rt X"00001000"
force rs X"00001001"
force target_address "00000000000000000000000001"
force pc_sel 00
force branch_type 00
run 2

#beq fail
force pc X"00000001"
force branch_type 01
run 2

#beq work
force pc X"00000002"
force rs X"00001000"
force branch_type 01
run 2

#bne fail
force pc X"00000003"
force branch_type 10
run 2

#bne work
force pc X"00000004"
force rs X"00001001"
force branch_type 10
run 2

#bltz fail
force pc X"00000005"
force branch_type 11
run 2

#bltz work
force pc X"00000005"
force rs X"80001001"
force branch_type 11
run 2

#jump
force pc_sel 01
force target_address "10000110000001100001000001"
run 2

#jump register

force pc_sel 10
run 2



