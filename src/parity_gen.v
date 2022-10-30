module parity_gen (
    input even_odd,
    input [7:0] tx_data_in,
    output parity_bit
);

assign parity_bit = ^tx_data_in ^ even_odd;

endmodule
