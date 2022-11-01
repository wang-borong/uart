`timescale 1ns/1ns
module rx_fsm (
    input fsm_clk,
    input fsm_rst_n,
    input start_detect_bit,
    output reg load,
    output reg shift,
    output reg busy
);

parameter FSM_IDLE = 2'd0;
parameter FSM_SHIFT = 2'd1;
parameter FSM_LOAD = 2'd2;
parameter FSM_WAIT = 2'd3;

reg [1:0] fsm_state;
reg [1:0] fsm_next_state;
reg [3:0] fsm_cnt;

always @ (fsm_state or start_detect_bit or fsm_cnt)
begin: FSM_NEXT_STATE_COMBO
    case (fsm_state)
        FSM_IDLE:
            if (start_detect_bit)
                fsm_next_state = FSM_SHIFT;
            else
                fsm_next_state = FSM_IDLE;
        FSM_SHIFT:
            if (fsm_cnt < 10)
                fsm_next_state = FSM_SHIFT;
            else
                fsm_next_state = FSM_LOAD;
        FSM_LOAD: fsm_next_state = FSM_WAIT;
        FSM_WAIT: fsm_next_state = FSM_IDLE;
        default: fsm_next_state = FSM_IDLE;
    endcase
end

always @ (posedge fsm_clk)
begin: FSM_CUR_STATE_SEQ
    if (!fsm_rst_n)
        fsm_state <= #1 FSM_IDLE;
    else
        fsm_state <= #1 fsm_next_state;
end

always @ (posedge fsm_clk)
begin: FSM_INTER_CNT_SEQ
    if (!fsm_rst_n)
        fsm_cnt <= #1 1'b0;
    else
        if (fsm_state == FSM_SHIFT)
            fsm_cnt <= #1 fsm_cnt + 1'b1;
        else
            fsm_cnt <= #1 1'b0;
end

always @ (posedge fsm_clk)
begin: FSM_OUTPUT_SEQ
    if (!fsm_rst_n) begin
        load <= #1 1'b0;
        shift <= #1 1'b0;
        busy <= #1 1'b0;
    end else begin
        if (fsm_state == FSM_LOAD) begin
            load <= #1 1'b1;
            shift <= #1 1'b0;
            busy <= #1 1'b1;
        end else if (fsm_state == FSM_SHIFT) begin
            load <= #1 1'b0;
            shift <= #1 1'b1;
            busy <= #1 1'b1;
        end else begin
            load <= #1 1'b0;
            shift <= #1 1'b0;
            busy <= #1 1'b0;
        end
    end
end

endmodule
