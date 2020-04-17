// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_example (
  inout wire ps2_clk,
  inout wire ps2_data,
  
  input wire clk,
  
  output reg vs,
  output reg hs,
  output reg [3:0] r,
  output reg [3:0] g,
  output reg [3:0] b,
  output wire pclk_mirror
  );

  // Converts 100 MHz clk into 40 MHz pclk.
  // This uses a vendor specific primitive
  // called MMCME2, for frequency synthesis.
  //wire clk_fb;
  //wire clk_ss;
  //wire clk_out;
  //(* KEEP = "TRUE" *) 
  //(* ASYNC_REG = "TRUE" *)
  //reg [7:0] safe_start = 0;
  //wire clk_in;

/*
  IBUF clk_ibuf (.I(clk),.O(clk_in));

  MMCME2_BASE #(
    .CLKIN1_PERIOD(10.000),
    .CLKFBOUT_MULT_F(10.000),
    .CLKOUT0_DIVIDE_F(25.000))
  clk_in_mmcme2 (
    .CLKIN1(clk_in),
    .CLKOUT0(clk_out),
    .CLKOUT0B(),
    .CLKOUT1(),
    .CLKOUT1B(),
    .CLKOUT2(),
    .CLKOUT2B(),
    .CLKOUT3(),
    .CLKOUT3B(),
    .CLKOUT4(),
    .CLKOUT5(),
    .CLKOUT6(),
    .CLKFBOUT(clkfb),
    .CLKFBOUTB(),
    .CLKFBIN(clkfb),
    .LOCKED(locked),
    .PWRDWN(1'b0),
    .RST(1'b0)
  );

  BUFH clk_out_bufh (.I(clk_out),.O(clk_ss));
  always @(posedge clk_ss) safe_start<= {safe_start[6:0],locked};

  BUFGCE clk_out_bufgce (.I(clk_out),.CE(safe_start[7]),.O(pclk));

  // Mirrors pclk on a pin for use by the testbench;
  // not functionally required for this design to work.

*/

  wire locked;
  reg rst=0;
  wire pclk;
  wire pclk100Mhz;


 clk_divider my_clk_divider
 (
  // Clock out ports
 .clk100Mhz(pclk100Mhz),
 .clk40Mhz(pclk),
  // Status and control signals
 .reset(rst),
 .locked(locked),
 // Clock in ports
 .clk(clk)
 );


  ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
  );

  // Instantiate the vga_timing module, which is
  // the module you are designing for this lab.

  wire [10:0] vcount, hcount;
  wire vsync, hsync;
  wire vblnk, hblnk;
  
  vga_timing my_timing (
    .pclk(pclk),
    .vcount(vcount),
    .vsync(vsync),
    .vblnk(vblnk),
    .hcount(hcount),
    .hsync(hsync),
    .hblnk(hblnk),
    .rst(1'b0)
  );
  
    wire [10:0] vcountdraw, hcountdraw;
    wire vsyncdraw, hsyncdraw;
    wire vblnkdraw, hblnkdraw;
    wire [11:0] rgb_draw;
  
  draw_background my_background(
    .hcount_in(hcount),
    .vcount_in(vcount),
    .vblnk_in(vblnk),
    .hblnk_in(hblnk),
    .hsync_in(hsync),
    .vsync_in(vsync),
    .rst(1'b0),
    .clk(pclk),
    
  
   .hcount_out(hcountdraw),
   .vcount_out(vcountdraw),
   .vblnk_out(vblnkdraw),
   .hblnk_out(hblnkdraw),
   .hsync_out(hsyncdraw),
   .vsync_out(vsyncdraw),
   .rgb_out(rgb_draw)
  );

wire [11:0] xpos,ypos, xpos_ctl, ypos_ctl,xpos_buff, ypos_buff, xpos_1, ypos_1;
wire mouse_left;

MouseCtl my_Mouse_Ctl(
      .clk(pclk100Mhz),    
      .rst(rst),      
      .xpos(xpos), 
      .ypos(ypos),
      .zpos(),
      .left(mouse_left),
      .middle(),
      .right(),
      .new_event(),
      .value(10'b0),
      .setx(1'b0),
      .sety(1'b0),
      .setmax_x(1'b0),
      .setmax_y(1'b0),
      .ps2_clk(ps2_clk),
      .ps2_data(ps2_data)

);  

wire [10:0] vcounrect, hcountrect,vcountfont,hcountfont;
wire vsyncrect, hsyncrect,vsyncfont, hsyncfont;
wire vblnkrect, hblnkrect, vblnkfont, hblnkfont;
wire [11:0] rgb_rect,rgb_font;
wire [3:0] char_line;
wire [6:0] char_code;
wire [7:0] char_pixels,char_xy;


draw_rect_char 
#(
    .X_POSITION(128),
    .Y_POSITION(0),
    .X_WIDITH(128),
    .Y_WIDITH(256)
    )
my_char(
    .hcount_in(hcountdraw),
    .vcount_in(vcountdraw),
    .vblnk_in(vblnkdraw),
    .hblnk_in(hblnkdraw),
    .hsync_in(hsyncdraw),
    .vsync_in(vsyncdraw),
    .rgb_in(rgb_draw),
    .clk(pclk),
    .char_pixels(char_pixels),
    .rst(rst),
    
    .hcount_out(hcountfont),
    .hblnk_out(hblnkfont),
    .hsync_out(hsyncfont),
    .vcount_out(vcountfont),
    .vblnk_out(vblnkfont),
    .vsync_out(vsyncfont),
    .rgb_out(rgb_font),
    .char_xy(char_xy),
    .char_line(char_line)
);

char_rom_16x16 char_gen(
.clk(pclk),
.char_xy(char_xy),

.char_code(char_code)
);

font_rom font_gen(
.clk(pclk),
.addr({char_code,char_line}),

.char_line_pixels(char_pixels)
);


wire [11:0]rgb_pixel, pixel_address;

buffer my_buffer(
    .rst(rst),
    .clk(pclk),
    .xpos_in(xpos),
    .ypos_in(ypos),
    
    .xpos_out(xpos_1),
    .ypos_out(ypos_1)
);

buffer my_buffer_2(
    .rst(rst),
    .clk(pclk),
    .xpos_in(xpos_1),
    .ypos_in(ypos_1),
    
    .xpos_out(xpos_buff),
    .ypos_out(ypos_buff)
);

image_rom my_image_rom(
.clk(pclk),
.address(pixel_address),

.rgb(rgb_pixel)
);


draw_rect_ctl my_draw_rect_ctl(
.clk(pclk),
.rst(rst),
.mouse_xpos(xpos),
.mouse_ypos(ypos),
.mouse_left(mouse_left),

.xpos(xpos_ctl),
.ypos(ypos_ctl)
);


draw_rect 
#(
    .X_WIDITH(48),
    .Y_WIDITH(64)
 )
my_rect(
    .xpos(xpos_ctl),
    .ypos(ypos_ctl),
    .hcount_in(hcountfont),
    .vcount_in(vcountfont),
    .vblnk_in(vblnkfont),
    .hblnk_in(hblnkfont),
    .hsync_in(hsyncfont),
    .vsync_in(vsyncfont),
    .rgb_in(rgb_font),
    .clk(pclk),
    .rgb_pixel(rgb_pixel),
    .rst(rst),
    

   .hcount_out(hcountrect),
   .vcount_out(vcounrect),
   .vblnk_out(vblnkrect),
   .hblnk_out(hblnkrect),
   .hsync_out(hsyncrect),
   .vsync_out(vsyncrect),
   .rgb_out(rgb_rect),
   .pixel_addr(pixel_address)
  );
  
  wire [3:0] red_mouse, green_mouse, blue_mouse;
  wire enable_mouse;

MouseDisplay my_m_display (
         .pixel_clk(pclk),
         .xpos(xpos_buff),
         .ypos(ypos_buff),
         .hcount({1'b0, hcountrect}), 
         .vcount({1'b0, vcounrect}),
         .blank(hblnkrect || vblnkrect),

         .red_in(rgb_rect[11:8]),
         .green_in(rgb_rect[7:4]),
         .blue_in(rgb_rect[3:0]),

         .enable_mouse_display_out(enable_mouse), 
         .red_out(red_mouse),
         .green_out(green_mouse),
         .blue_out(blue_mouse)
);

always @* begin
    vs<=vsyncrect;
    hs<=hsyncrect;
    {r,g,b}<={red_mouse,green_mouse,blue_mouse};
    end


endmodule
