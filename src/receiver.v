module receiver (
    input sys_clk,
    input rst_n,
    input serial_data_in,
    output [7:0] parallel_data_out,
    output busy,
    output data_valid
);

wire baud_clk;
wire det_output;
wire load;
wire shift;
wire [8:0] pdata_temp;

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
    .shift(shift),
    .busy(busy)
);

sipo_reg sipo_reg (
    .reg_rst_n(rst_n),
    .reg_clk(baud_clk),
    .load(load),
    .shift(shift),
    .serial_data_in(serial_data_in),
    .parallel_data_out(pdata_temp)
);

parity_chk parity_chk (
    .data_in(pdata_temp),
    .checker_out(data_valid)
);

assign parallel_data_out = pdata_temp[7:0];

endmodule
