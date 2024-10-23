library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity registers_min_max1 is
port( 	din: in std_logic_vector(3 downto 0);
	reset : in std_logic;
	clk: in std_logic;
	sel: in std_logic_vector(1 downto 0);
	max_out : out std_logic_vector(3 downto 0);
	min_out : out std_logic_vector(3 downto 0);
	reg_out : out std_logic_vector(3 downto 0));
end registers_min_max1 ;

architecture registers_min_max_arch1 of registers_min_max1 is
signal r0,r1,r2,r3: std_logic_vector(3 downto 0);
signal temp_max, temp_min, max_reg, min_reg: std_logic_vector(3 downto 0);

begin
	process (clk, reset)
	begin
		if (reset = '1') then 	
			r0 <= "1000";
			r1 <= "1000";
			r2 <= "1000";
			r3 <= "1000";
		elsif (clk' event and clk = '1') then
			r0 <= din;
			r1 <= r0;
			r2 <= r1;
			r3 <= r2;
		end if;
	end process;

	process (sel, r0, r1, r2, r3)
	begin
		if (sel = "00") then reg_out <= r0;
		elsif (sel = "01") then reg_out <= r1;
		elsif (sel = "10") then reg_out <= r2;
		elsif (sel = "11") then reg_out <= r3;
		end if;
	end process;

	process (r0, r1, r2, r3)
	begin
		if (r0 > r1 and r0 > r2 and r0 > r3) then temp_max <= r0;
		elsif (r1 > r2 and r1 > r3) then temp_max <= r1;
		elsif (r2 > r3) then temp_max <= r2;
		else temp_max <= r3;
		end if;

		if (r0 < r1 and r0 < r2 and r0 < r3) then temp_min <= r0;
		elsif (r1 < r2 and r1 < r3) then temp_min <= r1;
		elsif (r2 < r3) then temp_min <= r2;
		else temp_min <= r3;
		end if;
	end process;

	process (clk, reset)
	begin
		if (reset = '1') then 	
			max_reg <= "0000";
			min_reg <= "1111";
		
		elsif (clk' event and clk = '1') then
			if (temp_max > max_reg) then max_reg <= temp_max;
			end if;
			if (temp_min < min_reg) then min_reg <= temp_min;
			end if;
		end if;
	end process;

max_out <= max_reg;
min_out <= min_reg;


end registers_min_max_arch1;
