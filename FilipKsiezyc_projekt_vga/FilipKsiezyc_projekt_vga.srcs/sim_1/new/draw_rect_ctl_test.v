`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2020 08:44:32 PM
// Design Name: 
// Module Name: draw_rect_ctl_test
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


module draw_rect_ctl_test( 
);
wire mouse_left;
reg [11:0] mouse_xpos, mouse_ypos,xpos_out, ypos_out;
reg clk;
localparam DOWN_OF_SCREEN=529;


draw_rect_ctl_tb tb_rect_fall(
    .mouse_left(mouse_left),
    
    .mouse_xpos(mouse_xpos),
    .mouse_ypos(mouse_ypos)
);
    
    
draw_rect_ctl test_rect_ctl(
    .mouse_left(mouse_left),
    .mouse_xpos(mouse_xpos),
    .mouse_ypos(mouse_ypos),
    .clk(clk),
    .rst(0),
    
    .xpos(xpos_out),
    .ypos(ypos_out)
);    

always
  begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end 
 
 initial begin
  $display("Simulating falling of rectangle");
  $display("Stop at the down of screen");
  wait(ypos_out==DOWN_OF_SCREEN);
 $display("Info: time of falling %t",$time);
 // End the simulation.
 $display("Simulation is over, check the waveforms.");
 end 
     
endmodule
