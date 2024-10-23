library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
entity next_address_board is
port(rt_in, rs_in : in std_logic_vector(1 downto 0);
 pc_in : in std_logic_vector(2 downto 0);
 target_address_in : in std_logic_vector(2 downto 0);
 branch_type : in std_logic_vector(1 downto 0);
 pc_sel : in std_logic_vector(1 downto 0);
 next_pc_out : out std_logic_vector(2 downto 0));
end next_address_board ;

architecture arch_board of next_address_board is
signal pc_sig: std_logic_vector(31 downto 0);

--board wrapper
signal rt, rs, pc, next_pc: std_logic_vector(31 downto 0);
signal target_address: std_logic_vector(25 downto 0); 
begin
--board wrapper
rt<= ( (31 downto 2=> rt(1)) & rt_in(1 downto 0));
rs<= ( (31 downto 2=> rs(1)) & rs_in(1 downto 0));
pc<= ( (31 downto 3=>'0') & pc_in(2 downto 0));
--next_pc<= (others=>'0');

target_address<= ( (25 downto 3=>'0') & target_address_in(2 downto 0));

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
--next_pc_out<=next_pc(2 downto 0);

--beq
when "01"=>


if(rs =rt) then
pc_sig<= pc+1+((31 downto 16=>target_address(15)) & target_address(15 downto 0));
next_pc<=pc_sig;
--next_pc_out<=next_pc(2 downto 0);

else 
pc_sig<=pc+1;
next_pc<=pc_sig;
--next_pc_out<=next_pc(2 downto 0);

end if;

--bne
when "10"=>


if(rs /=rt) then
pc_sig<= pc+1+((31 downto 16=>target_address(15)) & target_address(15 downto 0));
next_pc<=pc_sig;
--next_pc_out<=next_pc(2 downto 0);

else 
pc_sig<=pc+1;
next_pc<=pc_sig;
--next_pc_out<=next_pc(2 downto 0);
end if;

--bltz
when "11"=>


if(rs <0) then
pc_sig<= pc+1+((31 downto 16=>target_address(15)) & target_address(15 downto 0));
next_pc<=pc_sig;
--next_pc_out<=next_pc(2 downto 0);

else 
pc_sig<=pc+1;
next_pc<=pc_sig;
--next_pc_out<=next_pc(2 downto 0);
end if;
when others=>
end case;

--jump
when "01"=>
next_pc<= "000000" & target_address(25 downto 0);
--next_pc_out<=next_pc(2 downto 0);

--jump register
when "10"=>
next_pc<=rs;
--next_pc_out<=next_pc(2 downto 0);

--not used
when "11"=> 


when others=>
end case;


--next_pc_out<=next_pc(2 downto 0);
end process;

next_pc_out<=next_pc(2 downto 0);

end arch_board;

