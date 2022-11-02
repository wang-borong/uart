module sipo_reg_tb;


reg reg_rst_n, reg_clk;
reg load, shift;
reg serial_data_in;
wire [8:0] parallel_data_out;

sipo_reg sipo_reg (
    .reg_rst_n(reg_rst_n),
    .reg_clk(reg_clk),
    .load(load),
    .shift(shift),
    .serial_data_in(serial_data_in),
    .parallel_data_out(parallel_data_out)
);

always #10 reg_clk = ~reg_clk;

initial begin
    $monitor($time, " do=%x", parallel_data_out);
    reg_rst_n = 0;
    reg_clk = 0;
    shift = 0;
    load = 0;
    serial_data_in = 1'b1;
    #30
    reg_rst_n = 1'b1;
    #30
    serial_data_in = 1'b0;
    #20
    shift = 1'b1;
    serial_data_in = 1'b1;
    #20
    serial_data_in = 1'b0;
    #20
    serial_data_in = 1'b1;
    #20
    serial_data_in = 1'b1;
    #20
    serial_data_in = 1'b0;
    #20
    serial_data_in = 1'b1;
    #20
    serial_data_in = 1'b0;
    #20
    serial_data_in = 1'b0;
    #20
    serial_data_in = 1'b1;
    #20
    load = 1;
    shift = 0;
    serial_data_in = 1'b1;
    #20
    load = 0;

    #100 $finish;
end

initial begin
    $dumpfile("sipo_reg_tb.vcd");
    $dumpvars;
end

endmodule
