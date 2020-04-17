`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2020 14:01:09
// Design Name: 
// Module Name: draw_background
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


module draw_background(
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire rst,
    input wire clk,
   
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out
    );
    
   reg [11:0] rgb_nxt;     
 
         
always @(posedge clk)begin
        if (vblnk_in || hblnk_in) rgb_nxt <= 12'h000; 
        
          else begin
          // Active display, top edge, make a yellow line.
          if (vcount_in == 0) rgb_nxt <= 12'hff0;
          // Active display, bottom edge, make a red line.
          else if (vcount_in == 599) rgb_nxt = 12'hf00;
          // Active display, left edge, make a green line.
          else if (hcount_in == 1) rgb_nxt = 12'h0f0;
          // Active display, right edge, make a blue line.
          else if (hcount_in == 799) rgb_nxt = 12'h00f;
               //inicja³y moje FILIP KSIÊ¯YC
               //F
               else if((hcount_in>299)&(hcount_in<381)&(vcount_in>199)&(vcount_in<216)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>299)&(hcount_in<381)&(vcount_in<299)&(vcount_in>284)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>299)&(hcount_in<316)&(vcount_in>199)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               //K
               else if((hcount_in>419)&(hcount_in<436)&(vcount_in>199)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               //upperline
               else if((hcount_in>435)&(hcount_in<544)&(hcount_in-135==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<544)&(hcount_in-136==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<544)&(hcount_in-137==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<544)&(hcount_in-138==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<544)&(hcount_in-139==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<546)&(hcount_in-140==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<546)&(hcount_in-141==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<546)&(hcount_in-142==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<546)&(hcount_in-143==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<546)&(hcount_in-144==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<546)&(hcount_in-145==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<546)&(hcount_in-146==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<546)&(hcount_in-147==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<546)&(hcount_in-148==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<546)&(hcount_in-149==vcount_in)&(vcount_in<401)) rgb_nxt <=12'h0_0_0;
               //downline
               else if((hcount_in>435)&(hcount_in<536)&(735-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(734-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(733-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(732-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(731-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(730-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(729-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(728-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(727-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(726-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(725-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(724-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(723-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(722-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
               else if((hcount_in>435)&(hcount_in<536)&(721-hcount_in==vcount_in)&(vcount_in>199)) rgb_nxt <=12'h0_0_0;
         
               // You will replace this with your own test.
               // Active display, interior, fill with gray.
               else rgb_nxt <= 12'h8_8_8;    
             end
        end



always @* begin
        if(rst)begin
            hsync_out <= 0;
            vsync_out <= vsync_in;
            hblnk_out <= hblnk_in;
            vblnk_out <= vblnk_in;
            vcount_out <= vcount_in;
            hcount_out <= hcount_in;
            rgb_out<=rgb_nxt;
            end
        else begin    
            hsync_out <= hsync_in;
            vsync_out <= vsync_in;
            hblnk_out <= hblnk_in;
            vblnk_out <= vblnk_in;
            vcount_out <= vcount_in;
            hcount_out <= hcount_in;
            rgb_out<=rgb_nxt;
            end
end
 
endmodule
