library ieee;
use ieee.std_logic_1164.all;

entity controle is
port (reset, clk: in STD_LOGIC;
      start, XmenYflag, XigualYflag: in STD_LOGIC;
      loadX, loadY, loadS, clearS, clearX, clearY, selX, selY: OUT STD_LOGIC);
end controle;


architecture arq of controle is
	type InternalState is (S0,S1,S2,S3,S4,S5,S6); 	
	signal nextState, currentState: InternalState;
	
begin

	--nextState logic comb	
	NSL: process(currentState, XmenYflag, XigualYflag, start) is
	begin
		nextState <= currentState;
		case currentState is
			when S0 =>
				if start = '1' then
					nextState <= S1;
				else
					nextState <= S0;
				end if;
			when S1 => 
				nextState <= S2;
			when S2 =>
				if XigualYflag = '1' then
					nextState <= S6;
				else 
					nextState <= S3;
				end if;
			when S3 => 
				if XmenYflag = '1' then
				nextState <= S5;
				else 
				nextState <= S4;
				end if;
			when S4 =>
				nextState <= S2;
			when S5 => 
				nextState <= S2;
			when S6 =>
				nextState <= currentState;
		end case;
	end process;
	
	--memory element: apenas armazena,define o currentState
	ME: process(clk, reset) is
			begin
				if reset = '1' then
					currentState <= S0;
				elsif rising_edge(clk) then
					currentState <= nextState;
				end if;
			end process;
			
	--output logic comb
	loadX <= '1' when currentState = S4 or currentState = S1 else '0';
	loadY <= '1' when currentState = S1 or currentState = S5 else '0';
	loadS <= '1' when currentState = S6 else '0';
	clearS <= '1' when currentState = S0 else '0';
	clearX <= '1' when currentState = S0 else '0';
	clearY <= '1' when currentState = S0 else '0';
	selX <= '1' when currentState = S4 else '0';
	selY <= '1' when currentState = S5 else '0';
	
end arq;