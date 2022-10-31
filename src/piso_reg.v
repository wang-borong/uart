`timescale 1ns/1ns
module piso_reg (
    input load,
    input shift,
    input parity_bit,
    input reg_rst_n,
    input [7:0] p_data_in,
    input reg_clk,
    output reg serial_out
);

reg [9:0] temp_data;
reg [3:0] i;

always @ (posedge reg_clk) begin
    if (!reg_rst_n)
        serial_out <= #1 1'b1;
    else begin
        if (load) begin
            temp_data <= #1 {1'b1, parity_bit, p_data_in};
            serial_out <= #1 1'b0;
            i <= #1 4'd0;
        end else if (shift) begin
            serial_out <= #1 temp_data[i];
            i <= #1 i + 1'b1;
        end else serial_out <= #1 1'b1;
    end
end

endmodule
