library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity next_address is
port(rt, rs : in std_logic_vector(31 downto 0);
 -- two register inputs
 pc : in std_logic_vector(31 downto 0);
 target_address : in std_logic_vector(25 downto 0);
 branch_type : in std_logic_vector(1 downto 0);
 pc_sel : in std_logic_vector(1 downto 0);
 next_pc : out std_logic_vector(31 downto 0));
end next_address ;

architecture arch of next_address is
signal pc_sig: std_logic_vector(31 downto 0);

begin

process(rt,rs,pc,target_address,branch_type,pc_sel,pc_sig)
begin
case pc_sel is
--no unconditional jump
when "00"=>

case branch_type is
--no branch
when "00"=>
pc_sig<=pc+1;
next_pc<=pc_sig;

--beq
when "01"=>


if(rs =rt) then
pc_sig<= pc+1+((31 downto 16=>target_address(15)) & target_address(15 downto 0));
next_pc<=pc_sig;

else 
pc_sig<=pc+1;
next_pc<=pc_sig;
end if;

--bne
when "10"=>


if(rs /=rt) then
pc_sig<= pc+1+((31 downto 16=>target_address(15)) & target_address(15 downto 0));
next_pc<=pc_sig;

else 
pc_sig<=pc+1;
next_pc<=pc_sig;
end if;

--bltz
when "11"=>


if(rs < 0) then
pc_sig<= pc+1+((31 downto 16=>target_address(15)) & target_address(15 downto 0));
next_pc<=pc_sig;

else 
pc_sig<=pc+1;
next_pc<=pc_sig;
end if;
when others=>
end case;

--jump
when "01"=>
next_pc<= "000000" & target_address(25 downto 0);

--jump register
when "10"=>
next_pc<=rs;

--not used
when "11"=> 


when others=>
end case;

end process;

end arch;
