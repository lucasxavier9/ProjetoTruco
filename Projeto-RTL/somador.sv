module somador (
    input logic [3:0] a,   // Entrada A
    input logic [3:0] b,   // Entrada B
    output logic [3:0] soma, // Saída da soma
    input logic [1:0] a2,   // Entrada A
    input logic [1:0] b2,   // Entrada B
    output logic [1:0] soma2 // Saída da soma

);
    assign soma = a + b;
    assign soma2 = a2 + b2;
endmodule
