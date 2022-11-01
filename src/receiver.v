`timescale 1ns/1ns
module receiver (
    input sys_clk,
    input rst_n,
    input serial_data_in,
    // FIXME
    output [7:0] parallel_data_out,
    output busy,
    output data_valid
);

wire baud_clk;
wire det_output;
wire load;
wire shift;

baud_gen baud_gen (
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .baud_clk(baud_clk)
);

negedge_detector negedge_detector (
    .det_rst_n(rst_n),
    .det_clk(baud_clk),
    .det_input(serial_data_in),
    .det_output(det_output)
);

rx_fsm rx_fsm (
    .fsm_clk(baud_clk),
    .fsm_rst_n(rst_n),
    .start_detect_bit(det_output),
    .load(load),
    .shift(shift)
);

sipo_reg sipo_reg (
    .reg_rst_n(rst_n),
    .reg_clk(baud_clk),
    .load(load),
    .shift(shift),
    .serial_data_in(serial_data_in),
    .parallel_data_out(parallel_data_out)
);

parity_chk parity_chk (
    .data_in(parallel_data_out),
    .checker_out(data_valid)
);

endmodule

module sipo_reg (
    input reg_rst_n,
    input reg_clk,
    input load,
    input shift,
    input serial_data_in,
    output [7:0] parallel_data_out
);

endmodule

module parity_chk (
    input [8:0] data_in,
    output checker_out
);

assign checker_out = ^data_in[8:1] ^ 1'b1 == data_in[0];

endmodule
