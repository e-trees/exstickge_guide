---
title: Top
type: docs
---

# exStickGE Quick Guide

## exStickGEについて

- [ボード概要]({{< ref "/docs/about/board_overview.md" >}})

## セットアップ

- [インストール]({{< ref "/docs/setup/installation.md" >}})
- [exStickGEでLチカ]({{< ref "/docs/setup/blink_led.md" >}})
- [サンプルのビルドと実行]({{< ref "/docs/setup/build_examples.md" >}})

## 付属UDP/IP IPコアの利用

- [UDP/IP IPコア概要]({{< ref "/docs/udpip/udpip_overview.md" >}})
- [パケットの送受信]({{< ref "/docs/udpip/sendrecv_packet.md" >}})

## 搭載デバイスの利用

- [DDR DRAMの利用]({{< ref "/docs/devices/dram_guide.md" >}})

## サンプル事例
- [exStickGE_udpip_loopback](https://github.com/e-trees/exstickge_samples/tree/master/exStickGE_udpip_loopback)
  - exStickGEに到達したUDPパケットを折り返すだけのサンプルです．コアのインスタンス生成方法の確認に．
- [exStickGE_hdmi2udp](https://github.com/e-trees/exstickge_samples/tree/master/exStickGE_hdmi2udp)
  - ビジョン基板上のHDMIから入力された画像をUDPパケットで出力するサンプルです．
- [exStickGE_dramrw](https://github.com/e-trees/exstickge_samples/tree/master/exStickGE_dramrw)
  - UDPパケットでexStickGEに搭載されたDRAMを読み書きするサンプルです．DRAMを利用する場合のエントリポイントに．
- [exStickGE_dram_hdmiout](https://github.com/e-trees/exstickge_samples/tree/master/exStickGE_dram_hdmiout)
  - DRAMに書き込んだ画像イメージをビジョン基板上のHDMIから出力するサンプルです
  - 詳細は，[exStickGEでHDMI表示をしてみた](https://e-trees.jp/wp/2020/05/06/post-483/)をご覧ください．
- [exStickGE_hdmi2dram2udp](https://github.com/e-trees/exstickge_samples/tree/master/exStickGE_hdmi2dram2udp)
  - ビジョン基板上のHDMIから入力された画像をDRAMに保存した後でUDPで出力するサンプルです
  - 詳細は，[exStickGEでHDMIの画像を取得してみた](https://e-trees.jp/wp/2020/05/06/post-503/)をご覧ください．
- [exStickGE_imageprocessing](https://github.com/e-trees/exstickge_samples/tree/master/exStickGE_imageprocessing)
  - ビジョン基板上のHDMIから入力された画像をDRAMに保存し，フィルタ処理を適用してUDPで出力するサンプルです
  - 詳細は，[exStickGEで画像にフィルタをかけてみた](https://e-trees.jp/wp/2020/05/27/post-524/)をご覧ください．

## LICENSE

[![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)
This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/)
