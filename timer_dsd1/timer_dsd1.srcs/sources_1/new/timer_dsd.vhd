----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2023 04:43:36 PM
-- Design Name: 
-- Module Name: timer_dsd - Behavioral
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

entity timer_dsd is
  Port (clk,reset : in std_logic ;
          A : in std_logic_vector ( 3 downto 0);
          B : out std_logic_vector(13 downto 0));
end timer_dsd;

architecture structural of timer_dsd is
component decoder is  
    Port ( B0,B1,B2,B3 : in STD_LOGIC;
          A,B,C,D,E,F,G : out STD_LOGIC);

end component;
component updown_counter is   
   port ( 
        clk:        in  std_logic;
        reset:      in  std_logic;
        up_down:    in  std_logic;
        enable:     in  std_logic;
        max:        in  std_logic_vector(3 downto 0); 
        counter:    out std_logic_vector(3 downto 0) 
     );
     end component; 
signal g_counter : integer:=0;
signal g_clk : std_logic:='0';
signal tmp : std_logic:='0';
signal out_counter1 : std_logic_vector(3 downto 0);
signal first_counter : std_logic_vector(3 downto 0);
signal out_counter2 : std_logic_vector(3 downto 0);
begin
first_counter <= "0000";
process (clk, reset)
begin
if ( reset = '1' ) then
g_counter <= 0;
elsif ( rising_edge (clk)) then
if ( g_counter = 50000000) then
g_counter <= 0;
tmp <= not(tmp);
else
g_counter <= g_counter+1;
end if;
g_clk <= tmp;
end if;
end process;
unit1 : updown_counter port map (clk,reset,'1','1',first_counter, out_counter1);
unit2 : decoder port map (out_counter1(0),out_counter1(1),out_counter1(2),out_counter1(3),B(0),B(1),B(2),B(3),B(4),B(5),B(6));
unit3 : updown_counter port map (clk,reset,'1','1',A, out_counter2);
unit4 : decoder port map (out_counter2(0),out_counter2(1),out_counter2(2),out_counter2(3),B(7),B(8),B(9),B(10),B(11),B(12),B(13));
end structural;
