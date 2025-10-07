// Interface
interface ahb_if(input logic HCLK, input logic HRESETn);
  logic [31:0] HADDR;
  logic [31:0] HWDATA;
  logic [31:0] HRDATA;
  logic        HWRITE;
  logic [1:0]  HTRANS;
  logic        HSEL;
  logic        HREADY;
  logic        HREADYOUT;
  logic [1:0]  HRESP;

  // Clocking block for driver
  clocking cb @(posedge HCLK);
    default input #1ns output #1ns;
    output HADDR, HWDATA, HWRITE, HTRANS, HSEL, HREADY;
    input  HRDATA, HREADYOUT, HRESP;
  endclocking

endinterface