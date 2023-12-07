library ieee;
use ieee.std_logic_1164.all;

entity rxcontrolleruart is
    port (
        g_reset: in std_logic;
        
        clk: in std_logic;
        rx: in std_logic;
        
        rdrf_l: out std_logic;
        rdrf_w: out std_logic;
        
        oe_l: out std_logic;
        oe_w: out std_logic;
        
        fe_l: out std_logic;
        fe_w: out std_logic;
        
        rsr_s: out std_logic;
        
        rsr_l: out std_logic
    );
end;

architecture rtl of rxcontrolleruart is
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

    signal ctr0_en: std_logic;
    signal ctr0_l: std_logic;
    signal ctr0_i: std_logic_vector(3 downto 0);
    signal ctr0_e: std_logic;
    
    signal ctr1_clk: std_logic;
    signal ctr1_en: std_logic;
    signal ctr1_l: std_logic;
    signal ctr1_e: std_logic;
    
    signal signalD: std_logic_vector(3 downto 0);
    signal signalQ: std_logic_vector(3 downto 0);
begin
    generateDFF: for i in 3 downto 0 generate
        dffInst: enARdFF_2
            port map (
                i_resetBar => g_reset,
                i_d => signalD(i),
                i_enable => '1',
                i_clock => clk,
                o_q => signalQ(i)
            );
    end generate;
    
    ctr0: Counter16D
        port map (
            CLK => clk,
            RESETN => g_reset,
            EN => ctr0_en,
            LOAD => ctr0_l,
            INPUT => ctr0_i,
            EXPIRE => ctr0_e
        );
    
    ctr1: Counter16D
        port map (
            CLK => ctr1_clk,
            RESETN => g_reset,
            EN => ctr1_en,
            LOAD => ctr1_l,
            INPUT => "1000",
            EXPIRE => ctr1_e
        );
    
  
end;
