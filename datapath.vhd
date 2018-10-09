library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
generic(m: natural := 4);
port (clk : in STD_LOGIC;
      x, y: in STD_LOGIC_VECTOR(m-1 downto 0); --testando com 4 bits
      loadX, loadY, loadS, clearS, clearY, clearX, selX, selY: in STD_LOGIC;
		mdcXY: out STD_LOGIC_VECTOR(m-1 downto 0);
		XmenYflag, XigualYflag : out STD_LOGIC);
end datapath;


architecture arq of datapath is
	
	--DECLARACAO DE COMPONENTES
	component muxNbits is  
	generic (n: natural := 4); 
	port (
	s0,s1: in std_logic_vector (n-1 downto 0) ;
	sel : in std_logic;
	saida: out std_logic_vector(n-1 downto 0)
	);
	end component;
	
	component Register_Nbits is
	generic (N: positive := 4);
	port(
		clk, reset,carga: in std_logic;
		d: in std_logic_vector(N-1 downto 0);
		q: out std_logic_vector(N-1 downto 0)
	);
	end component;
	
	component subtrator_n_bits is
	generic (N: positive := 1);
	port(
		a: in std_logic_vector(N-1 downto 0);
		b: in std_logic_vector(N-1 downto 0);
		saida: out std_logic_vector(N-1 downto 0)
	);
	end component;

	component XigualY is
	generic (n: natural := 4); 
	port (
	x,y: in std_logic_vector (n-1 downto 0) ;
	saida: out std_logic
	);
	end component;
	
	component XmenY is
	generic (n: natural := 4); 
	port (
	x,y: in std_logic_vector (n-1 downto 0) ;
	saida: out std_logic
	);
	end component;
	--DECLARACAO DE SINAIS
	signal saiMuxX, saiMuxY, saiRegX, saiRegY, saiSub1, saiSub2, saiRegS: std_logic_vector(m-1 downto 0);

begin
	--INSTANCIACAO DOS COMPONENTES
	--'M'(Quantidade de bits) DECLARADO NO GENERIC DO DATAPATH
	muxX: muxNbits generic map(m) port map(x, saiSub2,selX, saiMuxX);
	muxY: muxNbits generic map(m) port map(y, saiSub1,selY, saiMuxY);
	RegY: Register_Nbits generic map(m) port map(clk, clearY, loadY, saiMuxY, saiRegY);
	RegX:	Register_Nbits generic map(m) port map(clk, clearX, loadX, saiMuxX, saiRegX);
	Sub1: subtrator_n_bits generic map(m) port map(saiRegY, saiRegX, saiSub1);
	Sub2:	subtrator_n_bits generic map(m) port map(saiRegX, saiRegY, saiSub2);
	RegSaida: Register_Nbits generic map(m) port map(clk, clearS, loadS, saiRegX, mdcXY);
	XmenY_PortMap: XmenY generic map(m) port map(saiRegX, saiRegY, XmenYflag);
	XigualY_PortMap: XigualY generic map(m) port map(saiRegX, saiRegY, XigualYflag);
end arq;