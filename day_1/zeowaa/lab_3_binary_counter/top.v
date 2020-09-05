`include "config.vh"

module top
(
    input         clk,
    input  [ 3:0] key,
    input  [ 7:0] sw,
    output [11:0] led,

    output [ 7:0] abcdefgh,
    output [ 7:0] digit,

    output        buzzer,

    output        vsync,
    output        hsync,
    output [ 2:0] rgb,

    inout  [18:0] gpio
);

    wire reset = ~ key [3];

    assign abcdefgh = 8'hff;
    assign digit    = 8'hff;
    assign buzzer   = 1'b1;
    assign hsync    = 1'b1;
    assign vsync    = 1'b1;
    assign rgb      = 3'b0;

    // Exercise 1: Free running counter.
    // How do you change the speed of LED blinking?
    // Try different bit slices to display.

    reg [31:0] cnt;
    
    always @ (posedge clk or posedge reset)
      if (reset)
        cnt <= 32'b0;
      else
        cnt <= cnt + 32'b1;
        
    assign led = ~ cnt [31:20];

    // Exercise 2: Key-controlled counter.
    // Comment out the code above.
    // Uncomment and synthesized the following code.
    // Press the key to see the counter incrementing.
    // Notice that the increment is not always 1.
    // Why? Hint: google "switch bounce" and "debouncing".

    /*

    reg key_r;
    
    always @ (posedge clk or posedge reset)
      if (reset)
        key_r <= 1'b0;
      else
        key_r <= key [0];
        
    wire key_pressed = ~ key [0] & key_r;

    reg [11:0] cnt;

    always @ (posedge clk or posedge reset)
      if (reset)
        cnt <= 12'b0;
      else if (key_pressed)
        cnt <= cnt + 12'b1;
        
    assign led = ~ cnt;
    
    */

    // Exercise 3 (advanced): Instantiate ../../common/sync_and_debounce.v
    // module to de-bounce the key. Or write the debouncer by yourself.

endmodule