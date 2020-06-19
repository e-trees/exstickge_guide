`default_nettype none

module blinkled
  (
   input wire SYS_CLK_P,
   input wire SYS_CLK_N,
   input wire PUSH_BTN,
   output wire [2:0] LED
   );
    
    reg[31:0] counter;

    assign LED = counter[26:25] == 2'b01 ? 3'b001 :
		 counter[26:25] == 2'b10 ? 3'b010 :
		 counter[26:25] == 2'b11 ? 3'b100 :
		 3'b000;

    wire SYS_CLK;
    IBUFDS SYS_CLK_BUF(.I(SYS_CLK_P),
                       .IB(SYS_CLK_N),
                       .O(SYS_CLK));
    
    always @(posedge SYS_CLK) begin
	if(PUSH_BTN == 1'b0) begin
	    counter <= 32'd0;
	end else begin
	    counter <= counter + 32'd1;
	end
    end

endmodule

`default_nettype wire

