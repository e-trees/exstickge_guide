---
title: "パケットを送受信してみる"
date: 2019-10-30T19:15:46+09:00
type: docs
draft: false
weight: -4500
bookToc: true
---

# パケットを送受信してみる

e7UDP/IP IPコアを使ったパケット送受信方法を説明します．

## ループバック
exStickGEで受信したパケットをそのまま送信するループバックしてみます．これは単に，IPコアの出力UPLを入力UPLに接続するだけで実現できます．

ソースコードは，[exstickge_samples/exStickGE_udpip_loopback/sources/top.v](https://github.com/e-trees/exstickge_samples/blob/master/exStickGE_udpip_loopback/sources/top.v) をご覧ください．

```verilog
   assign pUdp0Send_Data    = pUdp0Receive_Data;
   assign pUdp0Send_Request = pUdp0Receive_Request;
   assign pUdp0Receive_Ack  = pUdp0Send_Ack;
   assign pUdp0Send_Enable  = pUdp0Receive_Enable;
   
   assign pUdp1Send_Data    = pUdp1Receive_Data;
   assign pUdp1Send_Request = pUdp1Receive_Request;
   assign pUdp1Receive_Ack  = pUdp1Send_Ack;
   assign pUdp1Send_Enable  = pUdp1Receive_Enable;
```

の部分がループバックに相当します．

## UDP/IPパケットを送信する
UDP/IPパケットを送信するには，[UDP/IP IPコア概要]({{< ref "/docs/udpip/udpip_overview.md" >}})で紹介した，次のフォーマットに従ったデータ列をUPLから入力します．

\#  | 内容
--- |-----------------------------------------
0   | 送信送り元IPアドレス(exStickGEのIPアドレス)
1   | 送信先IPアドレス
2   | 送信元ポート番号，送信先ポート番号,
3   | データバイト数
4〜 | データ

適当なステートマシンで，UPLフォーマットに従ったデータ列を生成することで任意のUDPパケットをexStickGEから送出できます．

## UDP/IPパケットを受信する
受信したUDP/IPパケットをユーザロジックで利用するには，[UDP/IP IPコア概要]({{< ref "/docs/udpip/udpip_overview.md" >}})で紹介した，次のフォーマットのデータ列をUPLから受け取ります．

\#  | 内容
--- |-----------------------------------------
0   | 送信送り元IPアドレス(exStickGEのIPアドレス)
1   | 送信先IPアドレス
2   | 送信元ポート番号，送信先ポート番号,
3   | データバイト数
4〜 | データ

適当なステートマシンで，UPLフォーマットに従ったデータ列を解析してデータ部分を取り出すことで，exStickGEが受信したデータをユーザロジックで利用できます．
