`timescale 1ns/1ns
module transmitter_fsm (
    input fsm_clk,
    input rst_n,
    input tx_enable,
    output reg busy,
    output reg load,
    output reg shift
);

`include "fsm_param.v"

reg [1:0] fsm_state;
reg [3:0] fsm_cnt;
reg [1:0] fsm_next_state;

always @ (fsm_state or fsm_cnt or tx_enable) begin
    fsm_next_state = FSM_IDLE;
    if (!tx_enable) begin
        fsm_next_state = FSM_IDLE;
    end else begin
        case (fsm_state)
            FSM_IDLE: fsm_next_state = FSM_LOAD;
            FSM_LOAD: fsm_next_state = FSM_SHIFT;
            FSM_SHIFT:
                if (fsm_cnt < 4'd10) begin
                    fsm_next_state = FSM_SHIFT;
                end else
                    fsm_next_state = FSM_WAIT;
                FSM_WAIT: fsm_next_state = FSM_IDLE;
                default: fsm_next_state = FSM_IDLE;
            endcase
        end
    end

    always @ (posedge fsm_clk) begin
        if (!rst_n) begin
            fsm_state <= #1 FSM_IDLE;
            fsm_cnt <= #1 0;
            busy <= #1 0;
            load <= #1 0;
            shift <= #1 0;
        end else begin
            fsm_state <= #1 fsm_next_state;
            case (fsm_state)
                FSM_IDLE: begin
                    fsm_cnt <= #1 0;
                    busy <= #1 0;
                    load <= #1 0;
                    shift <= #1 0;
                end
                FSM_LOAD: begin
                    fsm_cnt <= #1 fsm_cnt + 1'b1;
                    busy <= #1 1'b1;
                    load <= #1 1'b1;
                    shift <= #1 0;
                end
                FSM_SHIFT: begin
                    fsm_cnt <= #1 fsm_cnt + 1'b1;
                    busy <= #1 1'b1;
                    load <= #1 0;
                    shift <= #1 1'b1;
                end
                FSM_WAIT: begin
                    fsm_cnt <= #1 0;
                    busy <= #1 0;
                    load <= #1 0;
                    shift <= #1 0;
                end
                default: begin

                    fsm_state <= #1 FSM_IDLE;
                    fsm_cnt <= #1 0;
                    busy <= #1 0;
                    load <= #1 0;
                    shift <= #1 0;
                end
            endcase
        end
    end

    endmodule
