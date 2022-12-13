module top (
    output wire LED_R,
    output wire LED_G,
    output wire LED_B
);

    wire        clk;
    reg  [27:0] counter;

    SB_HFOSC u_hfosc (
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF  (clk)
    );

    always @(posedge clk) begin
        counter <= counter + 1;
    end

    SB_RGBA_DRV rgb_driver (
        .RGBLEDEN(1'b1),
        .RGB0PWM(counter[25] & counter[24]),
        .RGB1PWM(counter[25] & ~counter[24]),
        .RGB2PWM(~counter[25] & counter[24]),
        .CURREN(1'b1),
        .RGB0(LED_G),
        .RGB1(LED_B),
        .RGB2(LED_R)
    );

    defparam rgb_driver.RGB0_CURRENT = "0b000001";
        defparam rgb_driver.RGB1_CURRENT = "0b000001";
        defparam rgb_driver.RGB2_CURRENT = "0b000001";

endmodule
