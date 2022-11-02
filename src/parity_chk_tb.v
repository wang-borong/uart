module parity_chk_tb;

reg [8:0] data_in;
wire checker_out;

parity_chk parity_chk (
    .data_in(data_in),
    .checker_out(checker_out)
);

initial begin
    data_in = 9'h12d;
    #1
    $display("checker_out: %d", checker_out);
    data_in = 9'h2d;
    #1
    $display("checker_out: %d", checker_out);
end


initial begin
    $dumpfile("sipo_reg_tb.vcd");
    $dumpvars;
end

endmodule
