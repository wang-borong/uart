module baud_gen (
    input sys_clk,
    input rst_n,
    output reg baud_clk
);

// sys_clk is 50M
// baud_clk will be generated to 115200

reg [8:0] baud_cnt;

always @ (posedge sys_clk) begin
    if (!rst_n) begin
        baud_cnt <= 0;
        baud_clk <= 0;
    end else begin
        if (baud_cnt == 216) begin
            baud_cnt <= 0;
            baud_clk <= !baud_clk;
        end else
            baud_cnt <= baud_cnt + 1;
    end
end

endmodule
