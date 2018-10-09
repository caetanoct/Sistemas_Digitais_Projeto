library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity XmenY is
	generic (n: natural := 4); 
	port (
x,y: in std_logic_vector (n-1 downto 0) ;
saida: out std_logic
);
end XmenY;

architecture arq of XmenY is
begin
saida <= '1' when unsigned(x) < unsigned(y) else '0';
end arq; 