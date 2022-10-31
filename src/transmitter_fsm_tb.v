module transmitter_fsm_tb;

initial
begin
    $dumpfile("transmitter_fsm_tb.vcd");
    $dumpvars;
end

reg sys_clk;
reg rst_n;
reg tx_enable;
wire baud_clk;

always #10 sys_clk = !sys_clk;

baud_gen baud_gen (
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .baud_clk(baud_clk)
);

transmitter_fsm tx_fsm (
    .fsm_clk(baud_clk),
    .rst_n(rst_n),
    .tx_enable(tx_enable),
    .busy(busy),
    .load(load),
    .shift(shift)
);


initial begin
    sys_clk = 0;
    rst_n = 0;
    $monitor($time, " busy=%d, load=%d, shift=%d\n", busy, load, shift);

    #30
    rst_n = 1'b1;
    #5
    tx_enable = 1'b1;

    #300000 $finish;
end


endmodule
