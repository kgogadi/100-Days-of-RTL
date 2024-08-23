module day1_tb ();

  logic [7:0] a_i;
  logic [7:0] b_i;
  logic       sel_i;
  logic [7:0] y_o;

  // Instantiate the DUT (Device Under Test)
  day1 DAY1 (.*);

  // Dumpfile and Dumpvars for waveform generation
  initial begin
    $dumpfile("dump.vcd");  // Specify the name of the VCD file
    $dumpvars(0, day1_tb);  // Dump all variables in the testbench (including DUT)
  end

  initial begin
    // Display header
    $display("Time\t a_i\t b_i\t sel_i\t y_o");

    // Loop to apply random inputs
    for (int i = 0; i < 10; i++) begin
      a_i   = $urandom_range(0, 8'hFF);
      b_i   = $urandom_range(0, 8'hFF);
      sel_i = $random % 2;
      #5;

      // Display inputs and output
      $display("%0t\t %h\t %h\t %b\t %h", $time, a_i, b_i, sel_i, y_o);

      // Check the output with an assertion
      if (sel_i == 0)
        assert(y_o == a_i) else $error("Mismatch: Expected y_o = %h, Got y_o = %h", a_i, y_o);
      if (sel_i == 1)
        assert(y_o == b_i) else $error("Mismatch: Expected y_o = %h, Got y_o = %h", b_i, y_o);
    end
    
    // End simulation
    $finish();
  end

endmodule
