module transmitter (
    input sys_clk,
    input rst_n,
    input tx_enable,
    input even_odd,
    input tx_data_in,
    output busy,
    output serial_out
);

wire baud_clk;
wire load;
wire shift;
wire parity_bit;

baud_gen baud (
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .baud_clk(baud_clk)
);

parity_gen parity_gen (
    .even_odd(even_odd),
    .tx_data_in(tx_data_in),
    .parity_bit(parity_bit)
);

transmitter_fsm tx_fsm (
    .fsm_clk(baud_clk),
    .rst_n(rst_n),
    .tx_enable(tx_enable),
    .busy(busy),
    .load(load),
    .shift(shift)
);

piso_reg piso_reg (
    .reg_clk(baud_clk),
    .load(load),
    .shift(shift),
    .parity_bit(parity_bit),
    .reg_rst_n(rst_n),
    .p_date_in(tx_data_in),
    .serial_out(serial_out)
);

endmodule

module parity_gen (
    input even_odd,
    input tx_data_in,
    output parity_bit
);


endmodule


module piso_reg (
    input load,
    input shift,
    input parity_bit,
    input reg_rst_n,
    input p_date_in,
    input reg_clk,
    output serial_out
);



endmodule

module transmitter_fsm (
    input fsm_clk,
    input rst_n,
    input tx_enable,
    output busy,
    output load,
    output shift
);



endmodule
