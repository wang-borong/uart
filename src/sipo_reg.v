`timescale 1ns/1ns
module sipo_reg (
    input reg_rst_n,
    input reg_clk,
    input load,
    input shift,
    input serial_data_in,
    output reg [8:0] parallel_data_out
);

reg [8:0] data_temp;
always @ (posedge reg_clk) begin
    if (!reg_rst_n)
        data_temp <= #1 9'h0;
    else begin
        if (shift)
            data_temp <= #1 {serial_data_in, data_temp[8:1]};
        else if (load)
            parallel_data_out <= #1 data_temp;
        else
            data_temp <= #1 data_temp;
    end
end

endmodule
