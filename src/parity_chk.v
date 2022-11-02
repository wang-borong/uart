module parity_chk (
    input [8:0] data_in,
    output checker_out
);

assign checker_out = ^data_in[7:0] ^ 1'b1 == data_in[8];

endmodule
