

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MainControl is
    Port ( instr : in std_logic_vector(5 downto 0);
           clk : in  std_logic;
           MemRead : out  std_logic;
           MemWrite : out  std_logic;
           RegDst : out  std_logic;
           RegWrite : out  std_logic;         
           ALUSrcA : out  std_logic;
           ALUSrcB : out  std_logic_vector (1 downto 0);
           MemToReg : out  std_logic;
           IRWrite : out  std_logic;
           PCWrite : out  std_logic;
           ALUop : out  std_logic_vector (1 downto 0);      
           PCWriteCond : out  std_logic;      
           IorD : out  std_logic;               
           PCSource : out  std_logic_vector (1 downto 0)
          );
end MainControl;

architecture Behavioral of MainControl is

--semnal pentru starea curenta(10 stari -> 4 biti)
signal state : std_logic_vector(3 downto 0) := "0000";

begin

process(instr, clk, state )
begin
    --state register
if rising_edge(clk) and clk = '1' then
     if state = "0000" then
           state <= "0001"; --instr decode/reg fetch
           
     elsif state = "0001" then
            --lw merge in starea 2
            if instr = "100011" then
                state <= "0010";
            --sw merge in starea 2
            elsif instr = "101011" then
                state <= "0010";
           --R-type merge in starea 6
            elsif instr = "000000" then
                state <= "0110";
            --beq merge in starea 8
            elsif instr = "000100" then
                state <= "1000";
            --J merge in starea 9
            elsif instr = "000010" then
                state <= "1001";
            end if;
            
     elsif state = "0010" then --din starea 2 (lw sau sw)
            --daca e lw merge in starea 3
            if instr = "100011" then
                state <= "0011"; 
                else --daca e sw merge in starea 5
                state <= "0101";
            end if;
            
     elsif state = "0011" then --din starea 3 merge in starea 4
     state <= "0100";
     
     elsif state = "0100" then --din starea 4 merge in starea 0
     state <= "0000";
     
     elsif state = "0101" then --din starea 5 merge in starea 0
     state <= "0000";
     
     elsif state = "0110" then --din starea 6 merge in starea 7
     state <= "0111";
     
     elsif state = "0111" then --din starea 7 merge in starea 0
     state <= "0000";
     
     elsif state = "1000" then --din starea 8 merge in starea 0
     state <="0000";
     
     elsif state = "1001" then --din starea 9 merge in starea 0
     state <="0000";
     
     end if;
end if;


    if state = "0000" then --Instruction Fetch 0
        MemRead <= '1';
        MemWrite <= '0';
        RegDst <= '0';
        RegWrite <= '0';
        ALUSrcA <= '0';
        ALUSrcB <= "01";
        MemToReg <= '0';
        IRWrite <= '1';
        PCWrite <= '1';
        ALUop <= "00";
        PCWriteCond <= '0';
        IorD <= '0';
        PCSource <= "00";
        
    elsif state = "0001" then --Instruction decode/reg fetch 1
         MemRead <= '0';
         MemWrite <= '0';
         RegDst <= '0';
         RegWrite <= '0';
         ALUSrcA <= '0';
         ALUSrcB <= "11";
         MemToReg <= '0';
         IRWrite <= '0';
         PCWrite <= '0';
         ALUop <= "00";
         PCWriteCond <= '0';
         IorD <= '0';
         PCSource <= "00";
         
    elsif state = "0010" then --Memory address computation 2
         MemRead <= '0';
         MemWrite <= '0';
         RegDst <= '0';
         RegWrite <= '0';
         ALUSrcA <= '1';
         ALUSrcB <= "10";
         MemToReg <= '0';
         IRWrite <= '0';
         PCWrite <= '0';
         ALUop <= "00";
         PCWriteCond <= '0';
         IorD <= '0';
         PCSource <= "00";
         
     elsif state = "0011" then --Memory access 3
         MemRead <= '1'; 
         MemWrite <= '0';
         RegDst <= '0';
         RegWrite <= '0';
         ALUSrcA <= '0';
         ALUSrcB <= "00";
         MemToReg <= '0';
         IRWrite <= '0';
         PCWrite <= '0';
         ALUop <= "00";
         PCWriteCond <= '0';
         IorD <= '1';
         PCSource <= "00";    
         
     elsif state = "0100" then --Write-back Step 4
         MemRead <= '0'; 
         MemWrite <= '0';
         RegDst <= '0';
         RegWrite <= '1';
         ALUSrcA <= '0';
         ALUSrcB <= "00";
         MemToReg <= '1';
         IRWrite <= '0';
         PCWrite <= '0';
         ALUop <= "00";
         PCWriteCond <= '0';
         IorD <= '0';
         PCSource <= "00";    
     
     elsif state = "0101" then --Memory access 5
         MemRead <= '0';
         MemWrite <= '1';
         RegDst <= '0';
         RegWrite <= '0';
         ALUSrcA <= '0';
         ALUSrcB <= "00";
         MemToReg <= '0';
         IRWrite <= '0';
         PCWrite <= '0';
         ALUop <= "00";
         PCWriteCond <= '0';
         IorD <= '1';
         PCSource <= "00";    
     
     elsif state = "0110" then --Execution 6
         MemRead <= '0';
         MemWrite <= '0';
         RegDst <= '0';
         RegWrite <= '0';
         ALUSrcA <= '1';
         ALUSrcB <= "00";
         MemToReg <= '0';
         IRWrite <= '0';
         PCWrite <= '0';
         ALUop <= "10";
         PCWriteCond <= '0';
         IorD <= '0';
         PCSource <= "00";    
     
     elsif state = "0111" then --R-type completion 7
         MemRead <= '0';
         MemWrite <= '0';
         RegDst <= '1';
         RegWrite <= '1';
         ALUSrcA <= '0';
         ALUSrcB <= "00";
         MemToReg <= '0';
         IRWrite <= '0';
         PCWrite <= '0';
         ALUop <= "00";
         PCWriteCond <= '0';
         IorD <= '0';
         PCSource <= "00";    
     
     elsif state = "1000" then --Branch completion 8
         MemRead <= '0';
         MemWrite <= '0';
         RegDst <= '0';
         RegWrite <= '0';
         ALUSrcA <= '1';
         ALUSrcB <= "00";
         MemToReg <= '0';
         IRWrite <= '0';
         PCWrite <= '0';
         ALUop <= "01";
         PCWriteCond <= '1';
         IorD <= '0';
         PCSource <= "01";    
     
     elsif state = "1001" then --Jump completion 9
         MemRead <= '0';
         MemWrite <= '0';
         RegDst <= '0';
         RegWrite <= '0';
         ALUSrcA <= '0';
         ALUSrcB <= "00";
         MemToReg <= '0';
         IRWrite <= '0';
         PCWrite <= '1';
         ALUop <= "00";
         PCWriteCond <= '0';
         IorD <= '0';
         PCSource <= "10";    
     
     end if;

end process;
end Behavioral;