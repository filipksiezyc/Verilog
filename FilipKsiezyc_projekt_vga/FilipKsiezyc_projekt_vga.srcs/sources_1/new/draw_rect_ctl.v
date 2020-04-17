`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2020 09:17:45 PM
// Design Name: 
// Module Name: draw_rect_ctl
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


module draw_rect_ctl(
    input wire mouse_left,
    input wire rst,
    input wire clk,
    input wire [11:0] mouse_xpos,
    input wire [11:0] mouse_ypos,
    
    output reg [11:0] xpos,
    output reg [11:0] ypos
    );
    
    reg [11:0] xpos_nxt=0, ypos_nxt=0;
    reg [11:0] xpos_init=0, ypos_init=0;
    reg [23:0] counter=0,counter_nxt=0;
    reg [11:0] time_stamp=0,time_stamp_nxt=0;
    reg state, state_nxt;
    
    localparam COUNTER_RESET=4000000;
    localparam DOWN_OF_SCREEN=529;
    localparam IDLE=1'b0;
    localparam WORK=1'b1;


always @(posedge clk)begin
       xpos_init<=mouse_xpos;
       ypos_init<=mouse_ypos;          
end

always @(posedge clk) begin 
    if(counter==COUNTER_RESET)begin
               counter_nxt<=0;
               time_stamp_nxt<=(time_stamp+1);
               end
    else begin  
               counter_nxt<=counter+1;
               end
               
   if(state==IDLE)begin
            if(mouse_left)begin
                    state_nxt<=WORK;
                    end
            else begin
                    ypos_nxt<=mouse_ypos;
                    xpos_nxt<=mouse_xpos;
                    counter_nxt<=0;
                    time_stamp_nxt<=0;
                    end
             end
     else if(state==WORK)begin
        xpos_nxt<=xpos_init;
        if((ypos_init+(time_stamp*time_stamp))<=DOWN_OF_SCREEN)begin
            ypos_nxt<=(ypos_init+(time_stamp*time_stamp));
            end
        else begin
            if((xpos_init!=mouse_xpos)||(ypos_init!=mouse_ypos))begin
                state_nxt<=IDLE;
                time_stamp_nxt<=0;
                end
            else if(mouse_left)begin
                 state_nxt<=WORK;
                 ypos_nxt<=0;
                 counter_nxt<=0;
                 time_stamp_nxt<=0;
                 end                 
            else begin
                ypos_nxt<=DOWN_OF_SCREEN;
                counter_nxt<=0;
                end
            end
        end
end

always @* begin    
    if(rst)begin
        time_stamp<=0;
        counter<=0;
        state<=0;
        end
    else begin
        state<=state_nxt;
        time_stamp<=time_stamp_nxt;
        counter<=counter_nxt;
        end
end

always @* begin
    if(rst)begin
        xpos<=0;
        ypos<=0;
        end
    else begin
        xpos<=xpos_nxt;
        ypos<=ypos_nxt;
        end
end
   
    
endmodule
