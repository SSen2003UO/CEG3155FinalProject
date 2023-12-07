library ieee;
use ieee.std_logic_1164.all;

entity controllertraffic is
	port(
	clk,resetn: in std_logic;
	sscs,ctep: in std_logic;
	slct: out std_logic_vector(1 downto 0);
	enct,ldct: out std_logic;
	SI: out std_logic_vector(3 downto 0);
	mstl,sstl: out std_logic_vector(2 downto 0)
	);
end;

architecture rtl of controllertraffic is
component enARdFF_2 is
	port(
	i_resetBar: in std_logic;
   i_d: in std_logic;
   i_enable: in std_logic;
   i_clock: in std_logic;
   o_q, o_qBar: out std_logic
	);
	end component;
	
	signal signalD, signalQ: std_logic_vector(3 downto 0);
begin
	generateDFF: for i in 3 downto 0 generate
		dFFInst: enARdFF_2 port map(
		i_resetBar => resetn,
		i_d => signalD(i),
		i_enable => '1',
		i_clock => clk,
		o_q => signalQ(i)
		);
	end generate;
	
	signalD(3) <= (signalQ(3) and (signalQ(0) nand CTEP)) or (signalQ(2) and signalQ(1) and signalQ(0) and ctep);
   signalD(2) <= signalQ(2) xor (signalQ(1) and signalQ(0) and ctep);
   signalD(1) <= (signalQ(1) and (signalQ(0) nand ctep)) or (not signalQ(1) and signalQ(0) and ctep and (sscs or signalQ(2)));
   signalD(0) <= signalQ(0) nand ctep;
	
	mstl(2) <= signalQ(2);
   mstl(1) <= not signalQ(2) and signalQ(1);
   mstl(0) <= signalQ(2) nor signalQ(1);
    
   sstl(2) <= not signalQ(2);
   sstl(1) <= signalQ(2) and signalQ(1);
   sstl(0) <= signalQ(2) and not signalQ(1);
    
   slct(1) <= signalQ(2);
   slct(0) <= signalQ(3) or signalQ(1);
    
   ldct <= not signalQ(0);
   enct <= signalQ(0);
	
	SI <= signalD;

end;