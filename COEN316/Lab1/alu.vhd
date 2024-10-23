library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity alu is

port(x, y : in std_logic_vector(31 downto 0);

 -- two input operands
 add_sub : in std_logic ; -- 0 = add , 1 = sub

 logic_func : in std_logic_vector(1 downto 0 ) ;
 -- 00 = AND, 01 = OR , 10 = XOR , 11 = NOR

 func : in std_logic_vector(1 downto 0 ) ;
 -- 00 = lui, 01 = setless , 10 = arith , 11 = logic

 output : out std_logic_vector(31 downto 0) ;
 overflow : out std_logic ;
 zero : out std_logic);
end alu ;

architecture lab1 of alu is

--internal signal
signal add_sub_result, logic_result:  std_logic_vector(31 downto 0);
signal over_check: std_logic_vector(2 downto 0);



begin



process(x ,y ,add_sub ,logic_func ,func, add_sub_result, logic_result,over_check)
begin
--overflow check
over_check<= x(31)&y(31)&add_sub_result(31);

--adder_subtract
case add_sub is

when '0'=> add_sub_result <= x+y;
if((over_check= "001") or (over_check="110")) then -- two pos get neg result, two neg get pos result
overflow<='1';	

else 
overflow<='0';	
end if;

when '1'=> add_sub_result <= x-y;
if((over_check= "011") or (over_check="100")) then -- one pos sub one neg, one neg sub one pos
overflow<='1';	

else 
overflow<='0';	
end if;

when others=>   
end case;

--logic unit
case logic_func is
when "00"=>logic_result<=x and y;
when "01"=>logic_result<=x or y;
when "10"=>logic_result<=x xor y;
when "11"=>logic_result<=x nor y;
when others=>
end case;

--func
case func is
when "00"=>output<=y;
when "01"=>output<="0000000000000000000000000000000"&add_sub_result(31);
when "10"=>output<=add_sub_result;
when "11"=>output<=logic_result;
when others=>
end case;

--zero
if(add_sub_result=(add_sub_result'range =>'0')) then
zero<='1';
else
zero<='0';
end if;
end process;

end lab1;


