----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2021 02:43:06 PM
-- Design Name: 
-- Module Name: ripple_adder - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ripple_adder is
  Port (
          x_r : in std_logic_vector(7 downto 0);
          y_r : in std_logic_vector(7 downto 0);
          cin_r : in STD_LOGIC;
          s_r : out std_logic_vector(7 downto 0);
          cout_r : out STD_LOGIC );
end ripple_adder;

architecture Behavioral of ripple_adder is

component full_adder
    Port (x : in STD_LOGIC;
          y: in STD_LOGIC;
          cin: in STD_LOGIC;
          s: out STD_LOGIC;
          cout: out STD_LOGIC
        );
end component;

signal c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14: STD_LOGIC;
 
begin 

adder1: full_adder port map(x_r(0), y_r(0), cin_r, s_r(0), c0);
adder2: full_adder port map(x_r(1), y_r(1), c0, s_r(1), c1);
adder3: full_adder port map(x_r(2), y_r(2), c1, s_r(2), c2);
adder4: full_adder port map(x_r(3), y_r(3), c2, s_r(3), c3);
adder5: full_adder port map(x_r(4), y_r(4), c3, s_r(4), c4);
adder6: full_adder port map(x_r(5), y_r(5), c4, s_r(5), c5);
adder7: full_adder port map(x_r(6), y_r(6), c5, s_r(6), c6);
adder8: full_adder port map(x_r(7), y_r(7), c6, s_r(7), cout_r);




end Behavioral;
