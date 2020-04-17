vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../../FilipKsiezyc_projekt_vga.srcs/sources_1/ip/clk_divider/clk_divider_clk_wiz.v" \
"../../../../FilipKsiezyc_projekt_vga.srcs/sources_1/ip/clk_divider/clk_divider.v" \


vlog -work xil_defaultlib \
"glbl.v"

