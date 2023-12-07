library ieee;
use ieee.std_logic_1164.all;

entity txcontrolleruart is
    port (
        greset: in std_logic;
        
        clk: in std_logic;
        send: in std_logic;
        
        tdre_l: out std_logic;
        tdre_w: out std_logic;
        
        tdr_l: out std_logic;
        
        tsr_l: out std_logic;
        tsr_s: out std_logic;
        
        txDFF_s: out std_logic; 
        txDFF_l: out std_logic
    );
end;

architecture rtl of txcontrolleruart is
    component enARdFF_2 is
        port (
            i_resetBar: in std_logic;
            i_d: in std_logic;
            i_enable: in std_logic;
            i_clock: in std_logic;
            o_q, o_qBar: out std_logic
        );
    end component;
    
    component Counter16D is
        port (
            CLK, RESETN: in std_logic;
            EN, LOAD: in std_logic;
            INPUT: in std_logic_vector(3 downto 0);
            EXPIRE: out std_logic;
            VALUE: out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal ctr_l: std_logic;
    signal ctr_en: std_logic;
    signal ctr_e: std_logic;
    
    signal signalD: std_logic_vector(1 downto 0);
    signal signalQ: std_logic_vector(1 downto 0);
begin
    generateDFF: for i in 1 downto 0 generate
        dffInst: enARdFF_2
            port map (
                i_resetBar => greset,
                i_d => signalD(i),
                i_enable => '1',
                i_clock => clk,
                o_q => signalQ(i)
            );
    end generate;
    
    ctr: Counter16D
        port map (
            CLK => clk,
            RESETN => greset,
            EN => ctr_en,
            LOAD => ctr_l,
            INPUT => "1000",
            EXPIRE => ctr_e
        );
end;
