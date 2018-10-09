library ieee;
use ieee.std_logic_1164.all;

entity Register_Nbits is
	generic (N: positive := 4);
	port(
		clk, reset,carga: in std_logic;
		d: in std_logic_vector(N-1 downto 0);
		q: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture canonic of Register_Nbits is
	subtype InternalState is std_logic_vector(N-1 downto 0); -- ...
	signal nextState, currentState: InternalState;
begin
	-- next state logic (combinatorial)
	nextState <= d; 
	
	-- memory element (sequential)
	ME: process (clk, reset) is
	begin
		if reset='1' then 
			currentState <= (others=>'0'); 
		elsif rising_edge(clk) and carga = '1' then
			currentState <= nextState;
		end if;
	end process;
	
	-- output logic (combinatorial)
	q <= currentState;
	
end architecture;













