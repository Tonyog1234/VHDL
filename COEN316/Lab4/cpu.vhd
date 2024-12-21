library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
entity cpu is
port(
reset : in std_logic;
clk : in std_logic;
rs_out, rt_out : out std_logic_vector(3 downto 0);
-- output ports from register file
pc_out : out std_logic_vector(3 downto 0); -- pc reg
overflow, zero : out std_logic
);
end cpu;

architecture arch_cpu of cpu is

--component pc
component pc_comp
port(
reset: in std_logic;
clk : in std_logic;
din: in std_logic_vector(31 downto 0):=(others=>'0');

out_next: out std_logic_vector(31 downto 0):=(others=>'0'));

end component;

--component i_cache
component i_cache
port( input_addr: in std_logic_vector(4 downto 0);
      	instr	: out std_logic_vector(31 downto 0));
end component;

--compenent next address
component next_address
port(rt, rs : in std_logic_vector(31 downto 0);
 -- two register inputs
 pc : in std_logic_vector(31 downto 0);
 target_address : in std_logic_vector(25 downto 0);
 branch_type : in std_logic_vector(1 downto 0);
 pc_sel : in std_logic_vector(1 downto 0);
 next_pc : out std_logic_vector(31 downto 0));

end component ;

--component register file
component regfile
port( din : in std_logic_vector(31 downto 0);
 reset : in std_logic;
 clk : in std_logic;
 write : in std_logic;
 read_a : in std_logic_vector(4 downto 0);
 read_b : in std_logic_vector(4 downto 0);
 write_address : in std_logic_vector(4 downto 0);
 out_a : out std_logic_vector(31 downto 0);
 out_b : out std_logic_vector(31 downto 0));
end component ;

--component sign extension
component sign
port( in_immi: in std_logic_vector(15 downto 0);
	func: in std_logic_vector(1 downto 0);
      	out_immi: out std_logic_vector(31 downto 0));
end component;

--component alu
component alu
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
end component ;

--component d_cache
component d_cache
port(reset: in std_logic;
clk : in std_logic;
addr: in std_logic_vector( 4 downto 0);
rt_reg: in std_logic_vector(31 downto 0);
data_write: in std_logic;
d_out: out std_logic_vector(31 downto 0));

end component;

-- declare configuration specification
for PC: pc_comp use entity WORK.pc(arch_pc);
for I_C: i_cache use entity WORK.i_cache(ic_arch);
for NextAddr: next_address use entity WORK.next_address(arch);
for R_F: regfile use entity WORK.regfile(structure);
for sign_ext: sign use entity WORK.sign(sign_arch);
for A: alu use entity WORK.alu(lab1);
for D_C: d_cache use entity WORK.d_cache(arch_d_cache);

--signal
signal pc_next, pc_in, ic_out, rs_in,rt_in,reg_in, out_sign,alu_sel,alu_out,d_o: 
		std_logic_vector(31 downto 0):=(others=>'0');

signal reg_write_address: std_logic_vector(4 downto 0):=(others=>'0');

signal branch_t, pc_choice,alu_func,alu_lf : std_logic_vector(1 downto 0):=(others=>'0');

signal reg_write,alu_adsb,dc_write, reg_dst, alu_src, reg_in_src:std_logic:='0';

--control unit signal
signal opcode, funct: std_logic_vector(5 downto 0):=(others=>'0');
signal control: std_logic_vector(13 downto 0);

begin
--control unit
process(opcode, funct, control, ic_out,clk,reset)
begin
opcode<= ic_out(31 downto 26);
funct<= ic_out(5 downto 0);

case opcode is
when "000000" =>
				   if (funct = "100000") then control <= "11100000100000"; -- add
				elsif (funct = "100010") then control <= "11101000100000"; -- sub
				elsif (funct = "101010") then control <= "11100000010000"; -- slt
				elsif (funct = "100100") then control <= "11101000110000"; -- and
				elsif (funct = "100101") then control <= "11100001110000"; -- or
				elsif (funct = "100110") then control <= "11100010110000"; -- xor
				elsif (funct = "100111") then control <= "11100011110000"; -- nor
				elsif (funct = "001000") then control <= "00000000000010"; -- jr
				else end if;
			when "000001" => control <= "00000000001100"; -- bltz
			when "000010" => control <= "00000000000001"; -- j
			when "000100" => control <= "00000000000100"; -- beq
			when "000101" => control <= "00000000001000"; -- bne
			when "001000" => control <= "10110000100000"; -- addi
			when "001010" => control <= "10110000010000"; -- slti
			when "001100" => control <= "10110000110000"; -- andi
			when "001101" => control <= "10110001110000"; -- ori
			when "001110" => control <= "10110010110000"; -- xori
			when "001111" => control <= "10110000000000"; -- lui
			when "100011" => control <= "10010010100000"; -- lw
			when "101011" => control <= "00010100100000"; -- sw
			when others =>
		end case;

	reg_write <= control(13);
		reg_dst	 <= control(12);
		reg_in_src <= control(11);
		alu_src <= control(10);
		alu_adsb <= control(9);
		dc_write <= control(8);
		alu_lf <= control(7 downto 6);
		alu_func <= control(5 downto 4);
		branch_t <= control(3 downto 2);
		pc_choice <= control(1 downto 0);
end process;
--component instantiation
PC: pc_comp port map(din=>pc_in, reset=>reset, clk=>clk, out_next=>pc_next);

I_C: i_cache port map(input_addr=>pc_next(4 downto 0), instr=>ic_out);

NextAddr: next_address port map(rt=>rt_in, rs=>rs_in, pc=>pc_next, target_address=>ic_out(25 downto 0),
				branch_type=>branch_t, pc_sel=>pc_choice, next_pc=> pc_in);

R_F: regfile port map(din=>reg_in, reset=>reset,clk=>clk, write=>reg_write, read_a=>ic_out(25 downto 21),
			read_b=>ic_out(20 downto 16), write_address=>reg_write_address, out_a=>rs_in,
			out_b=>rt_in);

sign_ext:sign port map(in_immi=>ic_out(15 downto 0), func=> alu_func, out_immi=>out_sign);--share alu_func with alu

A: alu port map(x=>rs_in, y=> alu_sel, add_sub=>alu_adsb, logic_func=>alu_lf, func=>alu_func,
		output=>alu_out, overflow=>overflow, zero=>zero);

D_C: d_cache port map(reset=>reset, clk=>clk, addr=>alu_out(4 downto 0), rt_reg=>rt_in, 
			data_write=>dc_write, d_out=>d_o);

--mux
reg_write_address<=ic_out(20 downto 16) when (reg_dst='0') else --rt
		   ic_out(15 downto 11) when (reg_dst='1');--rd

alu_sel<= rt_in when(alu_src = '0') else
	out_sign when(alu_src = '1');

reg_in<= d_o when (reg_in_src='0') else 
	alu_out when (reg_in_src='1');

--output
rs_out	<= (rs_in(3 downto 0));
rt_out	<= (rt_in(3 downto 0));
pc_out	<= (pc_next(3 downto 0));

end arch_cpu;
