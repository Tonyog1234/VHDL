library ieee;
use ieee.std_logic_1164.all;

entity sum_of_minterms is
	port( a,b,c : in std_logic;
		output : out std_logic);
end sum_of_minterms;

architecture result of sum_of_minterms is
component and_gate
	port( in_1,in_2, in_3: in std_logic;
		output : out std_logic);
end component;

component or_gate
	port( in_1,in_2, in_3: in std_logic;
		output : out std_logic);
end component;

signal s1,s2,s3 : std_logic;
signal not_a, not_b : std_logic;

for and_1,and_2,and_3: and_gate use entity WORK.and_gate(AND_gate);
for or_1: or_gate use entity WORK.or_gate(OR_gate);

begin
not_a<= not a;
not_b<= not b;

and_1: and_gate port map(in_1=>not_a, in_2=> not_b, in_3=> c, output=>s1);
and_2: and_gate port map(in_1=>not_a, in_2=>  b, in_3=> c, output=>s2);
and_3: and_gate port map(in_1=> a, in_2=>  b, in_3=> c, output=>s3);

or_1: or_gate port map(in_1=> s1, in_2=>s2, in_3=>s3, output=>output);


end result;
