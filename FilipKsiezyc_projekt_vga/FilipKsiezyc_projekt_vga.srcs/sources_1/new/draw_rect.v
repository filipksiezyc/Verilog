`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2020 15:32:06
// Design Name: 
// Module Name: draw_rect
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
module draw_rect
#(parameter

     X_WIDITH=0,
     Y_WIDITH=0
)
(
    input wire [11:0] xpos,
    input wire [11:0] ypos,
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [11:0] rgb_in,
    input wire clk,
    input wire [11:0] rgb_pixel,
    input wire rst,

    output reg [10:0] hcount_out,
    output reg [10:0] vcount_out,
    output reg hsync_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg hblnk_out,
    output reg [11:0] rgb_out,
    output reg [11:0] pixel_addr
    );

    reg [10:0] hcount_1=0, hcount_2=0;
    reg [10:0] vcount_1=0, vcount_2=0;
    reg hsync_1=0, hsync_2=0;
    reg vsync_1=0, vsync_2=0;
    reg vblnk_1=0, vblnk_2=0;
    reg hblnk_1=0, hblnk_2=0;
    reg [11:0] rgb_nxt=0;
    wire [5:0] addry;wire [5:0] addrx; 
    reg [11:0] xpos1=0; reg [11:0] ypos1=0; reg [11:0] xpos2=0; reg [11:0] ypos2=0;
    
  always @(posedge clk, posedge rst)begin
        if(rst)begin
           hcount_1<=0;
           vcount_1<=0;
           vsync_1<=0;
           hsync_1<=0;
           vblnk_1<=0;
           hblnk_1<=0;
           xpos1<=0;
           ypos1<=0;
           end
        
        if(clk)begin
           hcount_1<=hcount_in;
           vcount_1<=vcount_in;
           vsync_1<=vsync_in;
           hsync_1<=hsync_in;
           vblnk_1<=vblnk_in;
           hblnk_1<=hblnk_in;
           xpos1<=xpos;
           ypos1<=ypos;
           end
    end     
    
            
    

always @(posedge clk, posedge rst)begin
           if(rst)begin
              hcount_2<=0;
              vcount_2<=0;
              vsync_2<=0;
              hsync_2<=0;
              vblnk_2<=0;
              hblnk_2<=0;
              xpos2<=0;
              ypos2<=0;
              end
           
           if(clk)begin
              hcount_2<=hcount_1;
              vcount_2<=vcount_1;
              vsync_2<=vsync_1;
              hsync_2<=hsync_1;
              vblnk_2<=vblnk_1;
              hblnk_2<=hblnk_1;
              xpos2<=xpos1;
              ypos2<=ypos1;
              end
       end 
    
    
always @(*)begin
        if((hcount_in>(xpos2+1))&&(hcount_in<=(xpos2+X_WIDITH+1))&&(vcount_in>=ypos2)&&(vcount_in<=(ypos2+Y_WIDITH-1))) begin
                rgb_nxt<=rgb_pixel;
                end
        else begin
                rgb_nxt<=rgb_in;
        end             
 end  
     
always @(posedge clk, posedge rst) begin
           if(rst) begin
                 hsync_out<=0;
                 vsync_out<=0;
                 hblnk_out<=0;
                 vblnk_out<=0;
                 rgb_out<=0;
             
                 vcount_out<=0;
                 hcount_out<=0;
                 end
           
           if(clk)begin   
                hsync_out<=hsync_2;
                vsync_out<=vsync_2;
                hblnk_out<=hblnk_2;
                vblnk_out<=vblnk_2;
  
                vcount_out<=vcount_2;
                hcount_out<=hcount_2;
                rgb_out <= rgb_nxt;
                pixel_addr<={addry, addrx};
                end
end

assign addry = vcount_in - ypos;
assign addrx = hcount_in - xpos;
    
    
endmodule
