

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity converter_var is
port( sign_mag : in std_logic_vector(3 downto 0) ;
	twos_comp : out std_logic_vector(3 downto 0) );
end converter_var;

architecture arch of converter_var is
begin
	process(sign_mag)
	variable var: std_logic_vector(2 downto 0);
	begin
		var :=not sign_mag(2 downto 0);
		var := var+001;
		if(sign_mag(3)='0') then
			twos_comp<=sign_mag;

		elsif(sign_mag(3)='1') then
			twos_comp<= sign_mag(3) & var;
			
							
		end if;
	end process;


end arch;
