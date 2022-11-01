`timescale 1ns/1ns
module negedge_detector_tb;

negedge_detector negedge_detector (
    .det_clk(det_clk),
    .det_rst_n(det_rst_n),
    .det_input(det_input),
    .det_output(det_output)
);

wire det_output;
reg det_input;
reg det_rst_n;
reg det_clk;

always #10 det_clk = ~det_clk;


initial begin
    $monitor($time, " det_output: %d", det_output);
    det_clk = 0;
    det_rst_n = 0;
    det_input = 1'b1;
    #25
    det_rst_n = 1;
    #15
    /* det_input = 12'b101100110011; */
    det_input = 1'b1;
    #20
    det_input = 1'b0;
    #20
    det_input = 1'b1;
    #20
    det_input = 1'b1;
    #20
    det_input = 1'b0;
    #20
    det_input = 1'b0;
    #20
    det_input = 1'b1;
    #20
    det_input = 1'b1;
    #20
    det_input = 1'b0;
    #20
    det_input = 1'b0;
    #20
    det_input = 1'b1;
    #20
    det_input = 1'b1;


    #100 $finish;
end


initial begin
    $dumpfile("negedge_detector_tb.vcd");
    $dumpvars;
end


endmodule
