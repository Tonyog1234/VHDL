library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity d_cache is
 
port(reset: in std_logic;
clk : in std_logic;
addr: in std_logic_vector( 4 downto 0);
rt_reg: in std_logic_vector(31 downto 0);
data_write: in std_logic;
d_out: out std_logic_vector(31 downto 0));

end d_cache;

architecture arch_d_cache of d_cache is
type cache_reg is array(0 to 31)of std_logic_vector(31 downto 0);
signal Reg:cache_reg;

begin
process(reset,clk,addr,rt_reg,data_write)
begin

if(reset='1')then
for i in 0 to 31 loop
Reg(i)<= (others=>'0');
end loop;

elsif(clk' event and clk = '1') then
if(data_write='1') then
Reg(conv_integer(addr))<=rt_reg;

end if;
end if;
end process;
d_out<=Reg(conv_integer(addr));

end arch_d_cache;
