`timescale 1ns/1ns
module piso_reg_tb;

wire load;
wire shift;
wire parity_bit;
reg rst_n;
reg [7:0] p_data_in;
reg sys_clk;
reg tx_enable;
reg even_odd;
wire baud_clk;
wire serial_out;


baud_gen baud_gen (
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .baud_clk(baud_clk)
);

parity_gen parity_gen (
    .even_odd(even_odd),
    .tx_data_in(p_data_in),
    .parity_bit(parity_bit)
);

transmitter_fsm transmitter_fsm (
    .fsm_clk(baud_clk),
    .rst_n(rst_n),
    .tx_enable(tx_enable),
    .busy(busy),
    .load(load),
    .shift(shift)
);

piso_reg piso_reg (
    .load(load),
    .shift(shift),
    .parity_bit(parity_bit),
    .reg_rst_n(rst_n),
    .p_data_in(p_data_in),
    .reg_clk(baud_clk),
    .serial_out(serial_out)
);


initial begin
    $dumpfile("piso_reg_tb.vcd");
    $dumpvars;
end

/* always #4340 baud_clk = !baud_clk; */
always #10 sys_clk = !sys_clk;

initial begin
    $monitor($time, " serial_out %d\n", serial_out);
    #30
    /* baud_clk = 0; */
    sys_clk = 0;
    rst_n = 0;
    even_odd = 1;
    #30
    rst_n = 1;
    p_data_in = 8'hcc;
    tx_enable = 1;

    #200000 $finish;
end


endmodule
