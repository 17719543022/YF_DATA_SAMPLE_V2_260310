----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2024/05/23 16:14:23
-- Design Name: 
-- Module Name: tb_ad7177 - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.my_package.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ad7177 is
--  Port ( );
end tb_ad7177;

architecture Behavioral of tb_ad7177 is

component ctrl_ad7177 is
generic(device_num:integer:=18);
 Port (
    clkin           :in std_logic;
    rst_n           :in std_logic;
----------------------------
    spi_clk         :out std_logic;
    spi_cs          :out std_logic;
    spi_mosi        :out std_logic;
    spi_miso        :in std_logic_vector(device_num-1 downto 0);
    sync_n          :out std_logic;
    audi_in         :in std_logic;
    adc_check_sus   :out std_logic_vector(device_num-1 downto 0);
    sample_time_num :in std_logic_vector(31 downto 0);
    work_mod        :in std_logic_vector(7 downto 0);
    sample_start    :in std_logic;
----------------------------
    ad_data_buf     :out ad_buf_t;
    ad_data_buf_vld :out std_logic;
    err_num         :out std_logic_vector(device_num-1 downto 0);
    adui_data       :out std_logic_vector(24-1 downto 0);
----------------------------
    m_axis_tvalid   :out std_logic;
    m_axis_tdata    :out std_logic_vector(2*device_num*32-1 downto 0)
 );
end component;

signal    clkin           :std_logic:='0';
signal    rst_n           :std_logic:='0';
signal    spi_clk         :std_logic:='0';
signal    spi_cs          :std_logic:='0';
signal    spi_mosi        :std_logic:='0';
signal    spi_miso        :std_logic_vector(18-1 downto 0);
signal    sync_n          :std_logic:='0';
signal    audi_in         :std_logic:='0';
signal    adc_check_sus   :std_logic_vector(18-1 downto 0);
signal    sample_time_num :std_logic_vector(31 downto 0);
signal    work_mod        :std_logic_vector(7 downto 0);
signal    sample_start    :std_logic:='0';
signal    ad_data_buf     :ad_buf_t;
signal    ad_data_buf_vld :std_logic;
signal    err_num         :std_logic_vector(18-1 downto 0);
signal    adui_data       :std_logic_vector(24-1 downto 0);
signal    m_axis_tvalid   :std_logic;
signal    m_axis_tdata    :std_logic_vector(2*18*32-1 downto 0);
constant    freq:integer:=50*10**6/(5*10**3);
begin

clkin<= not clkin after 10ns;
rst_n<='1' after 100ns;


uut:ctrl_ad7177 port map(

    clkin               =>  clkin                ,       
    rst_n               =>  rst_n                ,
    spi_clk             =>  spi_clk              ,
    spi_cs              =>  spi_cs               ,
    spi_mosi            =>  spi_mosi             ,
    spi_miso            =>  spi_miso             ,
    sync_n              =>  sync_n               ,
    audi_in             =>  audi_in              ,
    adc_check_sus       =>  adc_check_sus        ,
    sample_time_num     =>  sample_time_num      ,
    work_mod            =>  work_mod             ,
    sample_start        =>  sample_start         ,
    ad_data_buf         =>  ad_data_buf          ,
    ad_data_buf_vld     =>  ad_data_buf_vld      ,
    err_num             =>  err_num              ,
    adui_data           =>  adui_data            ,
    m_axis_tvalid       =>  m_axis_tvalid        ,
    m_axis_tdata        =>  m_axis_tdata    
);



process(clkin,rst_n)
variable cnt:integer:=0;
begin
    if rst_n='0' then
        cnt:=0;
        sample_start<='0';
    else
        if rising_edge(clkin) then
            if cnt>=freq-1 then
                cnt:=0;
            else
                cnt:=cnt+1;
            end if;
            
            if cnt=10 then
                sample_start<='1';
            else
                sample_start<='0';
            end if;
            
        end if;
    end if;
end process;
              










end Behavioral;
