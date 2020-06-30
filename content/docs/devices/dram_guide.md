---
title: "DDR DRAMを利用する"
date: 2019-10-30T19:15:46+09:00
type: docs
draft: false
weight: -4400
bookToc: true
---

# DDR DRAMの利用

exStickGEは256MBのDDR DRAMを搭載しています．FPGA内のBRAMには収まらないデータを扱うために利用できます．

## XilinxのMIGを使うサンプル

DDR DRAMは，XilinxのMIGで生成したIPコアを使ってアクセスするのが便利です．Vivadoの Preferred Language を Verilog に指定しておくと，MIGで生成するコアでAXI4インターフェースを利用できて便利です(Preferred Language を Verilog に設定しても 他のモジュールをVHDLで記述することができます)．

exStickGEのサンプル [exStickGE\_test](https://github.com/e-trees/exstickge_samples/tree/master/exStickGE_test) で DDR DRAMを利用する簡単なサンプルを公開しています．このサンプルでは，`axi4m_to_fifo`および`fifo_to_axi4m`を介して，`VIO`を使ってDDR DRAMメモリを読み書きできます．

MIGに設定するパラメタは，[mig\_a.prj](https://github.com/e-trees/exstickge_samples/blob/master/exStickGE_test/ip/mig_a.prj)と，MIGで作ったIPコアのインスタンス生成と接続は[top.v](https://github.com/e-trees/exstickge_samples/blob/master/exStickGE_test/sources/top.v)を，それぞれ参照してください．

