
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity converter is
port( sign_mag : in std_logic_vector(3 downto 0) ;
	twos_comp : out std_logic_vector(3 downto 0) );
end converter;

architecture arch of converter is

signal negated, twos: std_logic_vector(2 downto 0);
--signal result: std_logic_vector(3 downto 0);
begin
	


	process(sign_mag, twos, negated)
	
	
	begin
	negated<= not sign_mag( 2 downto 0);
	twos<= negated + 001;

		if(sign_mag(3)='0') then
			twos_comp<=sign_mag;

		elsif(sign_mag(3)='1') then
			twos_comp<=sign_mag(3) & twos;
			--result<=sign_mag(3) & twos;
			--twos_comp<=result;		
		end if;
	end process;

	
end arch;
