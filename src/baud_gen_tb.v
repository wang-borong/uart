`timescale 1ns/1ns
module baud_gen_tb;


initial
begin
    $dumpfile("baud_gen_tb.vcd");
    $dumpvars;
end

baud_gen baud_gen (
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .baud_clk(baud_clk)
);

reg sys_clk;
reg rst_n;
wire baud_clk;

always #10 sys_clk = !sys_clk;

initial begin
    sys_clk = 0;
    rst_n = 0;
    $monitor($time, " baud_clk: %d\n", baud_clk);
    #30 rst_n = 1;

    #40000 $finish;
end


endmodule
