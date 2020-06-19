library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity blinkled is
  port (
    SYS_CLK_P : in  std_logic;
    SYS_CLK_N : in  std_logic;
    PUSH_BTN  : in  std_logic;
    LED       : out std_logic_vector(2 downto 0)
    );
end entity blinkled;

architecture RTL of blinkled is

  signal SYS_CLK : std_logic;
  signal counter : unsigned(31 downto 0);

begin

  LED <= "001" when counter(26 downto 25) = "01" else
         "010" when counter(26 downto 25) = "01" else
         "100" when counter(26 downto 25) = "01" else
         "000";

  SYS_CLK_BUF : IBUFDS port map(
    I => SYS_CLK_P,
    IB => SYS_CLK_N,
    O => SYS_CLK
    );
  
  process(SYS_CLK)
  begin
    if rising_edge(SYS_CLK) then
      if PUSH_BTN = '0' then
        counter <= (others => '0');
      else
        counter <= counter + 1;
      end if;
    end if;
  end process;

end RTL;

