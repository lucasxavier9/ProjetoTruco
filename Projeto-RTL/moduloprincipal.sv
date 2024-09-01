module moduloprincipal (
    input logic clk, reset,
    input logic Ba, Bb,
    output logic fim_jogo,
    output logic [6:0] displayA_dezenas, displayA_unidades,
    output logic [6:0] displayB_dezenas, displayB_unidades,
    output logic [6:0] displayTentoA, displayTentoB
    );
    
    // Sinais internos
    logic [3:0] pontos_a, pontos_b;
    logic [3:0] dezenaA, unidadeA;
    logic [3:0] dezenaB, unidadeB;
    logic [1:0] tentos_a, tentos_b;
    logic load_pa, clear_pa, load_pb, clear_pb, load_ta, clear_ta, load_tb, clear_tb;
    logic a_igual12, b_igual12, ta_igual3, tb_igual3;

    datapath datapath_inst (
        .clk(clk), .reset(reset),
        .load_pa(load_pa), .clear_pa(clear_pa), .load_pb(load_pb), .clear_pb(clear_pb), .load_ta(load_ta), .clear_ta(clear_ta), .load_tb(load_tb), .clear_tb(clear_tb),
        .pontos_a(pontos_a), .pontos_b(pontos_b),
        .tentos_a(tentos_a), .tentos_b(tentos_b),
        .a_igual12(a_igual12), .b_igual12(b_igual12),
        .ta_igual3(ta_igual3), .tb_igual3(tb_igual3)
    );

    controlador controlador_inst (
        .clk(clk), .reset(reset),
        .a_igual12(a_igual12), .b_igual12(b_igual12),
        .ta_igual3(ta_igual3), .tb_igual3(tb_igual3),
        .Ba(Ba), .Bb(Bb),
        .load_pa(load_pa), .clear_pa(clear_pa), .load_pb(load_pb), .clear_pb(clear_pb), .load_ta(load_ta), .clear_ta(clear_ta), .load_tb(load_tb), .clear_tb(clear_tb),
        .fim_jogo(fim_jogo)
    );

    bin2BCD converterA (
        .bin({4'b0000, pontos_a}),
        .dez(dezenaA),
        .und(unidadeA)
    );

    bin2BCD converterB (
        .bin({4'b0000, pontos_b}),
        .dez(dezenaB),
        .und(unidadeB)
    );

    // Conversão de BCD para display de sete segmentos
    always @(posedge clk) begin
        displayA_dezenas = converte(dezenaA);
        displayA_unidades = converte(unidadeA);

        displayB_dezenas = converte(dezenaB);
        displayB_unidades = converte(unidadeB);


        displayTentoA = converte({2'b00, tentos_a});
        displayTentoB = converte({2'b00, tentos_b});

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
