`timescale 1ns / 1ps


module fpga_tree
(
    input sysclk,
    input logic sw,
    input logic [2:0] btn,
    output logic [2:0] led
);
  logic reset;
  logic clk;
  logic locked;
  logic [20:0] counter;
  assign reset = sw;
  clk_wiz_0 clk_gen (
      // Clock in ports
      .clk_in1(sysclk),
      // Clock out ports
      .clk_out1(clk),
      // Status and control signals
      .reset(reset),
      .locked
  );
 logic[31:0] valarr[8];
 logic[2:0] idx;
 logic[2:0] out;
 
 tree tree (
    .values(valarr),
    .out(out)
 );
 
 // observe the out values somehow to force full synthesis.
 assign led = out;

  always_ff @(posedge clk) begin
    if (reset) begin
      counter <= 0;
      idx <= 0;
      valarr <= {7,4,3,7,5,6,7,8};
    end
    else begin
      counter <= counter + 1;
      if (counter == 0) begin
      // this makes the input array non-constant forcing the synthesis of the tree.
        valarr[idx] <= btn;
        idx <= idx + 1;
      end
    end
  end
endmodule
