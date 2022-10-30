`timescale 1ns/1ns
module parity_gen_tb;

wire parity_bit;
reg even_odd;
reg [7:0] tx_data_in;

parity_gen parity_gen (
    .even_odd(even_odd),
    .tx_data_in(tx_data_in),
    .parity_bit(parity_bit)
);

initial begin
    $dumpfile("parity_gen_tb.vcd");
    $dumpvars;
end

initial begin
    even_odd = 1'b1;
    tx_data_in = 8'h11;
    $monitor("parity_bit: %d\n", parity_bit);
    #10
    even_odd = 1'b1;
    tx_data_in = 8'h1a;
end

endmodule
