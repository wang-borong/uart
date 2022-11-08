module receiver_tb;

reg sys_clk, rst_n;
reg serial_data_in;
wire [7:0] parallel_data_out;
wire busy, data_valid;

receiver receiver (
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .serial_data_in(serial_data_in),
    .parallel_data_out(parallel_data_out),
    .busy(busy),
    .data_valid(data_valid)
);

always #10 sys_clk = ~sys_clk;

initial begin
    $monitor($time, " do=%x, busy=%d, data_valid=%d", parallel_data_out, busy, data_valid);
    rst_n = 0;
    sys_clk = 0;
    serial_data_in = 1'b1;
    #30
    rst_n = 1'b1;
    #17400
    serial_data_in = 1'b0;
    #8680
    serial_data_in = 1'b1;
    #8680
    serial_data_in = 1'b0;
    #8680
    serial_data_in = 1'b1;
    #8680
    serial_data_in = 1'b1;
    #8680
    serial_data_in = 1'b0;
    #8680
    serial_data_in = 1'b1;
    #8680
    serial_data_in = 1'b0;
    #8680
    serial_data_in = 1'b0;
    #8680
    serial_data_in = 1'b1;
    #8680
    serial_data_in = 1'b1;
    #8680

    #50000 $finish;
end


initial begin
    $dumpfile("receiver_tb.vcd");
    $dumpvars;
end

endmodule
