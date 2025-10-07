import uvm_pkg::*;
`include "uvm_macros.svh"

// Include your UVM components
`include "AHB if.sv"
`include "AHB seq item.sv"
`include "AHB sequence.sv"
`include "AHB driver.sv"
`include "AHB sequencer.sv"
`include "AHB agent.sv"
`include "AHB env.sv"
`include "AHB test.sv"

// DUT module include
`include "DUT.sv"
module top;

  logic HCLK;
  logic HRESETn;

  // Clock generation
  initial HCLK = 0;
  always #5 HCLK = ~HCLK;

  // Reset generation
  initial begin
    HRESETn = 0;
    #20 HRESETn = 1;
  end

  // Interface instantiation
  ahb_if vif(HCLK, HRESETn);

  // DUT instantiation
  ahb_slave dut (
    .HCLK      (vif.HCLK),
    .HRESETn   (vif.HRESETn),
    .HADDR     (vif.HADDR),
    .HWDATA    (vif.HWDATA),
    .HRDATA    (vif.HRDATA),
    .HWRITE    (vif.HWRITE),
    .HTRANS    (vif.HTRANS),
    .HSEL      (vif.HSEL),
    .HREADY    (vif.HREADY),
    .HREADYOUT (vif.HREADYOUT),
    .HRESP     (vif.HRESP)
  );

  // UVM test start
  initial begin
        uvm_config_db#(virtual ahb_if)::set(null, "*", "vif", vif);
         $display("VIF value= %p", vif);
    run_test("ahb_test");
  end

endmodule

