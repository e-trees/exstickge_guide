---
title: "UDP/IP IPコア概要"
date: 2019-10-30T19:15:46+09:00
type: docs
draft: false
weight: -4600
bookToc: true
---

# UDP/IP IPコア概要

UDP/IP IPコアはユーザロジックで簡単にUDP/IPパケットを送受信できるe-trees製のIPコアです．コアとユーザロジックは，e-treesでUPLと呼んでいる制御機構付きFIFOのようなインターフェースでデータをやりとりします．[e7UDP/IP商品ページ](https://e-trees.jp/e7-udp-ip/)および，[UPLとは](https://e-trees.jp/upl%e3%81%a8%e3%81%af/)もご覧ください．

## IPコア 入出力I/F

### クロック・リセット

MACアクセス用のクロック(125MHz)と，ユーザロジック用のクロックを供給します．

ポート名             | 幅   | 方向 | 説明
---------------------|------|------|----------------------------------------
GEPHY\_MAC\_CLK      | 1    | 入力 | MAC用入力クロック(125MHz)
GEPHY\_MAC\_CLK90    | 1    | 入力 | 90度シフトしたMAC用入力クロック(125MHz)
Reset\_n             | 1    | 入力 | コアのリセット(非同期・負論理)
pUPLGlobalClk        | 1    | 入力 | ユーザロジックのクロック


### MAC入出力

MACに接続するポートです．FPGAのI/Oに接続します．

ポート名             | 幅   | 方向   | 説明
---------------------|------|--------|----------------------------------------
GEPHY\_RST\_N        | 1    | 出力   | コアへのリセット出力
GEPHY\_TD            | 4    | 出力   | MACへのデータ出力
GEPHY\_TXEN\_ER      | 1    | 出力   |
GEPHY\_TCK           | 1    | 出力   | 出力クロック
GEPHY\_RD            | 4    | 入力   | MACからのデータ入力
GEPHY\_RCK           | 1    | 入力   | 入力クロック
GEPHY_RXDV_ER        | 1    | 入力   | 
GEPHY\_MDC           | 1    | 出力   | MIO クロック
GEPHY\_MDIO          | 1    | 入出力 | MIO データ
GEPHY\_INT\_N        | 1    | 入力   |
		
		
### ユーザロジック入出力

ユーザロジックからUDPパケットを送信する，到着したUDPパケットをユーザロジックで受け取るためのUPLポートです．MIIデータもUPLでやりとりします．

#### ユーザロジック → UDP/IP IPコア (パケット送信)

ポート名             | 幅   | 方向   | 説明
---------------------|------|--------|----------------------------------------
pUdp0Send\_Data      | 32   | 入力   | UDPパケット送信データの入力データ(ポート0)
pUdp0Send\_Request   | 1    | 入力   | UDPパケット送信データの入力制御信号(ポート0)
pUdp0Send\_Ack       | 1    | 出力   | UDPパケット送信データの入力制御信号(ポート0)
pUdp0Send\_Enable    | 1    | 入力   | UDPパケット送信データの入力制御信号(ポート0)
pUdp1Send\_Data      | 32   | 入力   | UDPパケット送信データの入力データ(ポート1)
pUdp1Send\_Request   | 1    | 入力   | UDPパケット送信データの入力制御信号(ポート1)
pUdp1Send\_Ack       | 1    | 出力   | UDPパケット送信データの入力制御信号(ポート1)
pUdp1Send\_Enable    | 1    | 入力   | UDPパケット送信データの入力制御信号(ポート1)
		
#### UDP/IP IPコア → ユーザロジック (パケット受信)

ポート名             | 幅   | 方向   | 説明
---------------------|------|--------|----------------------------------------
pUdp0Receive\_Data   | 32   | 出力   | UDPパケット受信データの出力データ(ポート0)
pUdp0Receive\_Request| 1    | 出力   | UDPパケット受信データの出力制御信号(ポート0)
pUdp0Receive\_Ack    | 1    | 入力   | UDPパケット受信データの出力制御信号(ポート0)
pUdp0Receive\_Enable | 1    | 出力   | UDPパケット受信データの出力制御信号(ポート0)
pUdp1Receive\_Data   | 32   | 出力   | UDPパケット受信データの出力データ(ポート0)
pUdp1Receive\_Request| 1    | 出力   | UDPパケット受信データの出力制御信号(ポート0)
pUdp1Receive\_Ack    | 1    | 入力   | UDPパケット受信データの出力制御信号(ポート0)
pUdp1Receive\_Enable | 1    | 出力   | UDPパケット受信データの出力制御信号(ポート0)
        
#### MIIインターフェース

ポート名             | 幅   | 方向   | 説明
---------------------|------|--------|----------------------------------------
pMIIInput\_Data      | 32   | 入力   |
pMIIInput\_Request   | 1    | 入力   | 
pMIIInput\_Ack       | 1    | 出力   | 
pMIIInput\_Enable    | 1    | 入力   | 
pMIIOutput\_Data     | 32   | 出力   |
pMIIOutput\_Request  | 1    | 出力   | 
pMIIOutput\_Ack      | 1    | 入力   |
pMIIOutput\_Enable   | 1    | 出力   |
		
### 設定用パラレルポート

IPアドレス，MACアドレス，UDP送受信ポート番号などはパラレルポートでコアに設定します．

ポート名             | 幅   | 方向   | 説明
---------------------|------|--------|----------------------------------------
pMyIpAddr            | 32   | 入力   | IPアドレス
pMyMacAddr           | 48   | 入力   | MACアドレス
pMyNetmask           | 32   | 入力   | ネットマスク
pDefaultGateway      | 32   | 入力   | デフォルトゲートウェア
pTargetIPAddr        | 32   | 入力   | -
pMyUdpPort0          | 16   | 入力   | ポート0のポート番号
pMyUdpPort1          | 16   | 入力   | ポート1のポート番号
pPHYAddr             | 5    | 入力   | PHYのアドレス
pPHYMode             | 4    | 入力   | PHYのモード(4'b1000)でGbEに設定
pConfig\_Core        | 32   | 入力   | 

### モニタリング信号

コアの動作をモニタリングするためのステータスがパラレルポートを出力します．特にモニタリングする必要がなければオープンにしてください．

ポート名                         | 幅   | 方向   | 説明
---------------------------------|------|--------|----------------------------------------
pStatus\_RxByteCount             | 32   | 出力   |
pStatus\_RxPacketCount           | 32   | 出力   |
pStatus\_RxErrorPacketCount      | 16   | 出力   |
pStatus\_RxDropPacketCount       | 16   | 出力   |
pStatus\_RxARPRequestPacketCount | 16   | 出力   |
pStatus\_RxARPReplyPacketCount   | 16   | 出力   |
pStatus\_RxICMPPacketCount       | 16   | 出力   |
pStatus\_RxUDP0PacketCount       | 16   | 出力   |
pStatus\_RxUDP1PacketCount       | 16   | 出力   |
pStatus\_RxIPErrorPacketCount    | 16   | 出力   |
pStatus\_RxUDPErrorPacketCount   | 16   | 出力   |
pStatus\_TxByteCount             | 32   | 出力   |
pStatus\_TxPacketCount           | 32   | 出力   |
pStatus\_TxARPRequestPacketCount | 16   | 出力   |
pStatus\_TxARPReplyPacketCount   | 16   | 出力   |
pStatus\_TxICMPReplyPacketCount  | 16   | 出力   |
pStatus\_TxUDP0PacketCount       | 16   | 出力   |
pStatus\_TxUDP1PacketCount       | 16   | 出力   |
pStatus\_TxMulticastPacketCount  | 16   | 出力   |
pStatus\_Phy                     | 16   | 出力   |

### IPコア用デバッグ信号

一般にユーザは利用しません．オープンにしてください．

ポート名             | 幅   | 方向   | 説明
---------------------|------|--------|----------------------------------------
pdebug               | 64   | 出力   |


## UPL



## Verilogインタンステンプレート

### インスタンス生成文

```verilog
  idelayctrl_wrapper#(.CLK_PERIOD(5))(.clk(clk200M), .reset(reset200M), .ready());
  
  e7udpip_rgmii_artix7
  u_e7udpip (
    // GMII PHY
    .GEPHY_RST_N(GEPHY_RST_N),
    .GEPHY_MAC_CLK(clk125M),
    .GEPHY_MAC_CLK90(clk125M_90),
    // TX out
    .GEPHY_TD(GEPHY_TD),
    .GEPHY_TXEN_ER(GEPHY_TXEN_ER),
    .GEPHY_TCK(GEPHY_TCK),
    // RX in
    .GEPHY_RD(GEPHY_RD),
    .GEPHY_RCK(GEPHY_RCK),
    .GEPHY_RXDV_ER(GEPHY_RXDV_ER),
    
    .GEPHY_MDC(GEPHY_MDC),
    .GEPHY_MDIO(GEPHY_MDIO),
    .GEPHY_INT_N(GEPHY_INT_N),
    
    // Asynchronous Reset
    .Reset_n(~reset125M),
    
    // UPL interface
    .pUPLGlobalClk(clk125M),
    
    // UDP tx input
    .pUdp0Send_Data(pUdp0Send_Data),
    .pUdp0Send_Request(pUdp0Send_Request),
    .pUdp0Send_Ack(pUdp0Send_Ack),
    .pUdp0Send_Enable(pUdp0Send_Enable),
    
    .pUdp1Send_Data(pUdp1Send_Data),
    .pUdp1Send_Request(pUdp1Send_Request),
    .pUdp1Send_Ack(pUdp1Send_Ack),
    .pUdp1Send_Enable(pUdp1Send_Enable),
    
    // UDP rx output
    .pUdp0Receive_Data(pUdp0Receive_Data),
    .pUdp0Receive_Request(pUdp0Receive_Request),
    .pUdp0Receive_Ack(pUdp0Receive_Ack),
    .pUdp0Receive_Enable(pUdp0Receive_Enable),
    
    .pUdp1Receive_Data(pUdp1Receive_Data),
    .pUdp1Receive_Request(pUdp1Receive_Request),
    .pUdp1Receive_Ack(pUdp1Receive_Ack),
    .pUdp1Receive_Enable(pUdp1Receive_Enable),
    
    // MII interface
    .pMIIInput_Data(pMIIInput_Data),
    .pMIIInput_Request(pMIIInput_Request),
    .pMIIInput_Ack(pMIIInput_Ack),
    .pMIIInput_Enable(pMIIInput_Enable),
    
    .pMIIOutput_Data(pMIIOutput_Data),
    .pMIIOutput_Request(pMIIOutput_Request),
    .pMIIOutput_Ack(pMIIOutput_Ack),
    .pMIIOutput_Enable(pMIIOutput_Enable),
    
    // Setup
    .pMyIpAddr(32'h0a000003),
    .pMyMacAddr(48'h001b1affffff),
    .pMyNetmask(32'hff000000),
    .pDefaultGateway(32'h0a0000fe),
    .pTargetIPAddr(32'h0a000001),
    .pMyUdpPort0(16'h4000),
    .pMyUdpPort1(16'h4001),
    .pPHYAddr(5'b00001),
    .pPHYMode(4'b1000),
    .pConfig_Core(8'b00000000),
    
    // Status
    .pStatus_RxByteCount(),
    .pStatus_RxPacketCount(),
    .pStatus_RxErrorPacketCount(),
    .pStatus_RxDropPacketCount(),
    .pStatus_RxARPRequestPacketCount(),
    .pStatus_RxARPReplyPacketCount(),
    .pStatus_RxICMPPacketCount(),
    .pStatus_RxUDP0PacketCount(),
    .pStatus_RxUDP1PacketCount(),
    .pStatus_RxIPErrorPacketCount(),
    .pStatus_RxUDPErrorPacketCount(),
    
    .pStatus_TxByteCount(),
    .pStatus_TxPacketCount(),
    .pStatus_TxARPRequestPacketCount(),
    .pStatus_TxARPReplyPacketCount(),
    .pStatus_TxICMPReplyPacketCount(),
    .pStatus_TxUDP0PacketCount(),
    .pStatus_TxUDP1PacketCount(),
    .pStatus_TxMulticastPacketCount(),
    
    .pStatus_Phy(status_phy),
    
    .pdebug()
    );
```

### Verilog用スタブ
次のコードは，edifファイルを組み込むためのスタブファイルです．入出力ポートの向きやサイズの確認にご利用ください．

```verilog
module e7udpip_rgmii_artix7(
  output wire        GEPHY_RST_N,
  input wire         GEPHY_MAC_CLK,
  input wire         GEPHY_MAC_CLK90,
  // TX out
  output wire [3:0]  GEPHY_TD,
  output wire        GEPHY_TXEN_ER,
  output wire        GEPHY_TCK,
  // RX in
  input wire [3:0]   GEPHY_RD,
  input wire         GEPHY_RCK,
  input wire         GEPHY_RXDV_ER,
  //Management I/F
  output wire        GEPHY_MDC,
  inout wire         GEPHY_MDIO,
  input wire         GEPHY_INT_N,
  
  // Asynchronous Reset
  input wire         Reset_n,
  
  // UPL interface
  input wire         pUPLGlobalClk,
  
  // UDP tx input
  input wire [31:0]  pUdp0Send_Data,
  input wire         pUdp0Send_Request,
  output wire        pUdp0Send_Ack,
  input wire         pUdp0Send_Enable,
  
  input wire [31:0]  pUdp1Send_Data,
  input wire         pUdp1Send_Request,
  output wire        pUdp1Send_Ack,
  input wire         pUdp1Send_Enable,
  
  // UDP rx output
  output wire [31:0] pUdp0Receive_Data,
  output wire        pUdp0Receive_Request,
  input wire         pUdp0Receive_Ack,
  output wire        pUdp0Receive_Enable,
  
  output wire [31:0] pUdp1Receive_Data,
  output wire        pUdp1Receive_Request,
  input wire         pUdp1Receive_Ack,
  output wire        pUdp1Receive_Enable,
  
  // MII interface
  input wire [31:0]  pMIIInput_Data,
  input wire         pMIIInput_Request,
  output wire        pMIIInput_Ack,
  input wire         pMIIInput_Enable,
  
  output wire [31:0] pMIIOutput_Data,
  output wire        pMIIOutput_Request,
  input wire         pMIIOutput_Ack,
  output wire        pMIIOutput_Enable,
  
  // Setup
  input wire [31:0]  pMyIpAddr,
  input wire [47:0]  pMyMacAddr,
  input wire [31:0]  pMyNetmask,
  input wire [31:0]  pDefaultGateway,
  input wire [31:0]  pTargetIPAddr,
  input wire [15:0]  pMyUdpPort0,
  input wire [15:0]  pMyUdpPort1,
  input wire [4:0]   pPHYAddr,
  input wire [3:0]   pPHYMode,
  input wire [31:0]  pConfig_Core,
  
  //Status
  output wire [31:0] pStatus_RxByteCount,
  output wire [31:0] pStatus_RxPacketCount,
  output wire [15:0] pStatus_RxErrorPacketCount,
  output wire [15:0] pStatus_RxDropPacketCount,
  output wire [15:0] pStatus_RxARPRequestPacketCount,
  output wire [15:0] pStatus_RxARPReplyPacketCount,
  output wire [15:0] pStatus_RxICMPPacketCount,
  output wire [15:0] pStatus_RxUDP0PacketCount,
  output wire [15:0] pStatus_RxUDP1PacketCount,
  output wire [15:0] pStatus_RxIPErrorPacketCount,
  output wire [15:0] pStatus_RxUDPErrorPacketCount,
  
  output wire [31:0] pStatus_TxByteCount,
  output wire [31:0] pStatus_TxPacketCount,
  output wire [15:0] pStatus_TxARPRequestPacketCount,
  output wire [15:0] pStatus_TxARPReplyPacketCount,
  output wire [15:0] pStatus_TxICMPReplyPacketCount,
  output wire [15:0] pStatus_TxUDP0PacketCount,
  output wire [15:0] pStatus_TxUDP1PacketCount,
  output wire [15:0] pStatus_TxMulticastPacketCount,
  
  output wire [15:0] pStatus_Phy,
  
  output wire [63:0] pdebug
  );
endmodule
```


## VHDLインタンステンプレート

### コンポーネント宣言

```vhdl
component e7udpip_rgmii_artix7
    port (
        GEPHY_RST_N     : out std_logic;
        GEPHY_MAC_CLK   : in std_logic;
        GEPHY_MAC_CLK90 : in std_logic;
		
		-- TX out
        GEPHY_TD      : out std_logic_vector(3 downto 0);
        GEPHY_TXEN_ER : out std_logic;
        GEPHY_TCK     : out std_logic;
        -- RX in
		GEPHY_RD      : in std_logic_vector(3 downto 0);
		GEPHY_RCK     : in std_logic;
		GEPHY_RXDV_ER : in std_logic;
		--Management I/F
        GEPHY_MDC   : out std_logic;
		GEPHY_MDIO  : inout std_logic;
		GEPHY_INT_N : in std_logic;
		
	    -- Asynchronous Reset
		Reset_n : in std_logic;
		
	    -- UPL interface
		pUPLGlobalClk : in std_logic;
		
	    -- UDP tx input
		pUdp0Send_Data    : in  std_logic_vector(31 downto 0);
		pUdp0Send_Request : in  std_logic;
		pUdp0Send_Ack     : out std_logic;
		pUdp0Send_Enable  : in  std_logic;
		
		pUdp1Send_Data    : in  std_logic_vector(31 downto 0);
		pUdp1Send_Request : in  std_logic;
		pUdp1Send_Ack     : out std_logic;
		pUdp1Send_Enable  : in  std_logic;
		
	    -- UDP rx output
		pUdp0Receive_Data    : out std_logic_vector(31 downto 0);
		pUdp0Receive_Request : out std_logic;
		pUdp0Receive_Ack     : in  std_logic;
		pUdp0Receive_Enable  : out std_lgoic;
        
		pUdp1Receive_Data    : out std_logic_vector(31 downto 0);
		pUdp1Receive_Request : out std_logic;
		pUdp1Receive_Ack     : in  std_logic;
		pUdp1Receive_Enable  : out std_lgoic;
        
		-- MII interface
		pMIIInput_Data    : in  std_logic_vector(31 downto 0);
		pMIIInput_Request : in  std_logic;
		pMIIInput_Ack     : out std_logic;
		pMIIInput_Enable  : in  std_logic;
		
	    pMIIOutput_Data    : out std_logic_vector(31 downto 0);
		pMIIOutput_Request : out std_logic;
		pMIIOutput_Ack     : in std_logic;
		pMIIOutput_Enable  : out std_logic;
		
		-- Setup
		pMyIpAddr       : in std_logic_vector(31 downto 0);
		pMyMacAddr      : in std_logic_vector(47 downto 0);
		pMyNetmask      : in std_logic_vector(31 downto 0);
		pDefaultGateway : in std_logic_vector(31 downto 0);
		pTargetIPAddr   : in std_logic_vector(31 downto 0);
		pMyUdpPort0     : in std_logic_vector(15 downto 0);
		pMyUdpPort1     : in std_logic_vector(15 downto 0);
		pPHYAddr        : in std_logic_vector(4 downto 0);
		pPHYMode        : in std_logic_vector(3 downto 0);
		pConfig_Core    : in std_logic_vector(31 downto 0);
		
		-- Status
		pStatus_RxByteCount             : out std_logic_vector(31 downto 0);
		pStatus_RxPacketCount           : out std_logic_vector(31 downto 0);
		pStatus_RxErrorPacketCount      : out std_logic_vector(15 downto 0);
		pStatus_RxDropPacketCount       : out std_logic_vector(15 downto 0);
		pStatus_RxARPRequestPacketCount : out std_logic_vector(15 downto 0);
		pStatus_RxARPReplyPacketCount   : out std_logic_vector(15 downto 0);
		pStatus_RxICMPPacketCount       : out std_logic_vector(15 downto 0);
		pStatus_RxUDP0PacketCount       : out std_logic_vector(15 downto 0);
		pStatus_RxUDP1PacketCount       : out std_logic_vector(15 downto 0);
		pStatus_RxIPErrorPacketCount    : out std_logic_vector(15 downto 0);
		pStatus_RxUDPErrorPacketCount   : out std_logic_vector(15 downto 0);
		
		pStatus_TxByteCount   : out std_logic_vector(31 downto 0);
		pStatus_TxPacketCount : out std_logic_vector(31 downto 0);
		pStatus_TxARPRequestPacketCount : out std_logic_vector(15 downto 0);
		pStatus_TxARPReplyPacketCount : out std_logic_vector(15 downto 0);
		pStatus_TxICMPReplyPacketCount : out std_logic_vector(15 downto 0);
		pStatus_TxUDP0PacketCount : out std_logic_vector(15 downto 0);
		pStatus_TxUDP1PacketCount : out std_logic_vector(15 downto 0);
		pStatus_TxMulticastPacketCount : out std_logic_vector(15 downto 0);
		
		pStatus_Phy : out std_logic_vector(15 downto 0);
		
		pdebug : out std_logic_vector(63 downto 0)
		);
end component e7udpip_rgmii_artix7;
```

### インスタンス生成の例

```vhdl
  idelayctrl_wrapper_u : idelayctrl_wrapper 
    generic map(CLK_PERIOD => 5)
    port map(clk => clk200M, reset=>reset200M, ready=>open);
   
  u_e7udpip : e7udpip_rgmii_artix7
    port map(
      -- GMII PHY
      GEPHY_RST_N     => open,
      GEPHY_MAC_CLK   => clk125M,
      GEPHY_MAC_CLK90 => clk125M_90,
      -- TX out
      GEPHY_TD      => GEPHY_TD,
      GEPHY_TXEN_ER => GEPHY_TXEN_ER,
      GEPHY_TCK     => GEPHY_TCK,
      -- RX in
      GEPHY_RD      => GEPHY_RD,
      GEPHY_RCK     => GEPHY_RCK,
      GEPHY_RXDV_ER => GEPHY_RXDV_ER,
            
      GEPHY_MDC   => GEPHY_MDC,
      GEPHY_MDIO  => GEPHY_MDIO,
      GEPHY_INT_N => GEPHY_INT_N,
      
      -- Asynchronous Reset
      Reset_n => not reset125M,
      
      -- UPL interface
      pUPLGlobalClk => clk125M,
      
      -- UDP tx input
      pUdp0Send_Data    => pUdp0Send_Data,
      pUdp0Send_Request => pUdp0Send_Request,
      pUdp0Send_Ack     => pUdp0Send_Ack,
      pUdp0Send_Enable  => pUdp0Send_Enable,
      
      pUdp1Send_Data    => pUdp1Send_Data,
      pUdp1Send_Request => pUdp1Send_Request,
      pUdp1Send_Ack     => pUdp1Send_Ack,
      pUdp1Send_Enable  => pUdp1Send_Enable,
      
      -- UDP rx output
      pUdp0Receive_Data    => pUdp0Receive_Data,
      pUdp0Receive_Request => pUdp0Receive_Request,
      pUdp0Receive_Ack     => pUdp0Receive_Ack,
      pUdp0Receive_Enable  => pUdp0Receive_Enable,
      
      pUdp1Receive_Data    => pUdp1Receive_Data,
      pUdp1Receive_Request => pUdp1Receive_Request,
      pUdp1Receive_Ack     => pUdp1Receive_Ack,
      pUdp1Receive_Enable  => pUdp1Receive_Enable,
      
      -- MII interface
      pMIIInput_Data    => pMIIInput_Data,
      pMIIInput_Request => pMIIInput_Request,
      pMIIInput_Ack     => pMIIInput_Ack,
      pMIIInput_Enable  => pMIIInput_Enable,
      
      pMIIOutput_Data    => pMIIOutput_Data,
      pMIIOutput_Request => pMIIOutput_Request,
      pMIIOutput_Ack     => pMIIOutput_Ack,
      pMIIOutput_Enable  => pMIIOutput_Enable,
      
      -- Setup
      pMyIpAddr       => X"0a000003",
      pMyMacAddr      => X"001b1affffff",
      pMyNetmask      => X"ff000000",
      pDefaultGateway => X"0a0000fe",
      pTargetIPAddr   => X"0a000001",
      pMyUdpPort0     => X"4000",
      pMyUdpPort1     => X"4001",
      pPHYAddr        => "00001",
      pPHYMode        => "1000",
      pConfig_Core    => "00000000",
      
      -- Status
      pStatus_RxByteCount => open,
      pStatus_RxPacketCount => open,
      pStatus_RxErrorPacketCount => open,
      pStatus_RxDropPacketCount => open,
      pStatus_RxARPRequestPacketCount => open,
      pStatus_RxARPReplyPacketCount => open,
      pStatus_RxICMPPacketCount => open,
      pStatus_RxUDP0PacketCount => open,
      pStatus_RxUDP1PacketCount => open,
      pStatus_RxIPErrorPacketCount => open,
      pStatus_RxUDPErrorPacketCount => open,
      
      pStatus_TxByteCount => open,
      pStatus_TxPacketCount => open,
      pStatus_TxARPRequestPacketCount => open,
      pStatus_TxARPReplyPacketCount => open,
      pStatus_TxICMPReplyPacketCount => open,
      pStatus_TxUDP0PacketCount => open,
      pStatus_TxUDP1PacketCount => open,
      pStatus_TxMulticastPacketCount => open,
      
      pStatus_Phy => status_phy,
      
      pdebug => open
  );
```
