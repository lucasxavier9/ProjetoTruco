module datapath (
    input logic clk, reset,
    input logic load_pa, clear_pa, load_pb, clear_pb, load_ta, clear_ta, load_tb, clear_tb,
    output logic [3:0] pontos_a, pontos_b,
    output logic [1:0] tentos_a, tentos_b,
    output logic a_igual12, b_igual12, ta_igual3, tb_igual3
);
    logic [3:0] soma_pa, soma_pb;
    logic [1:0] soma_ta, soma_tb;
    
     // Pontos A
    somador somador_pa (.a(pontos_a), .b(4'd1), .soma(soma_pa));
    registrador reg_pa (.clk(clk), .reset(clear_pa), .load(load_pa), .d(soma_pa), .q(pontos_a));
    comparador comp_pa (.a(pontos_a), .igual12(a_igual12));
    
    // Pontos B
    somador somador_pb (.a(pontos_b), .b(4'd1), .soma(soma_pb));
    registrador reg_pb (.clk(clk), .reset(clear_pb), .load(load_pb), .d(soma_pb), .q(pontos_b));
    comparador comp_pb (.a(pontos_b), .igual12(b_igual12));
    
    // Tentos A
    somador somador_ta (.a2(tentos_a), .b2(2'd1), .soma2(soma_ta));
    registrador reg_ta (.clk(clk), .reset(clear_ta), .load(load_ta), .d(soma_ta), .q(tentos_a));
    comparador comp_ta (.b(tentos_a), .igual3(ta_igual3));
    
    // Tentos B
    somador somador_tb (.a2(tentos_b), .b2(2'd1), .soma2(soma_tb));
    registrador reg_tb (.clk(clk), .reset(clear_tb), .load(load_tb), .d(soma_tb), .q(tentos_b));
    comparador comp_tb (.b(tentos_b), .igual3(tb_igual3));
endmodule