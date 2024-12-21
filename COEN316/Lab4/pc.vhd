library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity pc is
 
port(reset: in std_logic;
clk : in std_logic;
din: in std_logic_vector(31 downto 0);

out_next: out std_logic_vector(31 downto 0));

end pc;

architecture arch_pc of pc is



begin 
--clock
process(reset, clk, din)
begin
if(reset ='1') then 
out_next<=(others=>'0');


elsif(clk' event and clk = '1') then
out_next<=din;


end if;
end process;


end arch_pc;
