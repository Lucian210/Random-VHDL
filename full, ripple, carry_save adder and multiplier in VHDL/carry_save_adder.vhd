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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity carry_save_adder is
    Port ( a_c : in  std_logic_vector (7 downto 0);
           b_c : in  std_logic_vector (7 downto 0);
           c_c : in  std_logic_vector (7 downto 0);
           s_c : out std_logic_vector (7 downto 0);
           cout_c : out std_logic 
           );
end carry_save_adder;

architecture Behavioral of carry_save_adder is

component full_adder is
  Port (a : in STD_LOGIC;
        b : in STD_LOGIC;
        cin : in STD_LOGIC;
        s : out STD_LOGIC;
        cout : out STD_LOGIC
        );
end component;

component ripple_adder is
  Port (x_r : in std_logic_vector(7 downto 0);
        y_r : in std_logic_vector(7 downto 0);
        cin_r : in std_logic;
        s_r: out std_logic_vector(7 downto 0);
        cout_r : out std_logic 
        );
end component;

signal x, y: std_logic_vector(7 downto 0);
signal ripple_result: std_logic_vector(7 downto 0);

begin

fa1: full_adder port map(a_c(0), b_c(0),c_c(0),y(0),x(0));
fa2: full_adder port map(a_c(1), b_c(1),c_c(1),y(1),x(1));
fa3: full_adder port map(a_c(2), b_c(2),c_c(2),y(2),x(2));
fa4: full_adder port map(a_c(3), b_c(3),c_c(3),y(3),x(3));
fa5: full_adder port map(a_c(4), b_c(4),c_c(4),y(4),x(4));
fa6: full_adder port map(a_c(5), b_c(5),c_c(5),y(5),x(5));
fa7: full_adder port map(a_c(6), b_c(6),c_c(6),y(6),x(6));
fa8: full_adder port map(a_c(7), b_c(7),c_c(7),y(7),x(7));


ripple: ripple_adder port map(x, y, '0', ripple_result, cout_c);

s_c(7 downto 0) <= ripple_result;

end Behavioral;
