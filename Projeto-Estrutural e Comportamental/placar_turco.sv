module placar_truco (
    input logic clk, rst, Ba, Bb,
    output logic [3:0] pontuacaoA, pontuacaoB,
    output logic [1:0] tentosA, tentosB,
    output logic jogo_encerrado 
);

    typedef enum logic [3:0] {
        INICIO, TENTO_A, TENTO_B, FINAL, COMPARA, ADD_A, ADD_B
    } estado_t;

    estado_t estado, proximo_estado;

    // Sinais de borda de subida para os botões
    logic Ba_d, Bb_d;
    logic Ba_edge, Bb_edge;

    // Detecção de borda
    always_ff @(posedge clk , negedge rst) begin
        if (!rst) begin
            Ba_d <= 1'b0;
            Bb_d <= 1'b0;
        end else begin
            Ba_d <= Ba;
            Bb_d <= Bb;
        end
    end

    always_comb begin
        Ba_edge = Ba && !Ba_d;
        Bb_edge = Bb && !Bb_d;
    end

    always_ff @(negedge clk , negedge rst) begin
        if (!rst) begin
            pontuacaoA <= -4'd1;
            pontuacaoB <= 4'd0;
            tentosA <= 2'd0;
            tentosB <= 2'd0;
            jogo_encerrado <= 1'b0;
            proximo_estado <= INICIO;
        end else begin
            estado = proximo_estado;
            case (estado)
                INICIO: begin
                    if (Ba_edge) begin
                        proximo_estado <= ADD_A;
                   
                    end else if (Bb_edge) begin
                        proximo_estado <= ADD_B;
                    end else begin
                        proximo_estado <= INICIO;
                    end
                end

                ADD_A: begin
                    pontuacaoA <= pontuacaoA + 4'd1;
                    if (pontuacaoA == 4'd12) begin
                        proximo_estado <= TENTO_A;
                    end else begin
                        proximo_estado <= INICIO;
                    end
                end

                ADD_B: begin
                    pontuacaoB <= pontuacaoB + 4'd1;
                    if (pontuacaoB == 4'd12) begin
                        proximo_estado <= TENTO_B;
                    end else begin
                        proximo_estado <= INICIO;
                    end
                end

                COMPARA: begin
                    if (tentosA == 2'd3 || tentosB == 2'd3) proximo_estado <= FINAL;
                    else proximo_estado <= INICIO;
                end

                TENTO_A: begin
                    tentosA <= tentosA + 2'd1;
                    pontuacaoA <= 4'd0;
                    pontuacaoB <= 4'd0;
                    proximo_estado <= COMPARA;
                
                end
                TENTO_B: begin
                    tentosB <= tentosB + 2'd1;
                    pontuacaoA <= 4'd0;
                    pontuacaoB <= 4'd0;
                    proximo_estado <= COMPARA;
             
                end
                FINAL: begin
                    jogo_encerrado <= 1'b1;
                    proximo_estado <= FINAL; 
                end
            endcase
        end
    end

endmodule
