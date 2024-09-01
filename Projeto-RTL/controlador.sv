    module controlador (
        input logic clk, reset,
        input logic a_igual12, b_igual12,
        input logic ta_igual3, tb_igual3,
        input logic Ba, Bb,
        output logic load_pa, clear_pa, load_ta, clear_ta, load_pb, clear_pb, load_tb, clear_tb,
        output logic fim_jogo
    );

        typedef enum logic [3:0] {
            INICIO, ESPERA, FINAL,
            ADD_A, COMPARA_A, TENTO_A, COMPARA_TENTOA, FILTROA,
            ADD_B, COMPARA_B, TENTO_B, COMPARA_TENTOB, FILTROB
        } state_t;

        state_t estado, prox_estado;

        always @(posedge clk or negedge reset) begin
            if (!reset) begin
                estado <= INICIO;
            end else begin estado = prox_estado;
        end
        end

        always @(estado, a_igual12, ta_igual3, b_igual12, tb_igual3, Ba, Bb) begin

            case (estado)
                INICIO: begin
                    load_pa <= 0;
                    clear_pa <= 1;
                    load_ta <= 0;
                    clear_ta <= 1;
                    load_pb <= 0;
                    clear_pb <= 1;
                    load_tb <= 0;
                    clear_tb <= 1;
                    fim_jogo <= 0;
                    prox_estado <= ESPERA;
                end

                ESPERA: begin
                    load_pa <= 0;
                    clear_pa <= 0;
                    load_ta <= 0;
                    clear_ta <= 0;
                    load_pb <= 0;
                    clear_pb <= 0;
                    load_tb <= 0;
                    clear_tb <= 0;
                    fim_jogo <= 0;
                    // Espera botão Ba ser pressionado 
                    if (!Ba) begin
                        prox_estado <= FILTROA;
                    end else if (!Bb) begin
                        prox_estado <= FILTROB; 
                    end else begin
                         prox_estado <= ESPERA;
                    end
                end


                FILTROA: begin
                    load_pa <= 0;
                    clear_pa <= 0;
                    load_ta <= 0;
                    clear_ta <= 0;
                    load_pb <= 0;
                    clear_pb <= 0;
                    load_tb <= 0;
                    clear_tb <= 0;
                    fim_jogo <= 0;

                    if (!Ba) begin
                        prox_estado <= FILTROA;
                    end else begin
                         prox_estado <= ADD_A;
                    end
                end

                FILTROB: begin
                    load_pa <= 0;
                    clear_pa <= 0;
                    load_ta <= 0;
                    clear_ta <= 0;
                    load_pb <= 0;
                    clear_pb <= 0;
                    load_tb <= 0;
                    clear_tb <= 0;
                    fim_jogo <= 0;

                    if (!Bb) begin
                        prox_estado <= FILTROB;
                    end else begin
                         prox_estado <= ADD_B;
                    end
                end

                ADD_A: begin
                    load_pa <= 1;
                    clear_pa <= 0;
                    load_ta <= 0;
                    clear_ta <= 0;
                    load_pb <= 0;
                    clear_pb <= 0;
                    load_tb <= 0;
                    clear_tb <= 0;
                    fim_jogo <= 0;                   
                    prox_estado <= COMPARA_A;
                end

                ADD_B: begin
                    load_pa <= 0;
                    clear_pa <= 0;
                    load_ta <= 0;
                    clear_ta <= 0;
                    load_pb <= 1;
                    clear_pb <= 0;
                    load_tb <= 0;
                    clear_tb <= 0;
                    fim_jogo <= 0;                   
                    prox_estado <= COMPARA_B;
                end

                COMPARA_A: begin
                    load_pa <= 0;
                    clear_pa <= 0;
                    load_ta <= 0;
                    clear_ta <= 0;
                    load_pb <= 0;
                    clear_pb <= 0;
                    load_tb <= 0;
                    clear_tb <= 0;
                    fim_jogo <= 0;
                    if (a_igual12) begin
                        prox_estado <= TENTO_A;
                    end else begin
                        prox_estado <= ESPERA;
                    end
                end

                COMPARA_B: begin
                    load_pa <= 0;
                    clear_pa <= 0;
                    load_ta <= 0;
                    clear_ta <= 0;
                    load_pb <= 0;
                    clear_pb <= 0;
                    load_tb <= 0;
                    clear_tb <= 0;
                    fim_jogo <= 0;
                    if (b_igual12) begin
                        prox_estado <= TENTO_B;
                    end else begin
                        prox_estado <= ESPERA;
                    end
                end

                TENTO_A: begin
                    load_pa <= 0;
                    clear_pa <= 1;
                    load_ta <= 1;
                    clear_ta <= 0;
                    load_pb <= 0;
                    clear_pb <= 1;
                    load_tb <= 0;
                    clear_tb <= 0;
                    fim_jogo <= 0;
                    prox_estado <= COMPARA_TENTOA;
                end

                TENTO_B: begin
                    load_pa <= 0;
                    clear_pa <= 1;
                    load_ta <= 0;
                    clear_ta <= 0;
                    load_pb <= 0;
                    clear_pb <= 1;
                    load_tb <= 1;
                    clear_tb <= 0;
                    fim_jogo <= 0;
                    prox_estado <= COMPARA_TENTOB;
                end

                COMPARA_TENTOA : begin                   
                    load_pa <= 0;
                    clear_pa <= 0;
                    load_ta <= 0;
                    clear_ta <= 0;
                    load_pb <= 0;
                    clear_pb <= 0;
                    load_tb <= 0;
                    clear_tb <= 0;
                    fim_jogo <= 0;
                    if (ta_igual3) begin
                        prox_estado <= FINAL;
                    end else begin
                        prox_estado <= ESPERA;
                    end
                end

                COMPARA_TENTOB : begin                   
                    load_pa <= 0;
                    clear_pa <= 0;
                    load_ta <= 0;
                    clear_ta <= 0;
                    load_pb <= 0;
                    clear_pb <= 0;
                    load_tb <= 0;
                    clear_tb <= 0;
                    fim_jogo <= 0;
                    if (tb_igual3) begin
                        prox_estado <= FINAL;
                    end else begin
                        prox_estado <= ESPERA;
                    end
                end

                FINAL: begin
                    load_pa <= 0;
                    clear_pa <= 0;
                    load_ta <= 0;
                    clear_ta <= 0;
                    load_pb <= 0;
                    clear_pb <= 0;
                    load_tb <= 0;
                    clear_tb <= 0;
                    fim_jogo <= 1;
                    prox_estado <= FINAL;
                end
                
            endcase
        end
    endmodule