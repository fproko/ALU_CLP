-- Liberias
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
    generic (
        N : natural := 8
    );
    -- Puertos
    port (
        a_i   : in unsigned(N - 1 downto 0);
        b_i   : in unsigned(N - 1 downto 0);
        cy_i  : in unsigned(0 downto 0);
        sel_i : in unsigned(3 downto 0);
        sal_o : out unsigned(N - 1 downto 0);
        cy_o  : out unsigned(0 downto 0));
end entity;

architecture alu_arq of alu is
begin
    process (sel_i, a_i, b_i, cy_i)
        variable aux : unsigned (N + 1 downto 0);
    begin
        case sel_i is
            when "0000" => -- Suma
                aux := ('0' & a_i & cy_i) + ('0' & b_i & '1');
                sal_o <= aux(N downto 1);        -- se descarta bit 0
                cy_o <= aux(N + 1 downto N + 1); -- bit N+1 es cy_o
            when "0001" => -- Resta
                aux := ('0' & a_i & '0') - ('0' & b_i & cy_i);
                sal_o <= aux(N downto 1);
                cy_o <= aux(N + 1 downto N + 1);
            when "0010" => -- Multiplicacion N/2 bits
                sal_o <= a_i(((N - 1)/2) downto 0) * b_i(((N - 1)/2) downto 0);
            when "0011" => -- AND
                sal_o <= a_i and b_i;
            when "0100" => -- OR
                sal_o <= a_i or b_i;
            when "0101" => -- XOR
                sal_o <= a_i xor b_i;
            when "0110" => -- NOT a
                sal_o <= not a_i;
            when "0111" => -- Not b
                sal_o <= not b_i;
            when "1000" => -- a Left shift b bits
                sal_o <= a_i sll to_integer(b_i);
            when "1001" => -- a Right shift b bits
                sal_o <= a_i srl to_integer(b_i);
            when "1010" => -- a Rotate Left b bits
                sal_o <= a_i rol to_integer(b_i);
            when "1011" => -- a Rotate Right b bits
                sal_o <= a_i ror to_integer(b_i);
            when others =>
                sal_o <= (others => '0');
        end case;
    end process;
end architecture;