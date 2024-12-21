library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity sign is
port( in_immi: in std_logic_vector(15 downto 0);
	func: in std_logic_vector(1 downto 0);
      	out_immi: out std_logic_vector(31 downto 0));
end sign;

architecture sign_arch of sign is



begin
process(in_immi,func)
begin
case func is

when "00"=>
out_immi<= in_immi & (15 downto 0=>'0');

when "01"=>
out_immi<= (31 downto 16 => in_immi(15)) & in_immi;

when "10"=>
out_immi<= (31 downto 16 => in_immi(15)) & in_immi;

when "11"=>
out_immi<=  (31 downto 16=>'0') & in_immi;

when others=>
end case;
end process;


end sign_arch;
