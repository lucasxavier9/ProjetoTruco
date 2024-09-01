module debounce (
    input logic clk,
    input logic rst,
    input logic button,
    output logic button_clean
);
    logic [15:0] counter;
    logic button_sync, button_sync_d;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            counter <= 16'd0;
            button_clean <= 1'b0;
            button_sync <= 1'b0;
            button_sync_d <= 1'b0;
        end else begin
            button_sync <= button;
            button_sync_d <= button_sync;

            // Contador de debounce
            if (button_sync == button_sync_d) begin
                if (counter < 16'd200000) begin
                    counter <= counter + 1;
                end else begin
                    button_clean <= button_sync_d;
                end
            end else begin
                counter <= 16'd0;
            end
        end
    end
endmodule
