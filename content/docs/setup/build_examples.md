---
title: "サンプルのビルドと実行"
date: 2019-10-30T19:15:46+09:00
type: docs
draft: false
weight: -4800
bookToc: true
---

# サンプルのビルドと実行

exStickGEのサンプルはGitHubの[e-trees/exstickge_samples](https://github.com/e-trees/exstickge_samples)リポジトリで公開されています．各サンプルのビルドは次の通りです．なお，サンプルは，Vivado 2019.1でビルドすることが想定されています．

1. リポジトリをクローンする
1. IPコアを`edif`ディレクトリ下にコピー
1. ビルドしたいプロジェクトをスクリプトでビルド
1. 生成したビットファイルをFPGAに書き込み
1. 操作

以下，それぞれの手順の詳細を説明します．

## リポジトリのクローン

リポジトリを手元にダウンロードしてください．

CUIで，以下のコマンドを実行するか，

```shell
$ git clone https://github.com/e-trees/exstickge_samples.git
```

または，GUIのGitクライアントで https://github.com/e-trees/exstickge_samples.git をクローンしてください．

## IPコアの配置

IPコアは，リポジトリにアップロードされていません．exStickGEを購入した時のガイドに従って，`e7udpip_rgmii_artix7.edif`を入手し，`exsticge_samples/edif` の下にコピーしてください．

なお，対応するedifのmd5値は，[e7udpip_rgmii_artix7.edif.md5](https://github.com/e-trees/exstickge_samples/blob/master/edif/e7udpip_rgmii_artix7.edif.md5) の通りです．ビルドや動作がうまくいかない場合には，手元のIPコアのmd5値のご確認の上，[お問い合わせ](https://e-trees.jp/contact/)よりご連絡ください．

## ビルド

各サンプルは，それぞれのビルドスクリプト `create_project.tcl` でビルドできます．たとえば，受信パケットを折り返して送信するプロジェクト `exStickGE_udpip_loopback` をビルドする手順は次の通りです．

### Linuxの場合

```shell
$ source /tools/Xilinx/Vivado/2019.1/settings64.sh
$ cd exstickge_samples/exStickGE_udpip_loopback
$ vivado -mode batch -source ./create_project.tcl
```

### Windowsの場合

スタートメニューから，VivadoのDOSプロントを開き，

```shell
$ cd exstickge_samples\exStickGE_udpip_loopback
$ vivado -mode batch -source create_project.tcl
```

### ビルド結果の確認

ビルド結果は，ログファイルで確認できるほか，生成されるプロジェクトファイル(`prj/*.xpr`)をVivadoで開いて確認することができます．

## ビットファイルの書き込み

ビットファイルは，`prj/*.runs/impl_1/`の下に作成されます．`exStickGE_udpip_loopback` であれば，`prj/exstickge_udpip_loopback.runs/impl_1/top.bit`です．VivadoのHardware ManagerでFPGAに書き込んでください．

## 操作

サンプルの多くはPCとネットワーク接続してアクセスできます．たとえば，`exStickGE_udpip_loopback`に対しては，次のようなRubyスクリプトでexStickGEに対してパケットの送受信ができます．

```ruby
#!/usr/bin/ruby
# exStickGEにパケットを送信する
require "socket"
socket = UDPSocket.open()
sockaddr = Socket.pack_sockaddr_in(0x4000, "10.0.0.3")
socket.send("Hello World", 0, sockaddr)
socket.close
```

```ruby
#!/usr/bin/ruby
# exStickGEからパケットを受信する
require "socket"
socket = UDPSocket.open()
socket.bind("0.0.0.0", 0x4000)
p socket.recv(65535)
socket.close
```

いくつかのサンプルは，node.jsとElectronを使って動作を確認できます．
