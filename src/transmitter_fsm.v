module transmitter_fsm (
    input fsm_clk,
    input rst_n,
    input tx_enable,
    output busy,
    output load,
    output shift
);

`include "fsm_param.v"

reg [1:0] fsm_state;
reg [3:0] fsm_cnt;

always @ (posedge fsm_clk or negedge rst_n) begin
    if (!rst_n)
        fsm_cnt <= 0;
    else begin
        if (fsm_state == FSM_WAIT)
            fsm_cnt <= 0;
        else if (fsm_state == FSM_IDLE)
            fsm_cnt <= 0;
        else
            fsm_cnt <= fsm_cnt + 1'b1;
    end
end

always @ (posedge fsm_clk or negedge rst_n) begin
    if (!rst_n) begin
        fsm_state <= FSM_IDLE;
    end else begin
        if (!tx_enable)
            fsm_state <= FSM_IDLE;
        else begin
            if (fsm_state == FSM_IDLE) begin
                fsm_state <= FSM_LOAD;
            end else if (fsm_state == FSM_LOAD) begin
                fsm_state <= FSM_SHIFT;
            end else if (fsm_state == FSM_SHIFT) begin
                if (fsm_cnt < 4'd10)
                    fsm_state <= FSM_SHIFT;
                else
                    fsm_state <= FSM_WAIT;
            end else begin
                fsm_state <= FSM_IDLE;
            end
        end
    end
end

assign load = fsm_state == FSM_LOAD;
assign shift = fsm_state == FSM_SHIFT;
assign busy = load | shift;

endmodule
