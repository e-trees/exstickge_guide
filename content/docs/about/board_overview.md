---
title: "ボード概要"
date: 2019-10-30T19:15:46+09:00
type: docs
draft: false
weight: -8000
bookToc: true
---

# ボード概要

## exStickGE - UDP/IPを手軽に利用できるFPGAボード

exStickGEは，Artix-7を搭載したギガビットイーサネットポートを持つFPGAボードです．同梱のe7UDP/IP IPコアを使うことで，簡単にネットワーク接続アプリケーション実装できます．拡張コネクタで約80ポートのI/Oを利用できます．標準構成では，HDMIおよびMIPI-CSIポートを搭載したビジョンボードとの組合せで提供されます．

{{<figure src="../figures/exstickge.png" class="center" width="480">}}

## メイン基板
メイン基板は，FPGAとイーサネットポートを搭載するシンプルな構成です．LEDやスイッチ，PMODポートを搭載しています．DC 5Vを供給して利用します．

{{<figure src="../figures/exstickge_main_a.png" class="center" width="480">}}

FPGAの裏には，256MBのDDRメモリと拡張コネクタを搭載しています．

{{<figure src="../figures/exstickge_main_b.png" class="center" width="480">}}

### メイン基板搭載部品

  　　           | 型番・パラメタ
-----------------|---------------------
  FPGA           | XC7A200TSBG484-2
  コンフィグROM  | MT25QL128ABA1ESE-0SIT
  ユーザクロック | 200MHz
  DDRメモリ      | MT41K128M16JT-125
  Ethernet PHY   | RTL8211E-VB
  電源コネタク   | DF1B-2P-2.5DS(1ピン: 5V, 2ピン: GND)
  拡張コネクタ   | DF40C-100DP-0.4V

## ビジョン基板

ビジョン基板は拡張コネクタの先に接続できる画像処理アプリケーション実装向けのボードです．HDMIポートとMIPI CSI-2をそれぞれ2ポートずつ搭載します．また2.54mmピッチ40ピンコネタクを介して，26ポートのGPIOを利用できます．

{{<figure src="../figures/exstickge_vision.png" class="center" width="480">}}

## 参考リンク

製品の詳細は，e-trees.Japanの製品ページ[101「exStickGE」](https://e-trees.jp/exstickge-2/)もご覧ください．また，製品についての問い合わせは，e-trees.Japanの[問い合わせ](https://e-trees.jp/contact/)フォームよりご連絡ください．

