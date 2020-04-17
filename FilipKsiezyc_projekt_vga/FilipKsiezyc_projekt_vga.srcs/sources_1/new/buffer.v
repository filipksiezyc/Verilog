`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2020 08:16:18 PM
// Design Name: 
// Module Name: buffer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module buffer(
    input wire clk,
    input wire rst,
    input wire [11:0] xpos_in,
    input wire [11:0] ypos_in,
    
    output reg [11:0] xpos_out,
    output reg [11:0] ypos_out
    );
    reg [11:0] xpos_nxt,ypos_nxt;
    
always @(posedge clk, posedge rst)begin
    if(rst)begin
        xpos_nxt<=0;
        end
    if(clk) begin
        xpos_nxt<=xpos_in;
        end
end   

always @(posedge clk, posedge rst)begin
    if(rst)begin
        ypos_nxt<=0;
        end
    if(clk) begin
        ypos_nxt<=ypos_in;
        end
end

always @* begin
    if(rst)begin
        xpos_out<=0;
        ypos_out<=0;
        end
    else begin
        xpos_out<=xpos_nxt;
        ypos_out<=ypos_nxt;
        end
end

always @* begin
    if(rst)begin
        xpos_out<=0;
        end
    else begin
        xpos_out<=xpos_nxt;
        end
end

always @* begin
            if(rst)begin
                ypos_out<=0;
                end
            else begin
                ypos_out<=ypos_nxt;
                end
        end
    
endmodule
