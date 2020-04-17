// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  input wire pclk,
  input wire rst,

  output wire [10:0] vcount,
  output wire vsync,
  output wire vblnk,
  output wire [10:0] hcount,
  output wire hsync,
  output wire hblnk

  );

  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.


reg [10:0] vcountinside=0; 
reg [10:0] hcountinside=0;
reg [10:0] vcountinside_nxt=0; 
reg [10:0] hcountinside_nxt=0;
reg currentvblnk=0;
reg currenthblnk=0;
reg currentvsync=0;
reg currenthsync=0;

always @(posedge pclk)begin
            hcountinside_nxt<=hcountinside+1;
            if(hcountinside==1055)begin
                hcountinside_nxt<=0;
                vcountinside_nxt<=vcountinside+1;
                if(vcountinside==627)begin
                    vcountinside_nxt<=0;
                    end
                end     
            end
 

always @* begin 
       if(rst)begin
            hcountinside<=0;
            vcountinside<=0;
            end
       else begin
            hcountinside<=hcountinside_nxt;
            vcountinside<=vcountinside_nxt;     
            end
end

assign hcount=(hcountinside-1);
assign vcount=vcountinside;
assign vsync=((vcountinside>600)&&(vcountinside<606));
assign hsync=((hcountinside>839)&&(hcountinside<969));
assign vblnk=((vcountinside>=600)&&(vcountinside<=627));
assign hblnk=((hcountinside>=801)&&(hcountinside<=1054));

endmodule
