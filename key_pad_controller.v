module key_pad_controller (
    input clk, //100Hz
    input rst,
    input [3:0] kp_col,
    output [3:0] kp_row,
    output reg up1, // A being pressed
    output reg up2, // 8 being pressed
    output reg down1, // 0 being pressed
    output reg down2 // 7 being pressed
);

reg [3:0] keypadBuf;
always @(posedge clk) 
begin
    if(!rst) 
    begin
        keypadBuf <= 4'h0;
        kp_row <= 4'b1110;
    end
    else
    begin
        case({kp_row,kp_col})
				8'b1101_1110: keypadBuf <= 4'h8;
				8'b1101_1101: keypadBuf <= 4'h5;
				8'b1101_1011: keypadBuf <= 4'h2;
				8'b1101_0111: keypadBuf <= 4'hA;

				8'b1110_1110: keypadBuf <= 4'h7;
				8'b1110_1101: keypadBuf <= 4'h4;
				8'b1110_1011: keypadBuf <= 4'h1;
				8'b1110_0111: keypadBuf <= 4'h0;

            default:
                keypadBuf <= keypadBuf;
        endcase
        case(kp_row)
                4'b1101: kp_row <= 4'b1110;
                4'b1110: kp_row <= 4'b1101;
                default: kp_row <= 4'b1101;
        endcase
    end
end

always @(keypadBuf)
begin
    case(keypadBuf)
        4'hA:
        begin
            up1 = 1;
            up2 = 0;
            down1 = 0;
            down2 = 0;
        end

        4'h8:
        begin
            up1 = 0;
            up2 = 1;
            down1 = 0;
            down2 = 0;
        end
        4'h0:
        begin
            up1 = 0;
            up2 = 0;
            down1 = 1;
            down2 = 0;
        end
        4'h7:
        begin
            up1 = 0;
            up2 = 0;
            down1 = 0;
            down2 = 1;
        end
		  
		  default:
		  begin
				up1 = 0;
            up2 = 0;
            down1 = 0;
            down2 = 0;
		  end
    endcase
    
end

endmodule
