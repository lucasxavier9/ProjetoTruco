module modulomain (
    input logic clk, rst, Ba, Bb,
    output logic [6:0] displayA_dezenas, displayA_unidades,
    output logic [6:0] displayB_dezenas, displayB_unidades,
    output logic [6:0] displayTentoA, displayTentoB
);

    // Sinais internos
    logic [3:0] pontuacaoA, pontuacaoB;
    logic [3:0] dezenaA, unidadeA;
    logic [3:0] dezenaB, unidadeB;
    logic [1:0] tentosA, tentosB;
    logic jogo_encerrado;
    logic clean_Ba, clean_Bb; // Sinais debounced

    // Instanciando o módulo debounce para Ba e Bb
    debounce debounce_Ba (
        .clk(clk),
        .rst(rst),
        .button(Ba),
        .button_clean(clean_Ba)
    );

    debounce debounce_Bb (
        .clk(clk),
        .rst(rst),
        .button(Bb),
        .button_clean(clean_Bb)
    );

    // Instanciando o módulo do placar de truco
    placar_truco placar (
        .clk(clk),
        .rst(rst),
        .Ba(clean_Ba),  // Usando o sinal debounced
        .Bb(clean_Bb),  // Usando o sinal debounced
        .pontuacaoA(pontuacaoA),
        .pontuacaoB(pontuacaoB),
        .tentosA(tentosA),
        .tentosB(tentosB),
        .jogo_encerrado(jogo_encerrado)
    );

    // Instanciando os conversores bin2BCD para dupla A e B
    bin2BCD converterA (
        .bin({4'b0000, pontuacaoA}),
        .dez(dezenaA),
        .und(unidadeA)
    );

    bin2BCD converterB (
        .bin({4'b0000, pontuacaoB}),
        .dez(dezenaB),
        .und(unidadeB)
    );

    // Conversão de BCD para display de sete segmentos
    always @(posedge clk) begin
        displayA_dezenas = converte(dezenaA);
        displayA_unidades = converte(unidadeA);

        displayB_dezenas = converte(dezenaB);
        displayB_unidades = converte(unidadeB);

        displayTentoA = converte({2'b00, tentosA});
        displayTentoB = converte({2'b00, tentosB});
    end

    // Função para conversão de números para display de sete segmentos
    function logic [6:0] converte(input logic [3:0] num);
        case (num)
            4'b0000: converte = 7'b1000000;
            4'b0001: converte = 7'b1111001;
            4'b0010: converte = 7'b0100100;
            4'b0011: converte = 7'b0110000;
            4'b0100: converte = 7'b0011001;
            4'b0101: converte = 7'b0010010;
            4'b0110: converte = 7'b0000010;
            4'b0111: converte = 7'b1111000;
            4'b1000: converte = 7'b0000000;
            4'b1001: converte = 7'b0010000;
            default: converte = 7'b1111111; // Display apagado para valores inválidos
        endcase
    endfunction

endmodule
