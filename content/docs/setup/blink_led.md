---
title: "exStickGEでLチカ"
date: 2019-10-30T19:15:46+09:00
type: docs
draft: false
weight: -4900
bookToc: true
---

# exStickGEでLチカ

ボードの動作確認のために，exStickGEのLEDをチカチカさせてみましょう．ここでは，サンプルコードをVivadoを使って合成してFPGA用のビットファイルを作成，exStickGEで動かしてみるまでの手順を紹介します．

## ソースコード

exStickGEのメインボードに搭載されている3つのLEDを順に点灯させる次のようなモジュールでLチカしてみましょう．これを `blinkled.v` という名前で保存します．

```blinkled.v
`default_nettype none

module blinkled
  (
   input wire SYS_CLK_P,
   input wire SYS_CLK_N,
   input wire PUSH_BTN,
   output wire [2:0] LED
   );
    
    reg[31:0] counter;
    wire SYS_CLK;

    IBUFDS SYS_CLK_BUF(.I(SYS_CLK_P),.IB(SYS_CLK_N),.O(SYS_CLK));
					   
    assign LED = counter[26:25] == 2'b01 ? 3'b001 :
                 counter[26:25] == 2'b10 ? 3'b010 :
                 counter[26:25] == 2'b11 ? 3'b100 :
                 3'b000;
    
    always @(posedge SYS_CLK) begin
        if(PUSH_BTN == 1'b0) begin
	        counter <= 32'd0;
	    end else begin
	        counter <= counter + 32'd1;
	    end
    end

endmodule

`default_nettype wire
```

また，ピン配置の制約を以下のように与えます．こちらは`exstickge.xdc`という名前で保存しておきます．

```tcl
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
```

## Vivadoでプロジェクトを作成

exStickGE向けのビットファイルを作成するためにVivadoのプロジェクトを作成します．
Vivadoを起動して `Create Project` をクリックしてウィザードを開きます．
{{<figure src="../figures/start_vivado.png" class="center" width="700">}}

プロジェクト作成のウィザードが開きました．`Next`で次にすすみます．
{{<figure src="../figures/start_to_create_prj.png" class="center" width="500">}}
プロジェクト名と保存先のディレクトリを指定します．ここでは`exstickge_blinkled`という名前をつけています．
{{<figure src="../figures/set_prj_name.png" class="center" width="500">}}
プロジェクトのタイプはデフォルトの `RTL Project` のまますすみます．
{{<figure src="../figures/select_prj_type.png" class="center" width="500">}}
プロジェクトに追加するソースコードファイルを選択できます．ここではスキップして，そのまま `Next` をクリックします．
{{<figure src="../figures/skip_src.png" class="center" width="350">}}
プロジェクトに追加する制約ファイルを選択できます．ここではスキップして，そのまま `Next` をクリックします．
{{<figure src="../figures/skip_xdc.png" class="center" width="350">}}
`Default Part`で，利用するFPGAを選択します．exStickGE用のボードファイルをインストールしていれば，`Boards`タブから，`exStickGE`を選択できます．
{{<figure src="../figures/select_exstickge.png" class="center" width="500">}}
exStickGE用のボードファイルをインストールしていない場合は`Parts`タブで`xc7a200tsbg484-2`を選びます．
{{<figure src="../figures/select_artix.png" class="center" width="500">}}
プロジェクト作成ウィザードのサマリです．プロジェクト名，保存先ディレクトリ，正しくFPGAが選択できているかを確認して`Done`をクリックします．
{{<figure src="../figures/prj_summary.png" class="center" width="500">}}

## ファイルの追加
プロジェクトの作成が終わったところです．
ウィンドウ左のFlow Navigatorペインにある`Add Sources`をクリックしてファイルを追加します．
{{<figure src="../figures/after_creating_prj.png" class="center" width="600">}}
まずは，ソースコードファイルを追加したいので，`Add or create design sources`を選択して`Next`をクリックします．
{{<figure src="../figures/wizard_to_add_src.png" class="center" width="500">}}
ファイル追加ダイアログが開くので，`Add Files`をクリックします．
{{<figure src="../figures/add_source_1.png" class="center" width="500">}}
追加するファイルをファイル選択ダイアログで選びます．冒頭で紹介した`blink_led.v`ファイルを選択して`OK`をクリックします．
{{<figure src="../figures/add_source_2.png" class="center" width="500">}}
ファイルをプロジェクトに追加する準備ができました．`Finish`をクリックしてウィザードを終了します．
{{<figure src="../figures/add_source_3.png" class="center" width="500">}}

プロジェクトにソースコードファイルが登録されました．制約ファイルを追加するために，もう一度，`Add Sources`をクリックしてファイルを追加するウィザードを開きます．
{{<figure src="../figures/added_source.png" class="center" width="600">}}
今度は，制約ファイルを追加するために，`Add or create constraints`を選択して`Next`をクリックします．
{{<figure src="../figures/wizard_to_add_xdc.png" class="center" width="500">}}
ファイル追加ダイアログが開くので，`Add Files`をクリックします．
{{<figure src="../figures/start_to_add_xdc.png" class="center" width="500">}}
追加するファイルをファイル選択ダイアログで選びます．冒頭で紹介した`exstickge.xdc`ファイルを選択して`OK`をクリックします．
{{<figure src="../figures/select_xdc.png" class="center" width="500">}}
ファイルをプロジェクトに追加する準備ができました．`Finish`をクリックしてウィザードを終了します．
{{<figure src="../figures/add_xdc.png" class="center" width="500">}}

## 合成
合成するには，ウィンドウ左のFlow Navigatorペインにある`Generate Bitstream`をクリックします．これで，ソースコードからFPGAのビットストリームを生成するのに必要な，`Synthesis`と`Implementation`が順に実行されます．
{{<figure src="../figures/generate_bitfile.png" class="center" width="600">}}
無事に合成が完了すると，`Bitstream Generation Completed`ダイアログがあらわれます．`Open Hardware Manager`を選択して`OK`をクリックしましょう．
{{<figure src="../figures/generated_bitfile.png" class="center" width="300">}}
もし，下のようなエラーダイアログが表示されてしまったら，ここまでの手順を再度確認してください．
{{<figure src="../figures/synthesis_error.png" class="center" width="200">}}
なお，生成されたビットファイルは，`<プロジェクトディレクトリ>/<プロジェクト>.runs/impl_1/blinkled.bit`です．

## FPGAに書き込む
パソコンとFPGAをJTAGケーブルで接続し，電源を供給します．
{{<figure src="../figures/exstickge_connect.jpg" class="center" width="400">}}
`Bitstream Generation Completed`ダイアログで`Open Hardware Manager`を選択するか，`Flow Navigator`で`Open Hardware Manager`をクリックしてハードウェアマネージャを開きます．ハードウェアマネージャの上，緑のバーの`Open target`をクリックし，`Auto Connect`をクリックしてFPGAとの接続を確立しましょう．
{{<figure src="../figures/connect_fpga.png" class="center" width="600">}}
正しく接続できていれば，FPGAが認識されます．
{{<figure src="../figures/detect_fpga.png" class="center" width="600">}}
FPGAにマウスカーソルを合わせ右クリックしてコンテクストメニューを開き，`Program Device...`を選択します．
{{<figure src="../figures/fpga_programming.png" class="center" width="600">}}
生成されたビットストリームファイル`blinkled.bit`を選択して`Program`をクリックします．書き込みが完了するとボード上の3つのLEDが順々に点滅する様子が確認できます．
{{<figure src="../figures/select_bitfile.png" class="center" width="400">}}
