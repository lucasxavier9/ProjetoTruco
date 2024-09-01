module comparador (
    input logic [3:0] a,   // Entrada A
    input logic [1:0] b,
    output logic igual12,  // Sinal quando A >= 12
    output logic igual3
);
    assign igual12 = (a >= 4'd12);
    assign igual3 = (b >= 2'd3);
endmodule
