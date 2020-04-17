vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../../FilipKsiezyc_projekt_vga.srcs/sources_1/ip/clk_divider/clk_divider_clk_wiz.v" \
"../../../../FilipKsiezyc_projekt_vga.srcs/sources_1/ip/clk_divider/clk_divider.v" \


vlog -work xil_defaultlib \
"glbl.v"

