----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:45:08 05/22/2020 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--

--LIBRARIES TO USE
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--ENTITY OF 8 bit Floating Point Multiplier top module
entity floating_point_mul is
	port( num1 : in unsigned(7 downto 0);
		   num2 : in unsigned(7 downto 0);
			output: out unsigned(7 downto 0);
			op_flag:out std_logic);
end floating_point_mul;

--ARCHTECTURE 
architecture Behavioral of floating_point_mul is


--COMPONENT OF MULTIPLIER
component mul_8bit is
    Port ( a : in  unsigned(7 downto 0);
           b : in  unsigned(7 downto 0);
           prod : out  unsigned(7 downto 0);
           sflag : out  std_logic);
	
end component;

--MAIN BODY
begin

--FLOATING POINT MULTIPLIER
FLT_MUL_INS: 	mul_8bit port map(a=>num1,b=>num2,prod=>output,sflag=>op_flag);

--END OF ARCHITECTURE
end Behavioral;

