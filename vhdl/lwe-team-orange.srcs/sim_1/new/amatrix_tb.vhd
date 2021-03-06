----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2021 01:15:54 PM
-- Design Name: 
-- Module Name: rngnum_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package pkg is
  type t_array is array (natural range <>) of std_logic_vector(15 downto 0);
end package;

package body pkg is
end package body;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;

entity amatrix_tb is
--  Port ( );
end amatrix_tb;

architecture Behavioral of amatrix_tb is
    COMPONENT rngnum IS
    PORT (Clk, Rst: IN std_logic;
          output: OUT std_logic_vector (15 DOWNTO 0));
    END COMPONENT;
    component AMatrix is
        Generic ( i : integer );
        PORT (Clk, Rst: IN std_logic;
            AOUT: OUT t_array (0 to i-1);
            ready: OUT std_logic);
    end component;
    
    SIGNAL Clk_s, Rst_s: std_logic;
    SIGNAL output_s: std_logic_vector(15 DOWNTO 0);
    --SIGNAL poutput_s: std_logic_vector(15 DOWNTO 0);
    SIGNAL s_out: t_array (0 to 15);
    SIGNAL t_ready: std_logic;
    
begin
    CompToTest: rngnum PORT MAP (Clk_s, Rst_s, output_s);
    MatrixToTest: AMatrix 
        Generic MAP (i => 16)
        PORT MAP (Clk_s, Rst_s, s_out, t_ready);

    Clk_proc: PROCESS
    BEGIN
        Clk_s <= '1';
        WAIT FOR 10 ns;
        Clk_s <= '0';
        WAIT FOR 10 ns;
    END PROCESS clk_proc;
    
    Vector_proc: PROCESS
    BEGIN
        Rst_s <= '1';
        WAIT FOR 5 NS;
        Rst_s <= '0';
        FOR index IN 0 To 4 LOOP
            WAIT UNTIL Clk_s='1' AND Clk_s'EVENT;
        END LOOP;
        WAIT FOR 5 NS;
        ASSERT output_s = X"88" REPORT "Failed output=88";
        WAIT;
    END PROCESS Vector_proc;

end Behavioral;
