module Registers (
    input  wire clk,
    input  wire wr_en_i,
    
    input  wire [4:0] RS1_ADDR_i,
    input  wire [4:0] RS2_ADDR_i,
    input  wire [4:0] RD_ADDR_i,

    input  wire [31:0] data_i,
    output wire [31:0] RS1_data_o,
    output wire [31:0] RS2_data_o
);

    // Banco de 32 registradores de 32 bits
    reg [31:0] regs [0:31];

    // Leitura assíncrona
    assign RS1_data_o = regs[RS1_ADDR_i];
    assign RS2_data_o = regs[RS2_ADDR_i];

    // Escrita síncrona
    always @(posedge clk) begin
        if (wr_en_i && (RD_ADDR_i != 5'd0)) begin
            regs[RD_ADDR_i] <= data_i;
        end
    end

    // Garantir que o registrador x0 (posição 0) seja sempre 0
    always @(posedge clk) begin
        regs[0] <= 32'd0;
    end

endmodule
