`timescale 1ns/1ns
module transmitter_tb;

reg rst_n;
reg [7:0] tx_data_in;
reg sys_clk;
reg tx_enable;
reg even_odd;
wire serial_out;
wire busy;

transmitter transmitter (
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .tx_enable(tx_enable),
    .even_odd(even_odd),
    .tx_data_in(tx_data_in),
    .busy(busy),
    .serial_out(serial_out)
);

always #10 sys_clk = !sys_clk;
initial begin
    $monitor($time, " serial_out %d, busy=%d\n", serial_out, busy);
    #30
    /* baud_clk = 0; */
    sys_clk = 1'b0;
    rst_n = 1'b0;
    #30
    rst_n = 1'b1;
    even_odd = 1'b0;
    tx_data_in = 8'haa;
    tx_enable = 1'b1;
    #31000
    even_odd = 1'b1;
    tx_data_in = 8'hcc;


    #300000 $finish;
end

initial begin
    $dumpfile("transmitter_tb.vcd");
    $dumpvars;
end

endmodule
