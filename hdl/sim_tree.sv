// sim_tree
`timescale 1ns / 1ps

module sim_tree;
  logic clk;
  logic reset;

 logic[31:0] valarr[8];
 logic[2:0] out;
 assign valarr = {8,9,6,1,5,5,7,6};
  tree tree (
    .values(valarr),
    .out(out)
  );

  // clock and reset
  initial begin
    $display($time, " << Starting the Simulation >>");

    reset = 1;
    clk   = 0;
    #15 reset = 0;
  end

  always #10 begin
    clk = ~clk;
    if (clk) $display(">>>>>>>>>>>>> clk posedge", $time);
  end

  initial begin
    $dumpfile("sim_tree.fst");
    $dumpvars;
    #100000;
    $finish;
  end

endmodule
