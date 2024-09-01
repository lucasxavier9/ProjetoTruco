module registrador (
    input logic clk,
    input logic reset,
    input logic load,
    input logic [3:0] d,   // Dados de entrada
    output logic [3:0] q   // Dados de saída
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            q <= 4'b0;
        else if (load)
            q <= d;
    end
endmodule
