library ieee;
use ieee.std_logic_1164.all;

entity and_gate is
	port( in_1,in_2, in_3: in std_logic;
	output : out std_logic);
end and_gate;


architecture AND_gate of and_gate is
begin
 	output<= in_1 and in_2 and in_3;
end AND_gate;
