`timescale 1ns/1ns
module rx_fsm_tb;


reg fsm_clk;
reg fsm_rst_n;
reg start_detect_bit;
wire load, shift, busy;


rx_fsm rx_fsm (
    .fsm_clk(fsm_clk),
    .fsm_rst_n(fsm_rst_n),
    .start_detect_bit(start_detect_bit),
    .load(load),
    .shift(shift),
    .busy(busy)
);

always #10 fsm_clk = ~fsm_clk;

initial begin
    $monitor($time, " load=%d, shift=%d, busy=%d", load, shift, busy);

    fsm_clk = 0;
    fsm_rst_n = 0;
    start_detect_bit = 0;
    #30
    fsm_rst_n = 1;
    #30
    start_detect_bit = 1;
    #20
    start_detect_bit = 0;
    #500
    start_detect_bit = 1;
    #20
    start_detect_bit = 0;

    #1000 $finish;
end


initial begin
    $dumpfile("rx_fsm_tb.vcd");
    $dumpvars;
end

endmodule
