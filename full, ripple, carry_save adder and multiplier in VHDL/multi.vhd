----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2021 08:59:07 PM
-- Design Name: 
-- Module Name: csa - Behavioral
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

entity multi is
     Port (multiplier : in  std_logic_vector (3 downto 0);
           multiplicand : in  std_logic_vector (3 downto 0);
           product : out std_logic_vector (7 downto 0)
           );
end multi;

architecture Behavioral of multi is


component ripple_adder is
  Port (
          x_r : in std_logic_vector(7 downto 0);
          y_r : in std_logic_vector(7 downto 0);
          cin_r : in STD_LOGIC;
          s_r : out std_logic_vector(7 downto 0);
          cout_r : out STD_LOGIC );
end component;



signal z0_0 ,z0_1,z0_2,z0_3,z1_0,z1_1,z1_2,z1_3,z2_0,z2_1,z2_2,z2_3,z3_0,z3_1,z3_2,z3_3 : std_logic;
signal c1,c2,c3:std_logic;
signal partial1, partial2:std_logic_vector(7 downto 0) := "00000000";

signal zero, unu, doi, trei: std_logic_vector(7 downto 0);

begin

z0_0<=multiplier(0) and multiplicand(0);
z0_1<=multiplier(0) and multiplicand(1);
z0_2<=multiplier(0) and multiplicand(2);
z0_3<=multiplier(0) and multiplicand(3);
z1_0<=multiplier(1) and multiplicand(0);
z1_1<=multiplier(1) and multiplicand(1);
z1_2<=multiplier(1) and multiplicand(2);
z1_3<=multiplier(1) and multiplicand(3);
z2_0<=multiplier(2) and multiplicand(0);
z2_1<=multiplier(2) and multiplicand(1);
z2_2<=multiplier(2) and multiplicand(2);
z2_3<=multiplier(2) and multiplicand(3);
z3_0<=multiplier(3) and multiplicand(0);
z3_1<=multiplier(3) and multiplicand(1);
z3_2<=multiplier(3) and multiplicand(2);
z3_3<=multiplier(3) and multiplicand(3);

zero(0) <= z0_0;
zero(1) <= z0_1;
zero(2) <= z0_2;
zero(3) <= z0_3;
zero(7 downto 4) <= "0000";

unu(0) <= '0';
unu(1) <= z1_0;
unu(2) <= z1_1;
unu(3) <= z1_2;
unu(4) <= z1_3;
unu(7 downto 5) <= "000";

doi(0) <= '0';
doi(1) <= '0';
doi(2) <= z2_0;
doi(3) <= z2_1;
doi(4) <= z2_2;
doi(5) <= z2_3;
doi(7 downto 6) <= "00";

trei(0) <= '0';
trei(1) <= '0';
trei(2) <= '0';
trei(3) <= z3_0;
trei(4) <= z3_1;
trei(5) <= z3_2;
trei(6) <= z3_3;
trei(7) <= '0';




csa1: ripple_adder port map(zero, unu, '0', partial1, c1);
csa2: ripple_adder port map(partial1, doi, '0', partial2, c2);
csa3: ripple_adder port map(partial2, trei, '0', product, c3);


end Behavioral;
