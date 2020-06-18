---
title: "インストール"
date: 2019-10-30T19:15:46+09:00
type: docs
draft: false
weight: -5000
bookToc: true
---

# インストール

## 電源の接続
exStickGEを利用するためには，CN4から5Vの電源を投入する必要があります．CN4のピン配置は次の通りです．

{{<figure src="../figures/power_suply.png" class="center" width="350">}}

附属の電源ケーブルを利用する場合は，

 項目     | スペック
----------|------------------
 外径     | 5.5mm
 内径     | 2.1mm
 極性     | センタープラス
 出力電圧 | 5V
 出力電流 | 2A以上を推奨
  
に適合したACアダプタを利用してください．

## JTAGアダプタ
FPGAのコンフィギュレーションおよびROMへの書き込み時は，CN5にXilinxの書き込みアダプタを接続してください．ピン穴が千鳥になっているため半田付けしなくともピンヘッダを挿入するだけで書き込みができます．

ピン配置は次の通りです．[Digilent社のJTAG-HS2プログラミングケーブル](https://store.digilentinc.com/jtag-hs2-programming-cable/)を直接利用できます．

{{<figure src="../figures/jtag_connector.png" class="center" width="240">}}

## 開発ソフトウェア
FPGAの開発には[Vivado](https://www.xilinx.com/products/design-tools/vivado.html)を利用してください．搭載しているFPGA XC7A200TSBG484-2は無償で利用可能なWebPackで開発できます．

## ボード定義ファイル
exStickGEのボード定義ファイルを https://github.com/e-trees/board_files からダウンロードして利用できます．利用する場合は，以下のように，ダウンロードしたファイルを解凍しVivadoのボードファイルディレクトリの下にコピーしてください．

```shell
$ wget https://github.com/e-trees/board_files/archive/master.zip
$ unzip master.zip
$ sudo mv board_files-master/board_files/exstickge /tools/Xilinx/Vivado/2020.1/data/boards/board_files/
```

## 制約ファイルのサンプル

以下はVivado用の制約ファイル(XDCファイル)の例です．拡張コネタクタにビジョン基板を接続していることを想定しています．

```file=exstickge.tcl
#
# Main board
#

# SYSY CLK 200MHz
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVDS_25} [get_ports SYS_CLK_P]
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVDS_25} [get_ports SYS_CLK_N]
create_clock -period 5.000 -name clk_pin -waveform {0.000 2.500} -add [get_ports SYS_CLK_P]

# ON BOARD LEDs
set_property -dict {PACKAGE_PIN E21 IOSTANDARD LVCMOS33} [get_ports {LED[0]}]
set_property -dict {PACKAGE_PIN D21 IOSTANDARD LVCMOS33} [get_ports {LED[1]}]
set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS33} [get_ports {LED[2]}]

# PUSH BUBTTON
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports PUSH_BTN]

# PMOD
set_property {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {PMOD[1]}]
set_property {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {PMOD[2]}]
set_property {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports {PMOD[3]}]
set_property {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {PMOD[4]}]

# Ethernet
set_property -dict {PACKAGE_PIN AA14 IOSTANDARD LVCMOS33} [get_ports {GEPHY_RD[3]}]
set_property -dict {PACKAGE_PIN Y13  IOSTANDARD LVCMOS33} [get_ports {GEPHY_RD[2]}]
set_property -dict {PACKAGE_PIN AB15 IOSTANDARD LVCMOS33} [get_ports {GEPHY_RD[1]}]
set_property -dict {PACKAGE_PIN AA15 IOSTANDARD LVCMOS33} [get_ports {GEPHY_RD[0]}]
set_property -dict {PACKAGE_PIN AB17 IOSTANDARD LVCMOS33} [get_ports {GEPHY_TD[3]}]
set_property -dict {PACKAGE_PIN AB16 IOSTANDARD LVCMOS33} [get_ports {GEPHY_TD[2]}]
set_property -dict {PACKAGE_PIN AA16 IOSTANDARD LVCMOS33} [get_ports {GEPHY_TD[1]}]
set_property -dict {PACKAGE_PIN Y16  IOSTANDARD LVCMOS33} [get_ports {GEPHY_TD[0]}]
set_property -dict {PACKAGE_PIN T16  IOSTANDARD LVCMOS33} [get_ports GEPHY_PMEB]
set_property -dict {PACKAGE_PIN Y11  IOSTANDARD LVCMOS33} [get_ports GEPHY_RCK]
set_property -dict {PACKAGE_PIN U16  IOSTANDARD LVCMOS33} [get_ports GEPHY_RST_N]
set_property -dict {PACKAGE_PIN AA9  IOSTANDARD LVCMOS33} [get_ports GEPHY_RXDV_ER]
set_property -dict {PACKAGE_PIN AB13 IOSTANDARD LVCMOS33} [get_ports GEPHY_TCK]
set_property -dict {PACKAGE_PIN AA13 IOSTANDARD LVCMOS33} [get_ports GEPHY_TXEN_ER]
set_property -dict {PACKAGE_PIN AA11 IOSTANDARD LVCMOS33} [get_ports GEPHY_INT_N]
set_property -dict {PACKAGE_PIN AA10 IOSTANDARD LVCMOS33} [get_ports GEPHY_MDC]
set_property -dict {PACKAGE_PIN AB10 IOSTANDARD LVCMOS33} [get_ports GEPHY_MDIO]
create_clock -period 8.000 -name rgmii_rxclk -waveform {0.000 4.000} [get_ports GEPHY_RCK]

# DRAM
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN U5}  [get_ports {ddr3_addr[0]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN T5}  [get_ports {ddr3_addr[1]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN W4}  [get_ports {ddr3_addr[2]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN V4}  [get_ports {ddr3_addr[3]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN AA4} [get_ports {ddr3_addr[4]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN Y4}  [get_ports {ddr3_addr[5]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN AB5} [get_ports {ddr3_addr[6]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN AA5} [get_ports {ddr3_addr[7]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN AA3} [get_ports {ddr3_addr[8]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN Y3}  [get_ports {ddr3_addr[9]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN AB2} [get_ports {ddr3_addr[10]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN AB3} [get_ports {ddr3_addr[11]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN AB1} [get_ports {ddr3_addr[12]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN AA1} [get_ports {ddr3_addr[13]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN U6}  [get_ports {ddr3_ba[0]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN W5}  [get_ports {ddr3_ba[1]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN W6}  [get_ports {ddr3_ba[2]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN U1}  [get_ports {ddr3_dq[0]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN U2}  [get_ports {ddr3_dq[1]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN V2}  [get_ports {ddr3_dq[2]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN W2}  [get_ports {ddr3_dq[3]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN Y2}  [get_ports {ddr3_dq[4]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN W1}  [get_ports {ddr3_dq[5]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN Y1}  [get_ports {ddr3_dq[6]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN U3}  [get_ports {ddr3_dq[7]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN AA6} [get_ports {ddr3_cke[0]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN Y6}  [get_ports {ddr3_cs_n[0]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN T6}  [get_ports ddr3_we_n]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN R6}  [get_ports ddr3_cas_n]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN T1}  [get_ports {ddr3_dm[0]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN V7}  [get_ports {ddr3_odt[0]}]
set_property -dict {IOSTANDARD SSTL15 PACKAGE_PIN V5}  [get_ports ddr3_ras_n]
set_property -dict {IOSTANDARD DIFF_SSTL15 PACKAGE_PIN V8} [get_ports {ddr3_ck_n[0]}]
set_property -dict {IOSTANDARD DIFF_SSTL15 PACKAGE_PIN V9} [get_ports {ddr3_ck_p[0]}]
set_property -dict {IOSTANDARD DIFF_SSTL15 PACKAGE_PIN R2} [get_ports {ddr3_dqs_n[0]}]
set_property -dict {IOSTANDARD DIFF_SSTL15 PACKAGE_PIN R3} [get_ports {ddr3_dqs_p[0]}]
set_property -dict {IOSTANDARD LVCMOS15 PACKAGE_PIN R4} [get_ports ddr3_reset_n]

#
# Vision board
#
# HDMI CN2
set_property -dict {PACKAGE_PIN V20 IOSTANDARD TMDS_33} [get_ports TMDS_CN2_Clk_n]
set_property -dict {PACKAGE_PIN U20 IOSTANDARD TMDS_33} [get_ports TMDS_CN2_Clk_p]
set_property -dict {PACKAGE_PIN V22 IOSTANDARD TMDS_33} [get_ports {TMDS_CN2_Data_n[0]}]
set_property -dict {PACKAGE_PIN U22 IOSTANDARD TMDS_33} [get_ports {TMDS_CN2_Data_p[0]}]
set_property -dict {PACKAGE_PIN U21 IOSTANDARD TMDS_33} [get_ports {TMDS_CN2_Data_n[1]}]
set_property -dict {PACKAGE_PIN T21 IOSTANDARD TMDS_33} [get_ports {TMDS_CN2_Data_p[1]}]
set_property -dict {PACKAGE_PIN R19 IOSTANDARD TMDS_33} [get_ports {TMDS_CN2_Data_n[2]}]
set_property -dict {PACKAGE_PIN P19 IOSTANDARD TMDS_33} [get_ports {TMDS_CN2_Data_p[2]}]
set_property -dict {PACKAGE_PIN W21 IOSTANDARD LVCMOS33} [get_ports TMDS_CN2_SCL]
set_property -dict {PACKAGE_PIN W22 IOSTANDARD LVCMOS33} [get_ports TMDS_CN2_SDA]
set_property -dict {PACKAGE_PIN A21 IOSTANDARD LVCMOS33} [get_ports TMDS_CN2_OUT_EN]
set_property -dict {PACKAGE_PIN B21 IOSTANDARD LVCMOS33 PULLUP true} [get_ports TMDS_CN2_HPD]

# HDMI CN3
set_property -dict {PACKAGE_PIN W20  IOSTANDARD TMDS_33} [get_ports TMDS_CN3_Clk_n]
set_property -dict {PACKAGE_PIN W19  IOSTANDARD TMDS_33} [get_ports TMDS_CN3_Clk_p]
set_property -dict {PACKAGE_PIN Y19  IOSTANDARD TMDS_33} [get_ports {TMDS_CN3_Data_n[0]}]
set_property -dict {PACKAGE_PIN Y18  IOSTANDARD TMDS_33} [get_ports {TMDS_CN3_Data_p[0]}]
set_property -dict {PACKAGE_PIN V19  IOSTANDARD TMDS_33} [get_ports {TMDS_CN3_Data_n[1]}]
set_property -dict {PACKAGE_PIN V18  IOSTANDARD TMDS_33} [get_ports {TMDS_CN3_Data_p[1]}]
set_property -dict {PACKAGE_PIN AB20 IOSTANDARD TMDS_33} [get_ports {TMDS_CN3_Data_n[2]}]
set_property -dict {PACKAGE_PIN AA19 IOSTANDARD TMDS_33} [get_ports {TMDS_CN3_Data_p[2]}]
set_property -dict {PACKAGE_PIN AA20 IOSTANDARD LVCMOS33} [get_ports TMDS_CN3_SCL]
set_property -dict {PACKAGE_PIN AA21 IOSTANDARD LVCMOS33} [get_ports TMDS_CN3_SDA]
set_property -dict {PACKAGE_PIN D22  IOSTANDARD LVCMOS33} [get_ports TMDS_CN3_OUT_EN]
set_property -dict {PACKAGE_PIN E22 IOSTANDARD LVCMOS33 PULLUP true} [get_ports TMDS_CN3_HPD]

# GPIO
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33} [get_ports GPIO00]
set_property -dict {PACKAGE_PIN C15 IOSTANDARD LVCMOS33} [get_ports GPIO01]
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports GPIO02]
set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports GPIO03]
set_property -dict {PACKAGE_PIN B15 IOSTANDARD LVCMOS33} [get_ports GPIO04]
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports GPIO05]
set_property -dict {PACKAGE_PIN C13 IOSTANDARD LVCMOS33} [get_ports GPIO06]
set_property -dict {PACKAGE_PIN B13 IOSTANDARD LVCMOS33} [get_ports GPIO07]
set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33} [get_ports GPIO10]
set_property -dict {PACKAGE_PIN A16 IOSTANDARD LVCMOS33} [get_ports GPIO11]
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports GPIO12]
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports GPIO13]
set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports GPIO14]
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports GPIO15]
set_property -dict {PACKAGE_PIN C18 IOSTANDARD LVCMOS33} [get_ports GPIO20]
set_property -dict {PACKAGE_PIN C19 IOSTANDARD LVCMOS33} [get_ports GPIO21]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS33} [get_ports GPIO22]
set_property -dict {PACKAGE_PIN A20 IOSTANDARD LVCMOS33} [get_ports GPIO23]
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports GPIO24]
set_property -dict {PACKAGE_PIN A19 IOSTANDARD LVCMOS33} [get_ports GPIO25]
set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS33} [get_ports GPIO26]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD LVCMOS33} [get_ports GPIO27]
set_property -dict {PACKAGE_PIN C22 IOSTANDARD LVCMOS33} [get_ports GPIO30]
set_property -dict {PACKAGE_PIN B22 IOSTANDARD LVCMOS33} [get_ports GPIO31]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports GPIO40]
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports GPIO41]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports GPIO42]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33} [get_ports GPIO43]
set_property -dict {PACKAGE_PIN J22 IOSTANDARD LVCMOS33} [get_ports GPIO44]
set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS33} [get_ports GPIO45]
set_property -dict {PACKAGE_PIN H20 IOSTANDARD LVCMOS33} [get_ports GPIO46]
set_property -dict {PACKAGE_PIN G20 IOSTANDARD LVCMOS33} [get_ports GPIO47]
set_property -dict {PACKAGE_PIN K21 IOSTANDARD LVCMOS33} [get_ports GPIO50]
set_property -dict {PACKAGE_PIN K22 IOSTANDARD LVCMOS33} [get_ports GPIO51]
set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS33} [get_ports GPIO52]
set_property -dict {PACKAGE_PIN L21 IOSTANDARD LVCMOS33} [get_ports GPIO53]
set_property -dict {PACKAGE_PIN J20 IOSTANDARD LVCMOS33} [get_ports GPIO54]
set_property -dict {PACKAGE_PIN J21 IOSTANDARD LVCMOS33} [get_ports GPIO55]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports GPIO60]
set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVCMOS33} [get_ports GPIO61]
set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVCMOS33} [get_ports GPIO62]
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports GPIO63]
set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVCMOS33} [get_ports GPIO64]
set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVCMOS33} [get_ports GPIO65]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports GPIO66]
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports GPIO67]
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports GPIO70]
set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVCMOS33} [get_ports GPIO71]
set_property -dict {PACKAGE_PIN N20 IOSTANDARD LVCMOS33} [get_ports GPIO72]
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports GPIO73]
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports GPIO74]
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports GPIO75]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
```
