module receiver (
    input sys_clk,
    input rst_n,
    input serial_data_in,
    // FIXME
    output parallel_data_out,
    output busy,
    ouput data_valid
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

negedge_detec negedge_detec (
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


module negedge_detec (
    input det_clk,
    input det_rst_n,
    input det_input,
    output det_output
);


endmodule


module rx_fsm (
    input fsm_clk,
    input fsm_rst_n,
    input start_detect_bit,
    output load,
    output shift,
    output busy
);


endmodule

module sipo_reg (
    input reg_rst_n,
    input reg_clk,
    input load,
    input shift,
    input serial_data_in,
    output parallel_data_out
);

endmodule

module parity_chk (
    input data_in,
    output checker_out
);

endmodule
