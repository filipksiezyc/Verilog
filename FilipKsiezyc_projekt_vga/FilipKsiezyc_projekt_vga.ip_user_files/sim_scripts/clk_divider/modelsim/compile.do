vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../../FilipKsiezyc_projekt_vga.srcs/sources_1/ip/clk_divider/clk_divider_clk_wiz.v" \
"../../../../FilipKsiezyc_projekt_vga.srcs/sources_1/ip/clk_divider/clk_divider.v" \


vlog -work xil_defaultlib \
"glbl.v"

