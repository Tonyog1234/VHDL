library ieee;
use ieee.std_logic_1164.all;

entity or_gate is
	port( in_1,in_2, in_3: in std_logic;
	output: out std_logic);
end or_gate;


architecture OR_gate of or_gate is
begin
	output<=in_1 or in_2 or in_3;
end OR_gate;
