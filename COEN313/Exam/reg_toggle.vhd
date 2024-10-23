--Name:Ming-Hung Kao
--ID: 40255597
--section : AI-X
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity  reg_toggle   is
port(
	keith: in std_logic_vector( 7 downto 0);
	reset: in std_logic ;
	clk: in std_logic;
	ld, toggle: in std_logic;
	size: in std_logic_vector(1 downto 0);
	keith_out: out std_logic_vector( 7 downto 0));
end reg_toggle;


architecture  rtl  of  reg_toggle  is
signal r_reg,r_next : std_logic_vector(7 downto 0);

--signal tmp_next:  std_logic_vector(7 downto 0);


begin
--register
process(clk, reset)
begin
if(reset='1') then
r_reg<=(others=>'0');


elsif(clk' event and clk='1') then
r_reg<=r_next;

end if;
end process;

--next state logic
process(ld, toggle, size,keith, r_reg)
variable tog: std_logic_vector(7 downto 0);


begin
tog:= not r_reg;

if(ld='1')then
r_next<=keith;
--if(toggle='1') then
--if(size="00") then
--r_next<= tmp 

--end if;
--end if;



elsif(ld='0') then
r_next<=r_reg;

if(toggle='1') then
if(size="00") then

r_next<= r_reg(7 downto 2) & tog(1 downto 0);

elsif(size="01") then
r_next<= r_reg(7 downto 4) & tog(3 downto 0);

elsif(size="10") then
r_next<= r_reg(7 downto 6) & tog(5 downto 0);

elsif(size="11")then
r_next<=tog;

end if;
end if;
end if;

end process; 


--output 
keith_out<=r_reg;
end  rtl;

