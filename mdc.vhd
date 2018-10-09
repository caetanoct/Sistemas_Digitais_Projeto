LIBRARY ieee;
USE ieee.std_logic_1164.all;

--BLOCO TOPO DO PROJETO
entity mdc is
generic(m: natural := 4);
port(
x,y: in std_logic_vector (m-1 downto 0) ;
mdcxy: out std_logic_vector(m-1 downto 0);
clk,start, reset: in std_logic
);
end entity;



architecture arq of mdc is

--DECLARAÇAO DE COMPONENTES:
	component datapath is
		generic(m: natural := 4);
		port (clk : in STD_LOGIC;
      x, y: in STD_LOGIC_VECTOR(m-1 downto 0); --testando com 4 bits
      loadX, loadY, loadS, clearS, clearY, clearX, selX, selY: in STD_LOGIC;
		mdcXY: out STD_LOGIC_VECTOR(m-1 downto 0);
		XmenYflag, XigualYflag : out STD_LOGIC);
	end component;
	
	component controle is
		port(reset, clk: IN STD_LOGIC;
      start, XmenYflag, XigualYflag: IN STD_LOGIC;
      loadX, loadY, loadS, clearS, clearX, clearY, selX, selY: OUT STD_LOGIC);
	end component;

--DECLARAÇAO DE SINAIS
signal loadXs, loadYs, loadSs, clearSs, clearYs, clearXs, selXs, selYs: std_logic;
signal XmenYflag, XigualYflag: std_logic; 

begin
	--DECLARACAO DATAPATH
	bo: datapath generic map(m) port map(clk, x, y, 
	loadXs, loadYs, loadSs, 
	clearSs, clearYs, clearXs, 
	selXs, selYs,mdcxy,XmenYflag,XigualYflag);
	--DECLARACAO BLOCO DE CONTROLE
	bc: controle port map (reset, clk , start,XmenYflag,XigualYflag,loadXs, loadYs, loadSs, clearSs, clearYs, clearXs, selXs, selYs);
end arq;