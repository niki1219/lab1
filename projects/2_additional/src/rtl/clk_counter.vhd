-------------------------------------------------------------------------------
--  Odsek za racunarsku tehniku i medjuracunarske komunikacije
--  Autor: LPRS2  <lprs2@rt-rk.com>                                           
--                                                                             
--  Ime modula: timer_counter                                                          
--                                                                             
--  Opis:                                                               
--                                                                             
--    Modul odogvaran za indikaciju o proteku sekunde
--                                                                             
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY clk_counter IS GENERIC(
                              -- maksimalna vrednost broja do kojeg brojac broji
                              max_cnt : STD_LOGIC_VECTOR(25 DOWNTO 0) := "10111110101111000010000000" -- 50 000 000
                             );
                      PORT   (
                               clk_i     : IN  STD_LOGIC; -- ulazni takt
                               rst_i     : IN  STD_LOGIC; -- reset signal
                               cnt_en_i  : IN  STD_LOGIC; -- signal dozvole brojanja
                               cnt_rst_i : IN  STD_LOGIC; -- signal resetovanja brojaca (clear signal)
                               one_sec_o : OUT STD_LOGIC  -- izlaz koji predstavlja proteklu jednu sekundu vremena
                             );
END clk_counter;

ARCHITECTURE rtl OF clk_counter IS

SIGNAL   counter_r : STD_LOGIC_VECTOR(25 DOWNTO 0);

BEGIN

-- DODATI:
-- brojac koji kada izbroji dovoljan broj taktova generise SIGNAL one_sec_o koji
-- predstavlja jednu proteklu sekundu, brojac se nulira nakon toga
process(rst_i ,clk_i) begin --lista osetljivosti
			if(rst_i ='1') then -- u if-u samo =(then)!!!! kad je 1 onda je aktiviran
				counter_r<="00000000000000000000000000";
			elsif(clk_i'event and clk_i='1') then --rastuca ivica
				if(cnt_rst_i='1') then  --proveriti reset	
					counter_r<="00000000000000000000000000";
				elsif(cnt_en_i='1') then--proveri doz
					counter_r <= counter_r+1;
					else
					counter_r <= counter_r;
				end if;
			end if;
		end process;
	
	
		process(counter_r)begin
			if(max_cnt=counter_r-1)then --zbog 23.99999.. treba -1
				one_sec_o<='1';
			else
				one_sec_o<='0';
			end if;
		end process;


END rtl;