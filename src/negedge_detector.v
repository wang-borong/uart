`timescale 1ns/1ns
module negedge_detector (
    input det_clk,
    input det_rst_n,
    input det_input,
    output det_output
);

reg det_input_dly;
reg temp;
reg state, next_state;
reg [3:0] cnt;

parameter IDLE = 1'b0;
parameter DETECTED = 1'b1;

always @ (posedge det_clk) begin
    if (det_rst_n == 1'b0)
        det_input_dly <= #1 1'b0;
    else
        det_input_dly <= #1 det_input;
end
always @ (det_input or det_input_dly) begin
    temp = ~det_input & det_input_dly;
end

always @ (state or cnt or temp) begin
    next_state = 0;
    case (state)
        IDLE:
            if (temp)
                next_state = DETECTED;
            else
                next_state = IDLE;
        DETECTED:
            if (cnt < 4'd10)
                next_state = DETECTED;
            else
                next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

always @ (posedge det_clk) begin
    if (!det_rst_n)
        state <= #1 IDLE;
    else
        state <= #1 next_state;
end

always @ (posedge det_clk) begin
    if (!det_rst_n || cnt >= 10)
        cnt <= #1 0;
    else
        if (state == DETECTED)
            cnt <= #1 cnt + 1'b1;
        else
            cnt <= #1 cnt;
end

assign det_output = (state == DETECTED);

endmodule
