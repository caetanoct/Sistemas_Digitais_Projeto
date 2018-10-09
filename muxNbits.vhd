library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity muxNbits is
	generic (n: natural := 4); 
	port (
s0,s1: in std_logic_vector (n-1 downto 0) ;
sel : in std_logic;
saida: out std_logic_vector(n-1 downto 0)
);
end muxNbits;

architecture arq of muxNbits is
begin
saida <= s0 when sel = '0' else s1;
end arq; 