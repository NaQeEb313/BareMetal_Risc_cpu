
// [7:6] Opcode | [5:4] Destination | [3:0] Immediate

//eg, 00001010  i.e. Load A 10

module special_assignment (
    input wire clk,
    input wire rst,
    input wire start,
    output reg [2:0] state_out,
    output reg [7:0] result_out
);

//mapping 
parameter IDLE      = 3'b000;
parameter FETCH     = 3'b001;
parameter DECODE    = 3'b010;
parameter EXECUTE   = 3'b011;
parameter WRITEBACK = 3'b100;
parameter HALT      = 3'b101;

reg [2:0] current_state, next_state;


reg [7:0] pc;
reg [7:0] instr;
reg [7:0] reg_A;
reg [7:0] reg_B;


reg [7:0] memory [0:7];

initial begin
  memory[0] = 8'b00_00_0101; // LOAD A,5
  memory[1] = 8'b00_01_0011; // LOAD B,3
  memory[2] = 8'b01_00_0000; // ADD A, B
  memory[3] = 8'b10_00_0000; // Subtract A,B
  memory[4] = 8'b11_00_0000; // stop i.e halt state 
  memory[5] = 8'h00;
   memory[6] = 8'h00;
   memory[7] = 8'h00;
end


always @(posedge clk or posedge rst) begin
    if (rst)
        current_state <= IDLE;
    else
        current_state <= next_state;
end


  //state definition 
always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc     <= 8'd0;
        instr  <= 8'd0;
        reg_A  <= 8'd0;
        reg_B  <= 8'd0;
    end 
    else begin
        case (current_state)

            IDLE: begin
                
            end

            FETCH: begin
                instr <= memory[pc];
                pc    <= pc + 1;
            end

            DECODE: begin
                
            end

            EXECUTE: begin
                case (instr[7:6])

                    2'b00: begin // LOAD
                        if (instr[5:4] == 2'b00)
                            reg_A <= {4'b0000, instr[3:0]};
                        else
                            reg_B <= {4'b0000, instr[3:0]};
                    end

                    2'b01: begin // ADD
                        reg_A <= reg_A + reg_B;
                    end

                    2'b10: begin // SUB
                        reg_A <= reg_A - reg_B;
                    end

                    default: begin
                        // halt
                    end

                endcase
            end

            WRITEBACK: begin
                
            end

            HALT: begin
                
            end

        endcase
    end
end

//next state 
always @(*) begin
    case (current_state)

        IDLE:      next_state = start ? FETCH : IDLE;
        FETCH:     next_state = DECODE;
        DECODE:    next_state = EXECUTE;
        EXECUTE:   next_state = (instr[7:6] == 2'b11) ? HALT : WRITEBACK;
        WRITEBACK: next_state = FETCH;
        HALT:      next_state = HALT;

        default:   next_state = IDLE;

    endcase
end


always @(*) begin
    state_out  = current_state;
    result_out = reg_A;
end

endmodule

// now A=A+B then A+B-B = A , it should return A
