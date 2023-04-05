module top (
    output reg LED0,
    output reg LED1,
    output reg LED2,
    output reg LED3,
    output reg LED4,
    output reg LED5,
    output reg LED6,
    output reg LED7,
);

    // Initialize internal high speed clock source
    wire clk;
    SB_HFOSC u_hfosc (
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF  (clk)
    );
    // 0b00 = 48 MHz, 0b01 = 24 MHz, 0b10 = 12 MHz, 0b11 = 6 MHz
    defparam u_hfosc.CLKHF_DIV = "0b11";

    // Register (memory/flip-flop) for a counter
    reg [31:0] counter;

    reg [ 3:0] counter1;

    always @(posedge clk) begin
        // If the counter reached 1200000 (200 ms), reset it, else
        // increment counter on every positive edge of clk
        if (counter > 2400000) counter <= 0;
        else counter <= counter + 1;
        if (counter1 > 7) counter1 <= 0;
        else if (counter == 1200000) counter1 <= counter1 + 1;

        // If the counter is larger than 600000 (100 ms), turn on led,
        // else turn it off
        if (counter > 1200000) begin
            if (counter1 == 0) LED0 <= 0;
            else if (counter1 == 1) LED1 <= 0;
            else if (counter1 == 2) LED2 <= 0;
            else if (counter1 == 3) LED3 <= 0;
            else if (counter1 == 4) LED4 <= 0;
            else if (counter1 == 5) LED5 <= 0;
            else if (counter1 == 6) LED6 <= 0;
            else if (counter1 == 7) LED7 <= 0;
        end else begin
            LED0 <= 1;
            LED1 <= 1;
            LED2 <= 1;
            LED3 <= 1;
            LED4 <= 1;
            LED5 <= 1;
            LED6 <= 1;
            LED7 <= 1;
        end
    end
endmodule
