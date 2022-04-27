-- Liberias
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_vio is
    port (
    clk_i : in std_logic -- clock
    );
end entity;

architecture alu_vio_arq of alu_vio is
    
    -- ALU
    component alu is
        generic (N : natural := 8);
        -- Puertos
        port (
            a_i : in unsigned(N - 1 downto 0);
            b_i : in unsigned(N - 1 downto 0);
            cy_i : in unsigned(0 downto 0);
            sel_i : in unsigned(3 downto 0);
            sal_o : out unsigned(N - 1 downto 0);
            cy_o : out unsigned(0 downto 0));
    end component;
    
    -- VIO
    component vio_0
        generic (N : natural := 8);
      port (
        clk : IN STD_LOGIC;
        probe_in0 : IN unsigned(N-1 DOWNTO 0);   --sal_o_probe
        probe_in1 : IN unsigned(0 DOWNTO 0);   --cy_o_probe
        probe_out0 : OUT unsigned(N-1 DOWNTO 0); --a_i_probe
        probe_out1 : OUT unsigned(N-1 DOWNTO 0); --b_i_probe
        probe_out2 : OUT unsigned(3 DOWNTO 0); --sel_i_probe
        probe_out3 : OUT unsigned(0 DOWNTO 0));--cy_i_probe
    END component;
    
    constant N_vio : natural := 8;
        
    signal a_i_probe : unsigned(N_vio-1 downto 0);
    signal b_i_probe : unsigned(N_vio-1 downto 0);
    signal cy_i_probe : unsigned(0 downto 0);
    signal sel_i_probe : unsigned(3 downto 0);
    signal sal_o_probe : unsigned(N_vio-1 downto 0);
    signal cy_o_probe : unsigned(0 downto 0);
    
begin
    -- Instancio componente ALU
    alu_inst: alu
    	generic map(N => N_vio)
        port map(
            a_i => a_i_probe,
            b_i => b_i_probe,
            cy_i => cy_i_probe,
            sel_i => sel_i_probe,
            sal_o => sal_o_probe,
            cy_o => cy_o_probe);
    
    -- Instancio componente vio_0
    vio_0_inst : vio_0
      generic map(N => N_vio)
      PORT MAP (
        clk => clk_i,
        probe_in0 => sal_o_probe,
        probe_in1 => cy_o_probe,
        probe_out0 => a_i_probe,
        probe_out1 => b_i_probe,
        probe_out2 => sel_i_probe,
        probe_out3 => cy_i_probe);
end architecture;