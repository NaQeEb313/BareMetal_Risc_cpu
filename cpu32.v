`timescale 1ns/1ps

module special_assignment (
    input wire clk,
    input wire rst,
    input wire start,

    output reg [2:0] state_out,
    output reg [7:0] result_out,
    output reg [7:0] debug_r0,
    output reg [7:0] debug_r1,
    output reg [7:0] pc_out
);
  
parameter IDLE      = 3'b000;
parameter FETCH     = 3'b001;
parameter DECODE    = 3'b010;
parameter EXECUTE   = 3'b011;
parameter WRITEBACK = 3'b100;
parameter HALT      = 3'b101;

reg [2:0] current_state, next_state;


reg [7:0]  pc;
reg [31:0] instr;
reg [7:0]  reg_file [0:15];
integer i;


reg [31:0] memory   [0:7];   // Instruction memory
reg [7:0]  data_mem [0:255]; // Data memory


wire [3:0] opcode = instr[31:28];
wire [3:0] rd     = instr[27:24];
wire [3:0] rs1    = instr[23:20];
wire [3:0] rs2    = instr[19:16];
wire [15:0] imm   = instr[15:0];
wire [7:0]  imm8  = imm[7:0];


wire [7:0] addr = reg_file[rs1] + imm8;

  
initial begin
    
    memory[0] = 32'b1110_0000_0000_0000_0000000000000000; // LOAD R0 ← mem[0]
    memory[1] = 32'b1110_0001_0000_0000_0000000000000001; // LOAD R1 ← mem[1]
    memory[2] = 32'b0000_0010_0000_0001_0000000000000000; // ADD R2 = R0 + R1
    memory[3] = 32'b1101_0000_0010_0000_0000000000000010; // STORE R2 → mem[2]
    memory[4] = 32'b0101_0011_0000_0001_0000000000000000; // MUL R3 = R0 * R1
    memory[5] = 32'b1000_0100_0001_0000_0000000000000000; // SLT R4 = R1 < R0
    memory[6] = 32'b1011_0101_0000_0000_0000000000000000; // NOT R5 = ~R0
    memory[7] = 32'b1111_0000_0000_0000_0000000000000000; // HALT

    // data in data memory
    data_mem[0] = 8'd5;
    data_mem[1] = 8'd3;
end


always @(posedge clk or posedge rst) begin
    if (rst)
        current_state <= IDLE;
    else
        current_state <= next_state;
end


always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc    <= 0;
        instr <= 0;

        for (i = 0; i < 16; i = i + 1)
            reg_file[i] <= 0;

    end else begin
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
                case (opcode)

                    4'b0000: reg_file[rd] <= reg_file[rs1] + reg_file[rs2]; // ADD
                    4'b0001: reg_file[rd] <= reg_file[rs1] - reg_file[rs2]; // SUB
                    4'b0010: reg_file[rd] <= reg_file[rs1] & reg_file[rs2]; // AND
                    4'b0011: reg_file[rd] <= reg_file[rs1] | reg_file[rs2]; // OR
                    4'b0100: reg_file[rd] <= reg_file[rs1] ^ reg_file[rs2]; // XOR
                    4'b0101: reg_file[rd] <= reg_file[rs1] * reg_file[rs2]; // MUL

                    4'b0110: reg_file[rd] <= (reg_file[rs2] != 0) ?
                                             reg_file[rs1] / reg_file[rs2] : 0; // DIV

                    4'b0111: reg_file[rd] <= reg_file[rs1] % reg_file[rs2]; // MOD

                    4'b1000: reg_file[rd] <= (reg_file[rs1] < reg_file[rs2]) ? 1 : 0; // SLT

                    4'b1001: reg_file[rd] <= reg_file[rs1] << reg_file[rs2]; // SLL
                    4'b1010: reg_file[rd] <= reg_file[rs1] >> reg_file[rs2]; // SRL

                    4'b1011: reg_file[rd] <= ~reg_file[rs1]; // NOT
                    4'b1100: reg_file[rd] <= reg_file[rs1];  // MOV

                    4'b1110: reg_file[rd] <= data_mem[addr]; // LOAD
                    4'b1101: data_mem[addr] <= reg_file[rs2]; // STORE

                    4'b1111: ; // HALT

                    default: ;
                endcase
            end

            WRITEBACK: begin
                
            end

            HALT: begin
                
            end

        endcase
    end
end


always @(*) begin
    case (current_state)
        IDLE:      next_state = start ? FETCH : IDLE;
        FETCH:     next_state = DECODE;
        DECODE:    next_state = EXECUTE;
        EXECUTE:   next_state = (opcode == 4'b1111) ? HALT : WRITEBACK;
        WRITEBACK: next_state = FETCH;
        HALT:      next_state = HALT;
        default:   next_state = IDLE;
    endcase
end


always @(*) begin
    state_out  = current_state;
    result_out = reg_file[2]; // Result register
    debug_r0   = reg_file[0];
    debug_r1   = reg_file[1];
    pc_out     = pc;
end

endmodule
