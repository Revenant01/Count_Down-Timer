library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity updown_counter is
    port ( 
        clk:        in  std_logic;
        reset:      in  std_logic;
        up_down:    in  std_logic;
        enable:     in  std_logic;
        max:        in  std_logic_vector(3 downto 0); 
        counter:    out std_logic_vector(3 downto 0) 
     );
end entity updown_counter;

architecture behavioral of updown_counter is
    signal counter_updown:  unsigned(3 downto 0);
begin
    process (clk) -- other signals evaluated inside clock edge
    begin
        if rising_edge(clk) then
            if enable = '1' then  -- don't gate the clock
                if reset = '1' then
                    counter_updown <= (others => '0');
                elsif up_down = '1' then             -- down
                    if counter_updown = 0 then
                        counter_updown <= unsigned(max);
                    else
                        counter_updown <= counter_updown - 1;
                    end if;
                else -- count up
                    if counter_updown = unsigned(max) then
                        counter_updown <= (others => '0');
                    else
                        counter_updown <= counter_updown + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
     counter <= std_logic_vector(counter_updown);
end architecture behavioral;