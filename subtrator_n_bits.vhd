library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtrator_n_bits is
	generic (N: positive := 4);
	port(
		a: in std_logic_vector(N-1 downto 0);
		b: in std_logic_vector(N-1 downto 0);
		saida: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture arq of subtrator_n_bits is
begin
saida <= std_logic_vector(unsigned(a) - unsigned(b));
end arq;