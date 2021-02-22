----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:45:26 05/22/2020 
-- Design Name: 
-- Module Name:    multiplier - Behavioral 
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

--------------------------------Floating Point Multiplier-----------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mul_8bit is
    Port ( a : in  unsigned(7 downto 0);
           b : in  unsigned(7 downto 0);
           prod : out  unsigned(7 downto 0);
           sflag : out  std_logic);
end mul_8bit;

architecture Behavioral of mul_8bit is

begin
	process(a,b)
	--declaring variable for each part of the floating point number
	variable sign_a,sign_b,sign_z,svar: std_logic;									
	variable exp_a,exp_b,exp_z: unsigned(3 downto 0);
	variable man_a,man_b: unsigned(4 downto 0);
	variable man_z: unsigned(9 downto 0);
	begin
	--1)checking infinite value in inputs
	if (a(6 downto 4)="111" or b(6 downto 4)="111") then
	sflag<='0';
	prod<="01110000";
	else
		
		--2)assigning value to each variable
			sign_a:=a(7);
			sign_b:=b(7);
			exp_a(2 downto 0):=a(6 downto 4);	
			exp_a(3):='0';
			exp_b(2 downto 0):=b(6 downto 4);
			exp_b(3):='0';
			man_a(3 downto 0):=a(3 downto 0);
			man_b(3 downto 0):=b(3 downto 0);
			man_a(4):='1';
			man_b(4):='1';
		--3)success if nothing lowers success flag  
			svar:='1';
		
		--4)adding exponents
			exp_z:=exp_a+exp_b;
		-- subtracting bias
			exp_z:=exp_z-"0011";
		--5)checking overflow
			if exp_z(3)='1' then
				svar:='0';
			end if;
			
		--6)multiplying mantissas
			man_z:=resize(man_a*man_b,10);
         
		--7)normalising and shifting exp
			if (man_z(9)='1') then
				man_z:=man_z srl 1;
				exp_z:=exp_z+"0001";
			end if;
			
		--8)raising overflow flag and lowering sucess flag	
			if (exp_z(3)='1') then
				svar:='0';
			end if;
			
		-- 9)calculating sign of product
			sign_z:=sign_a xor sign_b;
			
		--10)Assigning final values to prod
			prod(3 downto 0)<=man_z(7 downto 4);
			prod(6 downto 4)<=exp_z(2 downto 0);
			prod(7)<=sign_z;
			sflag<=svar;
		end if;
		end process;
end Behavioral;

