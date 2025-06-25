module Memory #(
    parameter MEMORY_FILE = "",
    parameter MEMORY_SIZE = 4096
)(
    input  wire        clk,

    input  wire        rd_en_i,    // Indica uma solicitação de leitura
    input  wire        wr_en_i,    // Indica uma solicitação de escrita

    input  wire [31:0] addr_i,     // Endereço
    input  wire [31:0] data_i,     // Dados de entrada (para escrita)
    output reg [31:0] data_o,     // Dados de saída (para leitura)

    output reg        ack_o       // Confirmação da transação
);


    // Memória de 32 bits por posição (palavra)
    reg [31:0] memory [0:MEMORY_SIZE-1];

    initial begin
        if (MEMORY_FILE != "") begin
            $readmemh(MEMORY_FILE, memory);
        end
    end

    wire [31:2] aligned_addr = addr_i[31:2];

    always @(posedge clk) begin
        ack_o <= rd_en_i || wr_en_i;  // Confirma qualquer operação válida

        if (rd_en_i) begin
            data_o <= memory[aligned_addr];
        end else begin
            data_o <= 32'd0;
        end

        if (wr_en_i) begin
            memory[aligned_addr] <= data_i;
        end
    end

endmodule

