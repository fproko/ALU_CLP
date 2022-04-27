-- Liberias
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_tb is
end entity;

architecture alu_tb_arq of alu_tb is

    -- Declaracion de componente
    component alu is
        generic (
            N : natural := 8
        );
        -- Puertos
        port (
            a_i : in unsigned(N - 1 downto 0);
            b_i : in unsigned(N - 1 downto 0);
            cy_i : in unsigned(0 downto 0);
            sel_i : in unsigned(3 downto 0);
            sal_o : out unsigned(N - 1 downto 0);
            cy_o : out unsigned(0 downto 0));
    end component;

    -- Definir en la siguiente linea el numero de bits deseados
    constant N_tb : natural := 8;

    -- Declaracion de señales de prueba
    signal a_tb : unsigned(N_tb - 1 downto 0) := to_unsigned(10, N_tb); --valor inicial
    signal b_tb : unsigned(N_tb - 1 downto 0) := to_unsigned(6, N_tb);
    signal cy_i_tb : unsigned(0 downto 0) := (others => '0');
    signal sel_tb : unsigned(3 downto 0) := (others => '0');
    signal sal_tb : unsigned(N_tb - 1 downto 0);
    signal cy_o_tb : unsigned(0 downto 0);

begin
    -- Señales de exitación
    a_tb <= to_unsigned(255, N_tb) after 5 ns, to_unsigned(195, N_tb) after 15 ns, to_unsigned(250, N_tb) after 20 ns,
        to_unsigned(10, N_tb) after 35 ns, to_unsigned(195, N_tb) after 55 ns, to_unsigned(0, N_tb) after 65 ns;

    b_tb <= to_unsigned(0, N_tb) after 5 ns, to_unsigned(5, N_tb) after 15 ns, to_unsigned(245, N_tb) after 20 ns,
        to_unsigned(255, N_tb) after 40 ns, to_unsigned(4, N_tb) after 45 ns, to_unsigned(2, N_tb) after 60 ns,
        to_unsigned(0, N_tb) after 65 ns;

    cy_i_tb <= "1" after 5 ns, "0" after 15 ns;

    sel_tb <= "0001" after 10 ns, "0010" after 15 ns, "0011" after 20 ns, "0100" after 25 ns,
        "0101" after 30 ns, "0110" after 35 ns, "0111" after 40 ns, "1000" after 45 ns, "1001" after 50 ns,
        "1010" after 55 ns, "1011" after 60 ns;

    -- Instanciación del componente a probar
    DUT : alu
    generic map(
        N => N_tb
    )
    port map(
        a_i => a_tb,
        b_i => b_tb,
        cy_i => cy_i_tb,
        sel_i => sel_tb,
        sal_o => sal_tb,
        cy_o => cy_o_tb
    );

end architecture;