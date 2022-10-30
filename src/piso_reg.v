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

always @ (negedge reg_rst_n or posedge reg_clk) begin
    if (!reg_rst_n)
        serial_out <= 1'b1;
    else begin
        if (load) begin
            temp_data <= {1'b1, parity_bit, p_data_in};
            serial_out <= 1'b0;
            i <= 0;
        end else if (shift) begin
            serial_out <= temp_data[i];
            i <= i + 1'b1;
        end else serial_out <= 1'b1;
    end
end

endmodule
